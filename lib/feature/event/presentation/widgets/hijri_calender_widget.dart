import 'package:flutter/material.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

// ═════════════════════════════════════════════════════════════════════════════
// HIJRI CALENDAR WIDGET
//
// Drop-in calendar widget that shows a navigable Hijri month grid with:
//  - Gregorian day number (large) + Hijri day number (small) in each cell
//  - New Hijri month label on day 1
//  - Islamic event dots (Eid, Ramadan, Ashura, etc.)
//  - Selected-day detail strip (Hijri + Gregorian + event badge)
//  - Prev/Next month navigation
//  - Optional Arabic month name toggle
//
// USAGE in your EventsScreen — replace _buildCalendarCard() with:
//
//   HijriCalendarWidget(
//     onDaySelected: (gregorianDate, hijriDate) {
//       // handle selection
//     },
//   )
//
// Or with all options:
//
//   HijriCalendarWidget(
//     primaryColor: AppColors.kPrimary,
//     cardColor: AppColors.kCard,
//     borderColor: AppColors.kBorder,
//     textColor: AppColors.kText,
//     subTextColor: AppColors.kSubText,
//     showArabicToggle: true,
//     showDetailStrip: true,
//     onDaySelected: (greg, hijri) { ... },
//   )
// ═════════════════════════════════════════════════════════════════════════════

// ─── Hijri date model ─────────────────────────────────────────────────────────
class HijriDateInfo {
  final int year, month, day;
  const HijriDateInfo(this.year, this.month, this.day);

  static const List<String> _monthNames = [
    'Muharram',
    'Safar',
    "Rabi' al-Awwal",
    "Rabi' al-Thani",
    'Jumada al-Awwal',
    'Jumada al-Thani',
    'Rajab',
    "Sha'ban",
    'Ramadan',
    'Shawwal',
    "Dhu al-Qi'dah",
    'Dhu al-Hijjah',
  ];

  static const List<String> _monthNamesAr = [
    'محرم',
    'صفر',
    'ربيع الأول',
    'ربيع الثاني',
    'جمادى الأولى',
    'جمادى الثانية',
    'رجب',
    'شعبان',
    'رمضان',
    'شوال',
    'ذو القعدة',
    'ذو الحجة',
  ];

  static const Map<String, String> _specialDays = {
    '1-1': 'Islamic New Year',
    '1-10': 'Ashura',
    '3-12': 'Mawlid al-Nabi ﷺ',
    '7-27': "Laylat al-Mi'raj",
    '8-15': "Laylat al-Bara'ah",
    '9-1': 'First of Ramadan',
    '9-27': 'Laylat al-Qadr',
    '10-1': 'Eid al-Fitr 🎉',
    '12-9': 'Day of Arafah',
    '12-10': 'Eid al-Adha 🐑',
  };

  String get monthName => _monthNames[month - 1];
  String get monthNameAr => _monthNamesAr[month - 1];
  String? get specialEvent => _specialDays['$month-$day'];

  static HijriDateInfo fromGregorian(DateTime date) {
    final h = HijriCalendarConfig.fromGregorian(date);
    return HijriDateInfo(h.hYear, h.hMonth, h.hDay);
  }

  static int daysInMonth(int year, int month) =>
      HijriCalendarConfig().getDaysInMonth(year, month);

  /// Weekday of the 1st of a Hijri month. Returns 0=Mon … 6=Sun
  static int startWeekday(int year, int month) {
    final greg = HijriCalendarConfig().hijriToGregorian(year, month, 1);
    return greg.weekday - 1; // DateTime.weekday is 1=Mon…7=Sun
  }

  static DateTime toGregorian(int hYear, int hMonth, int hDay) =>
      HijriCalendarConfig().hijriToGregorian(hYear, hMonth, hDay);
}

// ─── The widget ───────────────────────────────────────────────────────────────
class HijriCalendarWidget extends StatefulWidget {
  /// Called whenever the user taps a day.
  final void Function(DateTime gregorianDate, HijriDateInfo hijriDate)?
  onDaySelected;

  // ── Theming — defaults match the mosque_finder dark theme ──────────────────
  final Color primaryColor;
  final Color cardColor;
  final Color borderColor;
  final Color textColor;
  final Color subTextColor;
  final Color backgroundColor;
  final Color eventDotColor;

  /// Show the Arabic / English toggle button in the header.
  final bool showArabicToggle;

  /// Show the selected-day detail strip below the grid.
  final bool showDetailStrip;

  /// Pre-select a specific Gregorian date on first render.
  final DateTime? initialSelectedDate;

