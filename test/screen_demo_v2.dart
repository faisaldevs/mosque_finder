import 'package:flutter/material.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

void main() {
  runApp(const HijriCalendarApp());
}

class HijriCalendarApp extends StatelessWidget {
  const HijriCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hijri Calendar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF534AB7),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF534AB7),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const CalendarPage(),
    );
  }
}

// ─────────────────────────────────────────────
//  HIJRI CONVERSION HELPER
// ─────────────────────────────────────────────
class HijriDate {
  final int year, month, day;
  const HijriDate(this.year, this.month, this.day);

  static const List<String> monthNames = [
    'Muharram', 'Safar', 'Rabi al-Awwal', 'Rabi al-Thani',
    'Jumada al-Awwal', 'Jumada al-Thani', 'Rajab', "Sha'ban",
    'Ramadan', 'Shawwal', "Dhu al-Qadah", 'Dhu al-Hijjah',
  ];

  static const List<String> monthNamesAr = [
    'محرم', 'صفر', 'ربيع الأول', 'ربيع الثاني',
    'جمادى الأولى', 'جمادى الثانية', 'رجب', 'شعبان',
    'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة',
  ];

  String get monthName => monthNames[month - 1];
  String get monthNameAr => monthNamesAr[month - 1];

  static HijriDate fromGregorian(DateTime date) {
    final h = HijriCalendarConfig.fromGregorian(date);
    return HijriDate(h.hYear, h.hMonth, h.hDay);
  }

  // Special Islamic dates (month-day -> label)
  static const Map<String, String> specialDays = {
    '1-1': 'Islamic New Year',
    '1-10': 'Ashura',
    '3-12': 'Mawlid al-Nabi ﷺ',
    '7-27': "Laylat al-Mi'raj",
    '8-15': 'Laylat al-Bara\'ah',
    '9-1': 'First of Ramadan',
    '9-27': 'Laylat al-Qadr',
    '10-1': 'Eid al-Fitr 🎉',
    '12-10': 'Eid al-Adha 🐑',
    '12-9': 'Day of Arafah',
  };

  String? get specialEvent => specialDays['$month-$day'];
}

