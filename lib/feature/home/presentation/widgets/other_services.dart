// ── constants (add to your theme/constants file) ──────────────────────────
import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

// ── Book Services Card ────────────────────────────────────────────────────
class BookServicesCard extends StatelessWidget {
  const BookServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     color: AppColors.kCard,
    //     borderRadius: BorderRadius.circular(16),
    //     border: Border.all(color: AppColors.kBorder, width: 1),
    //   ),
    //   child: Column(
    //     children: [
    //       _BookRow(
    //         icon: Icons.menu_book_rounded,
    //         label: 'Book Hafiz',
    //         isFirst: true,
    //       ),
    //       _BookRow(
    //         icon: Icons.people_rounded,
    //         label: 'Book Taraweeh',
    //         isFirst: false,
    //       ),
    //     ],
    //   ),
    // )
    // ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Book Services',
            style: TextStyle(
              color: AppColors.kText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              // color: AppColors.kCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: Column(
              children: [
                _serviceRow(
                  icon: Icons.menu_book_rounded,
                  iconColor: AppColors.kGreenLight,
                  label: 'Book Hafiz',
                  isLast: false,
                ),
                _serviceRow(
                  icon: Icons.group_rounded,
                  iconColor: AppColors.kBlueLight, // const Color(0xFF3949AB),
                  label: 'Book Taraweeh',
                  isLast: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _serviceRow({
  required IconData icon,
  required Color iconColor,
  required String label,
  required bool isLast,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: iconColor.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.kText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.kSubText,
              size: 18,
            ),
          ],
        ),
      ),
      if (!isLast)
        const Divider(height: 1, color: AppColors.kBorder, indent: 70),
    ],
  );
}
