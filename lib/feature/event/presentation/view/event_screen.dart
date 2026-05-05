import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

// ─── Category model ───────────────────────────────────────────────────────────
class _Category {
  final String id, label, emoji;
  final Color color;
  const _Category(this.id, this.label, this.emoji, this.color);
}

const _categories = [
  _Category('all', 'All Events', '🗓️', AppColors.kPrimary),
  _Category('ramadan', 'Ramadan', '🌙', AppColors.kPrimary),
  _Category('eid', 'Eid', '🎉', AppColors.kPink),
  _Category('jumuah', "Jumu'ah", '🕌', AppColors.kTeal),
  _Category('lecture', 'Lectures', '📚', AppColors.kBlue),
  _Category('charity', 'Charity', '❤️', AppColors.kRed),
  _Category('youth', 'Youth', '⚽', AppColors.kOrange),
  _Category('sisters', 'Sisters', '🌸', AppColors.kDeepPurple),
];

// ─── Event model ──────────────────────────────────────────────────────────────
class _Event {
  final String id, title, categoryId, hijriDate, gregorianDate;
  final String time, location, description;
  final int attending;
  final bool featured;
  final Color color;
  bool rsvpd;

  _Event({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.hijriDate,
    required this.gregorianDate,
    required this.time,
    required this.location,
    required this.description,
    required this.attending,
    required this.color,
    this.featured = false,
    this.rsvpd = false,
  });
}

List<_Event> _buildEvents() => [
  _Event(
    id: '1',
    title: 'Ramadan Iftar Gathering',
    categoryId: 'ramadan',
    hijriDate: '8 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 5, 2026',
    time: '6:30 PM',
    location: 'Central Masjid',
    attending: 150,
    description:
        'Join us for a community Iftar gathering. All are welcome. Light refreshments will be provided after Maghrib prayer.',
    color: AppColors.kPrimary,
    featured: true,
  ),
  _Event(
    id: '2',
    title: "Jumu'ah Khutbah — Unity in Islam",
    categoryId: 'jumuah',
    hijriDate: '9 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 9, 2026',
    time: '1:00 PM',
    location: 'Baitul Mukarram',
    attending: 800,
    description:
        'Weekly Friday prayer and khutbah. Topic: Unity and brotherhood in the Muslim Ummah.',
    color: AppColors.kTeal,
  ),
  _Event(
    id: '3',
    title: 'Taraweeh Special Program',
    categoryId: 'ramadan',
    hijriDate: '13 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 10, 2026',
    time: '8:00 PM',
    location: 'Al-Noor Mosque',
    attending: 200,
    description:
        'Special Taraweeh prayers with recitation of the full Quran. Guest Imam from Egypt.',
    color: AppColors.kPrimary,
  ),
  _Event(
    id: '4',
    title: 'Islamic Finance Workshop',
    categoryId: 'lecture',
    hijriDate: '15 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 15, 2026',
    time: '10:00 AM',
    location: 'Dhaka Islamic Center',
    attending: 75,
    description:
        'A comprehensive workshop on halal investment, Zakat calculation, and interest-free banking.',
    color: AppColors.kBlue,
    featured: true,
  ),
  _Event(
    id: '5',
    title: 'Eid-ul-Fitr Celebration',
    categoryId: 'eid',
    hijriDate: '1 Shawwal 1447',
    gregorianDate: 'June 4, 2026',
    time: '7:00 AM',
    location: 'Community Center',
    attending: 500,
    description:
        'Grand Eid celebration with prayers, community feast, and activities for children. Takbeerat begin at 6:30 AM.',
    color: AppColors.kPink,
    featured: true,
  ),
  _Event(
    id: '6',
    title: 'Sisters Quran Circle',
    categoryId: 'sisters',
    hijriDate: '16 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 16, 2026',
    time: '3:00 PM',
    location: 'Islamic Women\'s Centre',
    attending: 40,
    description:
        'Weekly sisters-only Quran recitation and tafseer circle. Open to all levels.',
    color: const Color(0xFF880E4F),
  ),
  _Event(
    id: '7',
    title: 'Youth Football Tournament',
    categoryId: 'youth',
    hijriDate: '17 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 17, 2026',
    time: '9:00 AM',
    location: 'Dhaka Sports Complex',
    attending: 120,
    description:
        'Annual Islamic Youth Network football tournament. Register your team today!',
    color: AppColors.kOrange,
  ),
  _Event(
    id: '8',
    title: 'Charity Food Drive',
    categoryId: 'charity',
    hijriDate: '20 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 20, 2026',
    time: '9:00 AM – 5:00 PM',
    location: 'Multiple Locations',
    attending: 90,
    description:
        'Community charity food drive. Drop off non-perishable food items at any participating mosque.',
    color: const Color(0xFFD32F2F),
  ),
  _Event(
    id: '9',
    title: "Fiqh of Prayer — Lecture Series",
    categoryId: 'lecture',
    hijriDate: '22 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 22, 2026',
    time: '7:00 PM',
    location: 'Online + Al-Noor Mosque',
    attending: 300,
    description:
        'Part 3 of the Fiqh of Prayer series. Covering the conditions, pillars, and sunnahs of Salah.',
    color: AppColors.kBlue,
  ),
  _Event(
    id: '10',
    title: 'Eid-ul-Adha Grand Celebration',
    categoryId: 'eid',
    hijriDate: '10 Dhul-Hijjah 1447',
    gregorianDate: 'Aug 10, 2026',
    time: '6:45 AM',
    location: 'National Stadium Ground',
    attending: 2000,
    description:
        'Grand Eid-ul-Adha prayers followed by community sacrifice (Qurbani) and feast.',
    color: AppColors.kPink,
    featured: true,
  ),
];