  const HijriCalendarWidget({
    super.key,
    this.onDaySelected,
    this.primaryColor = const Color(0xFF534AB7),
    this.cardColor = const Color(0xFF1E1E2E),
    this.borderColor = const Color(0xFF2E2E3E),
    this.textColor = Colors.white,
    this.subTextColor = const Color(0xFF9E9EAF),
    this.backgroundColor = Colors.transparent,
    this.eventDotColor = const Color(0xFFEF9F27),
    this.showArabicToggle = true,
    this.showDetailStrip = true,
    this.initialSelectedDate,
  });

  @override
  State<HijriCalendarWidget> createState() => _HijriCalendarWidgetState();
}

class _HijriCalendarWidgetState extends State<HijriCalendarWidget> {
  late int _viewHYear;
  late int _viewHMonth;
  late int _selectedHDay;
  late HijriDateInfo _todayHijri;
  bool _showArabic = false;

  static const List<String> _weekLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  static const List<String> _gregMonthShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  void initState() {
    super.initState();
    final now = HijriCalendarConfig.now();
    _todayHijri = HijriDateInfo(now.hYear, now.hMonth, now.hDay);

    if (widget.initialSelectedDate != null) {
      final h = HijriDateInfo.fromGregorian(widget.initialSelectedDate!);
      _viewHYear = h.year;
      _viewHMonth = h.month;
      _selectedHDay = h.day;
    } else {
      _viewHYear = _todayHijri.year;
      _viewHMonth = _todayHijri.month;
      _selectedHDay = _todayHijri.day;
    }
  }

  bool get _isViewingCurrentMonth =>
      _viewHYear == _todayHijri.year && _viewHMonth == _todayHijri.month;

  void _prevMonth() => setState(() {
    if (_viewHMonth == 1) {
      _viewHYear--;
      _viewHMonth = 12;
    } else {
      _viewHMonth--;
    }
    _selectedHDay = 1;
  });

  void _nextMonth() => setState(() {
    if (_viewHMonth == 12) {
      _viewHYear++;
      _viewHMonth = 1;
    } else {
      _viewHMonth++;
    }
    _selectedHDay = 1;
  });

  void _selectDay(int day) {
    setState(() => _selectedHDay = day);
    if (widget.onDaySelected != null) {
      final greg = HijriDateInfo.toGregorian(_viewHYear, _viewHMonth, day);
      final hijri = HijriDateInfo(_viewHYear, _viewHMonth, day);
      widget.onDaySelected!(greg, hijri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalDays = HijriDateInfo.daysInMonth(_viewHYear, _viewHMonth);
    final startOffset = HijriDateInfo.startWeekday(_viewHYear, _viewHMonth);
    final monthLabel = _showArabic
        ? '${HijriDateInfo(_viewHYear, _viewHMonth, 1).monthNameAr} $_viewHYear'
        : '${HijriDateInfo(_viewHYear, _viewHMonth, 1).monthName} $_viewHYear AH';

    return Container(
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(monthLabel, totalDays),
          _buildWeekdayRow(),
          _buildGrid(totalDays, startOffset),
          if (widget.showDetailStrip) _buildDetailStrip(totalDays),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader(String monthLabel, int totalDays) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monthLabel,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  '$totalDays days · Islamic Calendar',
                  style: TextStyle(color: widget.subTextColor, fontSize: 11.5),
                ),
              ],
            ),
          ),

          // Today pill (only when viewing current month)
          if (_isViewingCurrentMonth)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: widget.primaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.primaryColor.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                '${_todayHijri.day} / $totalDays',
                style: TextStyle(
                  color: widget.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // Arabic toggle
          if (widget.showArabicToggle) ...[
            _navBtn(
              child: Text(
                'ع',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _showArabic
                      ? widget.primaryColor
                      : widget.subTextColor,
                ),
              ),
              onTap: () => setState(() => _showArabic = !_showArabic),
            ),
            const SizedBox(width: 4),
          ],

