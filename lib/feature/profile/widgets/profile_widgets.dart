import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

/// Section card wrapper
Widget sectionCard({required String label, required List<Widget> children}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: AppColors.kTextBlack,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: Column(children: children),
        ),
      ],
    );

/// Single settings row
Widget settingsRow({
  required IconData icon,
  required Color iconBg,
  required String title,
  String? subtitle,
  Widget? trailing,
  VoidCallback? onTap,
  bool isLast = false,
}) => Column(
  children: [
    InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.vertical(bottom: Radius.circular(16))
          : BorderRadius.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 19),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.kText,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.kDarkLight,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.kSubText,
                  size: 20,
                ),
          ],
        ),
      ),
    ),
    if (!isLast) const Divider(height: 1, color: AppColors.kBorder, indent: 65),
  ],
);

/// Green primary button
Widget greenBtn(String text, VoidCallback onTap) => SizedBox(
  width: double.infinity,
  height: 52,
  child: ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.kPrimary,
      foregroundColor: AppColors.kText,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
);

/// Auth-style text field
Widget field({
  required String label,
  required String hint,
  required IconData icon,
  bool obscure = false,
  Widget? suffix,
  TextEditingController? ctrl,
  TextInputType? keyboard,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      label,
      style: const TextStyle(
        color: AppColors.kText,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    ),
    const SizedBox(height: 7),
    TextField(
      controller: ctrl,
      obscureText: obscure,
      keyboardType: keyboard,
      style: const TextStyle(color: AppColors.kText, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.kSubText),
        prefixIcon: Icon(icon, color: AppColors.kSubText, size: 19),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.kCard,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.kGreenLight,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    ),
  ],
);