// ─── Hijri calendar grid data ──────────────────────────────────────────────────
// Simplified: show Dhul-Qi'dah 1447 (30 days, starts Saturday col=6)
const _hijriMonthName = "Dhul-Qi'dah 1447";
const _hijriTotalDays = 30;
const _hijriStartWeekday = 6; // 0=Mon … 6=Sun → starts Saturday = index 5
// Days that have events (1-indexed)
const _eventDays = {5, 9, 10, 13, 15, 16, 17, 20, 22};

// ═════════════════════════════════════════════════════════════════════════════
// EVENTS SCREEN
// ═════════════════════════════════════════════════════════════════════════════

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<_Event> _events = _buildEvents();
  String _selectedCat = 'all';
  int _selectedDay = 8; // today
  bool _showCalendar = true;

  List<_Event> get _filtered {
    List<_Event> list = _selectedCat == 'all'
        ? _events
        : _events.where((e) => e.categoryId == _selectedCat).toList();
    // If a day is selected, try to filter; if no match keep all
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildCategoryChips()),
          if (_showCalendar) SliverToBoxAdapter(child: _buildCalendarCard()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(
                      color: AppColors.kText,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_filtered.length} events',
                    style: const TextStyle(
                      color: AppColors.kSubText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _EventCard(
                event: _filtered[i],
                onRsvp: () =>
                    setState(() => _filtered[i].rsvpd = !_filtered[i].rsvpd),
                onTap: () => _openDetail(_filtered[i]),
              ),
              childCount: _filtered.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return ClipRect(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A148C), Color(0xFFE91E63)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => nav.goBack(),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.18),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Events & Calendar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Stay connected with community activities',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.78),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                setState(() => _showCalendar = !_showCalendar),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.18),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                _showCalendar
                                    ? Icons.calendar_month_rounded
                                    : Icons.view_list_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Decorative circles — same motif as all other screens
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(top: -35, right: -35, child: _circle(160)),
                Positioned(top: 18, right: 55, child: _circle(95)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double s) => Container(
    width: s,
    height: s,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.18),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );

  // ── Category chips ───────────────────────────────────────────────────────────
  Widget _buildCategoryChips() {
    return Container(
      color: AppColors.kCard,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: _categories.map((cat) {
                final sel = cat.id == _selectedCat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCat = cat.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: sel ? cat.color : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: sel ? cat.color : AppColors.kBorder,
                        width: sel ? 0 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(cat.emoji, style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 5),
                        Text(
                          cat.label,
                          style: TextStyle(
                            color: sel ? Colors.white : AppColors.kSubText,
                            fontSize: 13,
                            fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: AppColors.kBorder),
        ],
      ),
    );
  }

  // ── Calendar card ────────────────────────────────────────────────────────────
  Widget _buildCalendarCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      _hijriMonthName,
                      style: TextStyle(
                        color: AppColors.kText,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '$_hijriTotalDays days · Islamic Calendar',
                      style: const TextStyle(
                        color: AppColors.kSubText,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.kPrimary.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    '$_selectedDay of $_hijriTotalDays',
                    style: const TextStyle(
                      color: AppColors.kPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Day-of-week headers
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                  .map(
                    (d) => SizedBox(
                      width: 36,
                      child: Text(
                        d,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.kSubText,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          // Calendar grid
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 14),
            child: _buildGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    // _hijriStartWeekday: Mon=0 … Sun=6; Dhul-Qi'dah starts on Saturday = 5
    const startOffset = 5;
    final totalCells = startOffset + _hijriTotalDays;
    final rows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(
        rows,
        (row) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (col) {
            final cellIndex = row * 7 + col;
            final day = cellIndex - startOffset + 1;
            if (day < 1 || day > _hijriTotalDays) {
              return const SizedBox(width: 36, height: 36);
            }
            final isToday = day == _selectedDay;
            final hasEvent = _eventDays.contains(day);
            return GestureDetector(
              onTap: () => setState(() => _selectedDay = day),
              child: SizedBox(
                width: 36,
                height: 44,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday
                            ? AppColors.kPrimary
                            : Colors.transparent,
                        border: isToday
                            ? null
                            : Border.all(
                                color: hasEvent
                                    ? AppColors.kPrimary.withValues(alpha: 0.4)
                                    : Colors.transparent,
                              ),
                      ),
                      child: Center(
                        child: Text(
                          '$day',
                          style: TextStyle(
                            color: isToday
                                ? Colors.white
                                : hasEvent
                                ? AppColors.kPrimary
                                : AppColors.kText,
                            fontSize: 14,
                            fontWeight: (isToday || hasEvent)
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    // Event dot
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: hasEvent
                            ? (isToday
                                  ? Colors.white.withValues(alpha: 0.7)
                                  : AppColors.kPrimary)
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _openDetail(_Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _EventDetailPage(event: event)),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// EVENT CARD
// ═════════════════════════════════════════════════════════════════════════════

class _EventCard extends StatelessWidget {
  final _Event event;
  final VoidCallback onRsvp;
  final VoidCallback onTap;
  const _EventCard({
    required this.event,
    required this.onRsvp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final e = event;
    final cat = _categories.firstWhere((c) => c.id == e.categoryId);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          color: AppColors.kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: e.featured
                ? e.color.withValues(alpha: 0.5)
                : AppColors.kBorder,
            width: e.featured ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colour accent bar
            Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [e.color, e.color.withValues(alpha: 0.4)],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured badge + category chip
                  Row(
                    children: [
                      if (e.featured) ...[
                        Icon(Icons.star_rounded, color: e.color, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Featured Event',
                          style: TextStyle(
                            color: e.color,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: cat.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: cat.color.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              cat.emoji,
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              cat.label,
                              style: TextStyle(
                                color: cat.color,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    e.title,
                    style: const TextStyle(
                      color: AppColors.kText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Info rows
                  _infoRow(Icons.calendar_today_rounded, e.hijriDate),
                  const SizedBox(height: 5),
                  _infoRow(Icons.access_time_rounded, e.time),
                  const SizedBox(height: 5),
                  _infoRow(Icons.location_on_rounded, e.location),
                  const SizedBox(height: 5),
                  _infoRow(Icons.group_rounded, '${e.attending} attending'),
                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      // Add to calendar
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: OutlinedButton.icon(
                            onPressed: () => _showAddToCalendarSnack(context),
                            icon: const Icon(
                              Icons.add_rounded,
                              size: 16,
                              color: AppColors.kSubText,
                            ),
                            label: const Text(
                              'Calendar',
                              style: TextStyle(
                                color: AppColors.kText,
                                fontSize: 13,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              side: const BorderSide(color: AppColors.kBorder),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // RSVP
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: onRsvp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: e.rsvpd
                                  ? AppColors.kCard
                                  : e.color,
                              foregroundColor: e.rsvpd ? e.color : Colors.white,
                              elevation: 0,
                              side: e.rsvpd ? BorderSide(color: e.color) : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  e.rsvpd
                                      ? Icons.check_circle_rounded
                                      : Icons.how_to_reg_rounded,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  e.rsvpd ? 'RSVP\'d ✓' : 'Register for Event',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) => Row(
    children: [
      Icon(icon, color: AppColors.kSubText, size: 14),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(color: AppColors.kSubText, fontSize: 13),
        ),
      ),
    ],
  );

  void _showAddToCalendarSnack(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('📅 "${event.title}" added to calendar'),
        backgroundColor: event.color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// EVENT DETAIL PAGE
// ═════════════════════════════════════════════════════════════════════════════

class _EventDetailPage extends StatefulWidget {
  final _Event event;
  const _EventDetailPage({required this.event});
  @override
  State<_EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<_EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    final e = widget.event;
    final cat = _categories.firstWhere((c) => c.id == e.categoryId);

    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── SliverAppBar hero header ─────────────────────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: e.color,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.25),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.25),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.share_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Gradient bg
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [e.color, e.color.withValues(alpha: 0.6)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Decorative circles
                  Positioned(top: -30, right: -30, child: _hdrCircle(160)),
                  Positioned(top: 40, right: 60, child: _hdrCircle(90)),
                  // Content
                  Positioned(
                    bottom: 24,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category + featured
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    cat.emoji,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    cat.label,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (e.featured) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Featured',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          e.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ── Quick info strip ─────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _quickInfo(
                        '📅',
                        e.hijriDate.split(' ').take(3).join(' '),
                      ),
                      const SizedBox(width: 8),
                      _quickInfo('⏱️', e.time),
                      const SizedBox(width: 8),
                      _quickInfo('👥', '${e.attending}+'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ── Location card ────────────────────────────────────────────────
                _detailSection(
                  'Location',
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: e.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: e.color.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(
                            Icons.location_on_rounded,
                            color: e.color,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.location,
                                style: const TextStyle(
                                  color: AppColors.kText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Tap to open in maps',
                                style: TextStyle(
                                  color: AppColors.kSubText,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.kSubText,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Date & time card ─────────────────────────────────────────────
                _detailSection(
                  'Date & Time',
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        _dtRow(
                          Icons.calendar_today_rounded,
                          'Islamic Date',
                          e.hijriDate,
                          e.color,
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 1, color: AppColors.kBorder),
                        const SizedBox(height: 10),
                        _dtRow(
                          Icons.access_time_rounded,
                          'Time',
                          e.time,
                          e.color,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── About ────────────────────────────────────────────────────────
                _detailSection(
                  'About this Event',
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      e.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.65,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Attendees ────────────────────────────────────────────────────
                _detailSection(
                  'Attendees',
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        // Fake avatar stack
                        SizedBox(
                          height: 36,
                          width: 36.0 + (4 * 20.0),
                          child: Stack(
                            children: List.generate(
                              5,
                              (i) => Positioned(
                                left: i * 20.0,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: [
                                      AppColors.kPrimary,
                                      AppColors.kTeal,
                                      AppColors.kPink,
                                      AppColors.kBlue,
                                      AppColors.kOrange,
                                    ][i],
                                    border: Border.all(
                                      color: AppColors.kCard,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ['🧑', '👩', '🧔', '🧕', '👨'][i],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${e.attending} people attending',
                                style: const TextStyle(
                                  color: AppColors.kText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Be part of the community',
                                style: TextStyle(
                                  color: AppColors.kSubText,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),

      // ── Sticky bottom action bar ───────────────────────────────────────────
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          MediaQuery.of(context).padding.bottom + 12,
        ),
        decoration: const BoxDecoration(
          color: AppColors.kCard,
          border: Border(top: BorderSide(color: AppColors.kBorder)),
        ),
        child: Row(
          children: [
            // Add to calendar button
            Container(
              width: 48,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.kBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.kSubText,
                  size: 22,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('📅 "${e.title}" added to calendar'),
                      backgroundColor: e.color,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            // Share button
            Container(
              width: 48,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.kBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.share_rounded,
                  color: AppColors.kSubText,
                  size: 22,
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10),
            // RSVP button
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () => setState(() => e.rsvpd = !e.rsvpd),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: e.rsvpd ? AppColors.kCard : e.color,
                    foregroundColor: e.rsvpd ? e.color : Colors.white,
                    side: e.rsvpd ? BorderSide(color: e.color) : null,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        e.rsvpd
                            ? Icons.check_circle_rounded
                            : Icons.how_to_reg_rounded,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        e.rsvpd ? "You're Going ✓" : 'Register for Event',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hdrCircle(double s) => Container(
    width: s,
    height: s,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.18),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );

  Widget _quickInfo(String emoji, String text) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.kText,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );

  Widget _detailSection(String title, Widget child) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.kText,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: child,
        ),
      ],
    ),
  );

  Widget _dtRow(IconData icon, String label, String value, Color color) => Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.kSubText, fontSize: 11.5),
          ),
          const SizedBox(height: 1),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.kText,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}
