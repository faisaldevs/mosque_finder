import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

import '../../models/event_mock_data.dart';

class CalendarCard extends StatelessWidget {
  final int selectedDay;
  final ValueChanged<int> onDaySelected;

  const CalendarCard({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
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
                      hijriMonthName,
                      style: TextStyle(
                        color: AppColors.kText,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '$hijriTotalDays days · Islamic Calendar',
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
                    '$selectedDay of $hijriTotalDays',
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
    const startOffset = hijriStartWeekday;
    final totalCells = startOffset + hijriTotalDays;
    final rows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(
        rows,
        (row) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (col) {
            final cellIndex = row * 7 + col;
            final day = cellIndex - startOffset + 1;
            if (day < 1 || day > hijriTotalDays) {
              return const SizedBox(width: 36, height: 36);
            }
            final isToday = day == selectedDay;
            final hasEvent = eventDays.contains(day);
            return GestureDetector(
              onTap: () => onDaySelected(day),
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
}
