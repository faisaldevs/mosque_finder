import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

// ─── Shared avatar widget ─────────────────────────────────────────────────────
Widget buildAvatar(String emoji, double size) => Container(
  width: size,
  height: size,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.kPrimary.withValues(alpha: 0.15),
    border: Border.all(
      color: AppColors.kPrimary.withValues(alpha: 0.3),
      width: 1.2,
    ),
  ),
  child: Center(
    child: Text(emoji, style: TextStyle(fontSize: size * 0.52)),
  ),
);

// ─── Action button widget ─────────────────────────────────────────────────────
class ActionButton extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;
  final bool isBold;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.emoji,
    required this.label,
    required this.color,
    this.isBold = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Icon button widget ───────────────────────────────────────────────────────
class IconButtonCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const IconButtonCircle({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.15),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Icon(icon, color: AppColors.kText, size: 18),
      ),
    );
  }
}

// ─── Utility function to format counts ─────────────────────────────────────────
String formatCount(int n) {
  if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
  return n.toString();
}

// ─── Hex color to Color converter ──────────────────────────────────────────────
Color hexToColor(String hexString) {
  final hex = hexString.replaceFirst('#', '');
  return Color(int.parse('0x$hex'));
}
