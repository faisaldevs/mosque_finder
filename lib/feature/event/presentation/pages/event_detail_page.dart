import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

import '../../models/event_mock_data.dart';
import '../../models/event_model.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final category = categories.firstWhere((c) => c.id == event.categoryId);

    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── SliverAppBar hero header ─────────────────────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: event.color,
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
                        colors: [
                          event.color,
                          event.color.withValues(alpha: 0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Decorative circles
                  Positioned(top: -30, right: -30, child: _buildCircle(160)),
                  Positioned(top: 40, right: 60, child: _buildCircle(90)),
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
                                    category.emoji,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    category.label,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (event.featured) ...[
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
                          event.title,
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
                      _buildQuickInfo(
                        '📅',
                        event.hijriDate.split(' ').take(3).join(' '),
                      ),
                      const SizedBox(width: 8),
                      _buildQuickInfo('⏱️', event.time),
                      const SizedBox(width: 8),
                      _buildQuickInfo('👥', '${event.attending}+'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ── Location card ────────────────────────────────────────────────
                _buildDetailSection(
                  'Location',
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: event.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: event.color.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(
                            Icons.location_on_rounded,
                            color: event.color,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.location,
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
                _buildDetailSection(
                  'Date & Time',
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        _buildDateTimeRow(
                          Icons.calendar_today_rounded,
                          'Islamic Date',
                          event.hijriDate,
                          event.color,
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 1, color: AppColors.kBorder),
                        const SizedBox(height: 10),
                        _buildDateTimeRow(
                          Icons.access_time_rounded,
                          'Time',
                          event.time,
                          event.color,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── About ────────────────────────────────────────────────────────
                _buildDetailSection(
                  'About this Event',
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      event.description,
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
                _buildDetailSection(
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
                                '${event.attending} people attending',
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
                      content: Text('📅 "${event.title}" added to calendar'),
                      backgroundColor: event.color,
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
                  onPressed: () => setState(() => event.rsvpd = !event.rsvpd),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: event.rsvpd
                        ? AppColors.kCard
                        : event.color,
                    foregroundColor: event.rsvpd ? event.color : Colors.white,
                    side: event.rsvpd ? BorderSide(color: event.color) : null,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        event.rsvpd
                            ? Icons.check_circle_rounded
                            : Icons.how_to_reg_rounded,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        event.rsvpd ? "You're Going ✓" : 'Register for Event',
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

  Widget _buildCircle(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.18),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );

  Widget _buildQuickInfo(String emoji, String text) => Expanded(
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

  Widget _buildDetailSection(String title, Widget child) => Padding(
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

  Widget _buildDateTimeRow(
    IconData icon,
    String label,
    String value,
    Color color,
  ) => Row(
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