          _navBtn(
            child: Icon(
              Icons.chevron_left_rounded,
              color: widget.subTextColor,
              size: 18,
            ),
            onTap: _prevMonth,
          ),
          const SizedBox(width: 4),
          _navBtn(
            child: Icon(
              Icons.chevron_right_rounded,
              color: widget.subTextColor,
              size: 18,
            ),
            onTap: _nextMonth,
          ),
        ],
      ),
    );
  }

  Widget _navBtn({required Widget child, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: widget.borderColor),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  // ── Weekday row ──────────────────────────────────────────────────────────────
  Widget _buildWeekdayRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _weekLabels.map((d) {
          final isFri = d == 'Fri';
          return SizedBox(
            width: 36,
            child: Text(
              d,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isFri ? widget.primaryColor : widget.subTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Calendar grid ────────────────────────────────────────────────────────────
  Widget _buildGrid(int totalDays, int startOffset) {
    final totalCells = startOffset + totalDays;
    final rows = (totalCells / 7).ceil();

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
      child: Column(
        children: List.generate(rows, (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (col) {
              final cellIndex = row * 7 + col;
              final day = cellIndex - startOffset + 1;

              if (day < 1 || day > totalDays) {
                return const SizedBox(width: 36, height: 44);
              }

              final isToday = _isViewingCurrentMonth && day == _todayHijri.day;
              final isSelected = day == _selectedHDay;
              final hasEvent =
                  HijriDateInfo(0, _viewHMonth, day).specialEvent != null;
              final isFriday = col == 4; // Mon=0 … Fri=4

              // Compute the Gregorian day to show in the cell
              final gregDate = HijriDateInfo.toGregorian(
                _viewHYear,
                _viewHMonth,
                day,
              );
              final hijriOfNextDay = day < totalDays
                  ? HijriDateInfo(_viewHYear, _viewHMonth, day + 1)
                  : null;
              // Show new Hijri month label if the next day resets to 1
              // (i.e. this is last day and crosses a month boundary — rare edge)
              // More useful: show it on day 1
              final isFirstOfHijriMonth = day == 1;

              Color bgColor = Colors.transparent;
              Color dayNumColor = widget.textColor;
              Color gregNumColor = widget.subTextColor;
              BorderSide borderSide = BorderSide.none;

              if (!isToday && !isSelected && isFriday) {
                dayNumColor = widget.primaryColor.withValues(alpha: 0.85);
              }
              if (isSelected && !isToday) {
                bgColor = widget.primaryColor.withValues(alpha: 0.18);
                dayNumColor = widget.primaryColor;
                gregNumColor = widget.primaryColor.withValues(alpha: 0.7);
                borderSide = BorderSide(
                  color: widget.primaryColor.withValues(alpha: 0.5),
                );
              }
              if (isToday) {
                bgColor = widget.primaryColor;
                dayNumColor = Colors.white;
                gregNumColor = Colors.white.withValues(alpha: 0.75);
                borderSide = BorderSide.none;
              }

              return GestureDetector(
                onTap: () => _selectDay(day),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 36,
                  height: 50,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.fromBorderSide(borderSide),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Hijri day (large / primary)
                            Text(
                              '$day',
                              style: TextStyle(
                                color: dayNumColor,
                                fontSize: 14,
                                fontWeight: (isToday || isSelected || hasEvent)
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
                            ),
                            // Gregorian day (small / secondary)
                            Text(
                              '${gregDate.day}',
                              style: TextStyle(
                                color: gregNumColor,
                                fontSize: 9.5,
                              ),
                            ),
                            // New Hijri month label
                            if (isFirstOfHijriMonth)
                              Text(
                                _showArabic
                                    ? HijriDateInfo(
                                        _viewHYear,
                                        _viewHMonth,
                                        1,
                                      ).monthNameAr.split(' ').first
                                    : HijriDateInfo(
                                        _viewHYear,
                                        _viewHMonth,
                                        1,
                                      ).monthName.split(' ').first,
                                style: TextStyle(
                                  fontSize: 6.5,
                                  color: isToday
                                      ? Colors.white.withValues(alpha: 0.85)
                                      : widget.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                          ],
                        ),
                      ),
                      // Event dot
                      if (hasEvent)
                        Positioned(
                          bottom: 3,
                          right: 4,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isToday
                                  ? Colors.white.withValues(alpha: 0.8)
                                  : widget.eventDotColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  // ── Selected-day detail strip ────────────────────────────────────────────────
  Widget _buildDetailStrip(int totalDays) {
    final greg = HijriDateInfo.toGregorian(
      _viewHYear,
      _viewHMonth,
      _selectedHDay,
    );
    final gregStr =
        '${greg.day} ${_gregMonthShort[greg.month - 1]} ${greg.year}';
    final hijriInfo = HijriDateInfo(_viewHYear, _viewHMonth, _selectedHDay);
    final event = hijriInfo.specialEvent;
    final monthLabel = _showArabic
        ? hijriInfo.monthNameAr
        : hijriInfo.monthName;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: widget.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.primaryColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Text('🌙', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$_selectedHDay $monthLabel $_viewHYear AH',
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  gregStr,
                  style: TextStyle(color: widget.subTextColor, fontSize: 11),
                ),
              ],
            ),
          ),
          if (event != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFAEEDA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFEF9F27).withValues(alpha: 0.45),
                ),
              ),
              child: Text(
                event,
                style: const TextStyle(
                  color: Color(0xFF633806),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
