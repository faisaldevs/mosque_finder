import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

import '../../models/event_mock_data.dart';
import '../../models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onRsvp;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onRsvp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final category = categories.firstWhere((c) => c.id == event.categoryId);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          color: AppColors.kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: event.featured
                ? event.color.withValues(alpha: 0.5)
                : AppColors.kBorder,
            width: event.featured ? 1.5 : 1,
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
                  colors: [event.color, event.color.withValues(alpha: 0.4)],
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
                      if (event.featured) ...[
                        Icon(Icons.star_rounded, color: event.color, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Featured Event',
                          style: TextStyle(
                            color: event.color,
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
                          color: category.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: category.color.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              category.emoji,
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              category.label,
                              style: TextStyle(
                                color: category.color,
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
                    event.title,
                    style: const TextStyle(
                      color: AppColors.kText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Info rows
                  _infoRow(Icons.calendar_today_rounded, event.hijriDate),
                  const SizedBox(height: 5),
                  _infoRow(Icons.access_time_rounded, event.time),
                  const SizedBox(height: 5),
                  _infoRow(Icons.location_on_rounded, event.location),
                  const SizedBox(height: 5),
                  _infoRow(Icons.group_rounded, '${event.attending} attending'),
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
                              backgroundColor: event.rsvpd
                                  ? AppColors.kCard
                                  : event.color,
                              foregroundColor: event.rsvpd
                                  ? event.color
                                  : Colors.white,
                              elevation: 0,
                              side: event.rsvpd
                                  ? BorderSide(color: event.color)
                                  : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  event.rsvpd
                                      ? Icons.check_circle_rounded
                                      : Icons.how_to_reg_rounded,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  event.rsvpd
                                      ? 'RSVP\'d ✓'
                                      : 'Register for Event',
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
