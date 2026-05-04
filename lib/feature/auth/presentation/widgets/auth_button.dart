import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

class GreenButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;

  const GreenButton({
    super.key,
    required this.text,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled
              ? AppColors.kGreen
              : AppColors.kGreen.withValues(alpha: 0.5),
          foregroundColor: AppColors.kText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