// ─────────────────────────────────────────────
//  MAIN CALENDAR PAGE
// ─────────────────────────────────────────────
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _viewDate;
  late DateTime _today;
  DateTime? _selected;
  bool _showArabic = false;

  static const List<String> _weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const List<String> _gregMonths = [
    'January','February','March','April','May','June',
    'July','August','September','October','November','December',
  ];

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _viewDate = DateTime(_today.year, _today.month, 1);
  }

  void _prevMonth() => setState(() {
    _viewDate = DateTime(_viewDate.year, _viewDate.month - 1, 1);
    _selected = null;
  });

  void _nextMonth() => setState(() {
    _viewDate = DateTime(_viewDate.year, _viewDate.month + 1, 1);
    _selected = null;
  });

  void _goToday() => setState(() {
    _viewDate = DateTime(_today.year, _today.month, 1);
    _selected = _today;
  });

  List<DateTime?> _buildCalendarDays() {
    final firstWeekday = _viewDate.weekday % 7; // Sun=0
    final daysInMonth = DateUtils.getDaysInMonth(_viewDate.year, _viewDate.month);
    final List<DateTime?> cells = [];

    // Leading nulls for days from previous month
    for (int i = 0; i < firstWeekday; i++) {
      final prevMonth = DateTime(_viewDate.year, _viewDate.month - 1, 1);
      final prevDays = DateUtils.getDaysInMonth(prevMonth.year, prevMonth.month);
      cells.add(DateTime(prevMonth.year, prevMonth.month, prevDays - firstWeekday + 1 + i));
    }
    for (int d = 1; d <= daysInMonth; d++) {
      cells.add(DateTime(_viewDate.year, _viewDate.month, d));
    }
    while (cells.length < 42) {
      final next = cells.length - firstWeekday - daysInMonth + 1;
      final nm = DateTime(_viewDate.year, _viewDate.month + 1, next);
      cells.add(nm);
    }
    return cells;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cells = _buildCalendarDays();
    final daysInMonth = DateUtils.getDaysInMonth(_viewDate.year, _viewDate.month);

    // Hijri month range for subtitle
    final hijriStart = HijriDate.fromGregorian(DateTime(_viewDate.year, _viewDate.month, 1));
    final hijriEnd = HijriDate.fromGregorian(DateTime(_viewDate.year, _viewDate.month, daysInMonth));
    final hijriSubtitle = hijriStart.month == hijriEnd.month
        ? '${_showArabic ? hijriStart.monthNameAr : hijriStart.monthName} ${hijriStart.year} AH'
        : '${_showArabic ? hijriStart.monthNameAr : hijriStart.monthName} / ${_showArabic ? hijriEnd.monthNameAr : hijriEnd.monthName} ${hijriEnd.year} AH';

    final purpleLight = const Color(0xFFEEEDFE);
    final purpleMid = const Color(0xFF534AB7);
    final purpleDark = const Color(0xFF3C3489);

    return Scaffold(
      backgroundColor: isDark ? scheme.surface : const Color(0xFFF8F7FF),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── App Bar ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_gregMonths[_viewDate.month - 1]} ${_viewDate.year}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            hijriSubtitle,
                            style: TextStyle(
                              fontSize: 13,
                              color: purpleMid,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Arabic toggle
                    _IconBtn(
                      tooltip: 'Toggle Arabic',
                      onTap: () => setState(() => _showArabic = !_showArabic),
                      child: Text(
                        'ع',
                        style: TextStyle(
                          fontSize: 18,
                          color: _showArabic ? purpleMid : scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    _IconBtn(
                      tooltip: 'Today',
                      onTap: _goToday,
                      child: Text('Today', style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
                    ),
                    const SizedBox(width: 6),
                    _IconBtn(tooltip: 'Previous', onTap: _prevMonth, child: const Icon(Icons.chevron_left, size: 20)),
                    const SizedBox(width: 4),
                    _IconBtn(tooltip: 'Next', onTap: _nextMonth, child: const Icon(Icons.chevron_right, size: 20)),
                  ],
                ),
              ),
            ),

            // ── Weekday headers ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: _weekDays.map((d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: d == 'Fri' ? purpleMid : scheme.onSurfaceVariant,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),

            // ── Calendar Grid ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: cells.length,
                  itemBuilder: (ctx, i) {
                    final date = cells[i]!;
                    final isCurrentMonth = date.month == _viewDate.month;
                    final isToday = DateUtils.isSameDay(date, _today);
                    final isSelected = _selected != null && DateUtils.isSameDay(date, _selected!);
                    final hijri = HijriDate.fromGregorian(date);
                    final isNewHijriMonth = hijri.day == 1;
                    final hasEvent = hijri.specialEvent != null;

                    Color bg = Colors.transparent;
                    Color dayColor = isCurrentMonth ? scheme.onSurface : scheme.onSurface.withOpacity(0.3);
                    Color hijriColor = isCurrentMonth
                        ? scheme.onSurfaceVariant.withOpacity(0.7)
                        : scheme.onSurfaceVariant.withOpacity(0.25);
                    Border? border;

                    if (isToday && !isSelected) {
                      border = Border.all(color: purpleMid, width: 1.5);
                      dayColor = purpleMid;
                    }
                    if (isSelected) {
                      bg = purpleMid;
                      dayColor = Colors.white;
                      hijriColor = Colors.white.withOpacity(0.8);
                    }

                    return GestureDetector(
                      onTap: () => setState(() => _selected = date),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(10),
                          border: border,
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isToday || isSelected ? FontWeight.w600 : FontWeight.w400,
                                      color: dayColor,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${hijri.day}',
                                    style: TextStyle(fontSize: 10, color: hijriColor),
                                  ),
                                  if (isNewHijriMonth && isCurrentMonth)
                                    Text(
                                      _showArabic
                                          ? hijri.monthNameAr.split(' ').first
                                          : hijri.monthName.split(' ').first,
                                      style: TextStyle(
                                        fontSize: 7,
                                        color: isSelected ? Colors.white.withOpacity(0.9) : purpleMid,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                ],
                              ),
                            ),
                            // Event dot
                            if (hasEvent && isCurrentMonth)
                              Positioned(
                                bottom: 4,
                                right: 5,
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : const Color(0xFFEF9F27),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── Detail Card ──
            if (_selected != null)
              SliverToBoxAdapter(
                child: _DetailCard(
                  date: _selected!,
                  showArabic: _showArabic,
                  scheme: scheme,
                  isDark: isDark,
                ),
              ),

            // ── Legend ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFEF9F27), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text('Islamic event', style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
                    const SizedBox(width: 16),
                    Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(color: purpleMid, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text('Today', style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
                    const SizedBox(width: 16),
                    Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(color: purpleMid, borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(width: 6),
                    Text('Selected', style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DETAIL CARD WIDGET
// ─────────────────────────────────────────────
class _DetailCard extends StatelessWidget {
  final DateTime date;
  final bool showArabic;
  final ColorScheme scheme;
  final bool isDark;

  const _DetailCard({
    required this.date,
    required this.showArabic,
    required this.scheme,
    required this.isDark,
  });

  static const List<String> _weekDaysFull = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  static const List<String> _gregMonths = [
    'January','February','March','April','May','June',
    'July','August','September','October','November','December',
  ];

  @override
  Widget build(BuildContext context) {
    final hijri = HijriDate.fromGregorian(date);
    final purpleMid = const Color(0xFF534AB7);
    final purpleLight = isDark ? const Color(0xFF3C3489) : const Color(0xFFEEEDFE);
    final dayName = _weekDaysFull[date.weekday - 1];
    final event = hijri.specialEvent;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant.withOpacity(0.5)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$dayName, ${_gregMonths[date.month - 1]} ${date.day}, ${date.year}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: scheme.onSurface),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _InfoBlock(
                    label: 'Gregorian',
                    value: '${date.day} ${_gregMonths[date.month - 1]}',
                    sub: '${date.year}',
                    bg: isDark ? scheme.surfaceContainerHigh : const Color(0xFFF3F2FF),
                    textColor: scheme.onSurface,
                    subColor: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoBlock(
                    label: showArabic ? 'التاريخ الهجري' : 'Hijri',
                    value: showArabic
                        ? '${hijri.day} ${hijri.monthNameAr}'
                        : '${hijri.day} ${hijri.monthName}',
                    sub: '${hijri.year} AH',
                    bg: purpleLight,
                    textColor: isDark ? Colors.white : const Color(0xFF3C3489),
                    subColor: isDark ? Colors.white70 : const Color(0xFF534AB7),
                  ),
                ),
              ],
            ),
            if (event != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAEEDA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text('🌙', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        event,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF633806),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  REUSABLE WIDGETS
// ─────────────────────────────────────────────
class _InfoBlock extends StatelessWidget {
  final String label, value, sub;
  final Color bg, textColor, subColor;

  const _InfoBlock({
    required this.label,
    required this.value,
    required this.sub,
    required this.bg,
    required this.textColor,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: subColor, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor)),
          Text(sub, style: TextStyle(fontSize: 12, color: subColor)),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final String tooltip;

  const _IconBtn({required this.child, required this.onTap, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: scheme.outlineVariant.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}