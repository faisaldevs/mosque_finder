// ═════════════════════════════════════════════════════════════════════════════
// CHANGE PASSWORD PAGE
// ═════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_textfield_widget.dart';
import 'package:mosque_finder_app/feature/profile/vm/change_password_vm.dart';
import 'package:mosque_finder_app/feature/profile/widgets/sub_page_header.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangePasswordVm>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: AppColors.kBg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SubPageHeader(
                  title: 'Change password',
                  subtitle: 'Keep your account secure',
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.kCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.kBorder),
                    ),
                    child: Column(
                      children: [
                        AuthTextField(
                          label: 'Current password',
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline_rounded,
                          obscure: vm.showCurrent,
                          onChanged: vm.setCurrentPassword,
                          suffix: IconButton(
                            icon: Icon(
                              vm.showCurrent
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.kSubText,
                              size: 19,
                            ),
                            onPressed: () => vm.toggleShowCurrent(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'New password',
                              style: TextStyle(
                                color: AppColors.kText,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 7),
                            TextField(
                              obscureText: vm.showNew,
                              onChanged: vm.setNewPassword,
                              style: const TextStyle(
                                color: AppColors.kText,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                hintText: '••••••••••',
                                hintStyle: const TextStyle(
                                  color: AppColors.kSubText,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppColors.kSubText,
                                  size: 19,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    vm.showNew
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.kSubText,
                                    size: 19,
                                  ),
                                  onPressed: () => vm.toggleShowNew(),
                                ),
                                filled: true,
                                fillColor: AppColors.kBg,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.kBorder,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.kSuccess,
                                    width: 1.5,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 14,
                                ),
                              ),
                            ),
                            if (vm.strength > 0) ...[
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: vm.strength,
                                  minHeight: 4,
                                  backgroundColor: AppColors.kBorder,
                                  valueColor: AlwaysStoppedAnimation(
                                    vm.strColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                vm.strLabel,
                                style: TextStyle(
                                  color: vm.strColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: 'Confirm new password',
                          hint: '••••••••••',
                          prefixIcon: Icons.lock_outline_rounded,
                          obscure: vm.showConfirm,
                          onChanged: vm.setConfirmPassword,
                          suffix: IconButton(
                            icon: Icon(
                              vm.showConfirm
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.kSubText,
                              size: 19,
                            ),
                            onPressed: () => vm.toggleShowConfirm(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Hint card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.kGreen.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.kGreen.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.kSuccess,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Use 8+ characters with uppercase, numbers and symbols for a strong password',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GreenButton(
                    text: 'Update password',
                    onTap: () async {
                      await vm.changePassword();
                      if (context.mounted) context.pop();
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
