// ═════════════════════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ═════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

/// Green header with back arrow + decorative circles (matches auth/home style)
class SubPageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const SubPageHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
            color: AppColors.kPrimary,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    margin: EdgeInsets.only(top: 6),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.kWhite,
                      size: 17,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.kTextWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
        color: Colors.white.withValues(alpha: 0.15),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );
}
