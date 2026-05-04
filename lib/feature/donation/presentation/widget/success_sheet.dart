// ═════════════════════════════════════════════════════════════════════════════
// SuccessSheet
// ═════════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/donation/model/donation_model.dart';

class SuccessSheet extends StatelessWidget {
  final Campaign campaign;
  final double amount;

  const SuccessSheet({super.key, required this.campaign, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.kBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // Checkmark circle
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kGreenLight.withValues(alpha: 0.12),
              border: Border.all(
                color: AppColors.kGreenLight.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.kGreenLight,
              size: 42,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'JazakAllahu Khayran! 🤲',
            style: TextStyle(
              color: AppColors.kText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your donation of \$${amount.toStringAsFixed(2)} to\n"${campaign.title}" has been received.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.kSubText,
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 20),
          // Campaign summary
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.kBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(campaign.emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: const TextStyle(
                          color: AppColors.kText,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        campaign.organization,
                        style: const TextStyle(
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
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
