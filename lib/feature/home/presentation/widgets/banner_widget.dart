// ── constants (add to your theme/constants file) ──────────────────────────
import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

// const kPrimary = Color(0xFF39A79F);
// const kPrimaryDark = Color(0xFF085041);
// const kPrimaryMid = Color(0xFF0F6E56);
// const kCardBg = Color(0xFFFFFFFF);
// const kCardBorder = Color(0xFFC8EBE8);
// const kIconBg = Color(0xFFE8F7F6);

// ── Ramadan Banner Card ───────────────────────────────────────────────────
class RamadanBannerCard extends StatelessWidget {
  const RamadanBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder, width: 1),
      ),
      // padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Stack(
        children: [
          // decorative circles
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kPrimary.withOpacity(0.12),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kPrimary.withOpacity(0.08),
              ),
            ),
          ),
          // content
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ramadan Calendar 2026',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kGreenDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Prepare for the blessed month',
                  style: TextStyle(fontSize: 12, color: AppColors.kGreenLight),
                ),
                const SizedBox(height: 18),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.kPrimary,
                    side: BorderSide(color: AppColors.kPrimary),
                    shape: StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'View Calendar',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
