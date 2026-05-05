// ═════════════════════════════════════════════════════════════════════════════
// AZAN REMINDERS PAGE
// ═════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:mosque_finder_app/feature/profile/widgets/profile_widgets.dart';
import 'package:mosque_finder_app/feature/profile/widgets/sub_page_header.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/app_colors.dart';
import '../vm/reminder_screen_vm.dart';

class AzanRemindersPage extends StatelessWidget {
  const AzanRemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderScreenVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.kBg,
        body: Column(
          children: [
            const SubPageHeader(
              title: 'Azan reminders',
              subtitle: 'Manage prayer notifications',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Prayer toggles
                    sectionCard(
                      label: 'Prayer Notifications',
                      children: List.generate(vm.prayers.length, (i) {
                        final last = i == vm.prayers.length - 1;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: AppColors.kPrimary.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColors.kPrimary.withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.access_time_rounded,
                                      color: AppColors.kGreenLight,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vm.prayers[i],
                                          style: const TextStyle(
                                            color: AppColors.kText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${vm.times[i]} · ${vm.isEnabled(i) ? vm.getTimingLabel(vm.timing) : "Off"}',
                                          style: const TextStyle(
                                            color: AppColors.kSubText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: vm.isEnabled(i),
                                    onChanged: (v) => vm.togglePrayer(i),
                                    activeColor: AppColors.kGreenLight,
                                    activeTrackColor: AppColors.kPrimary,
                                  ),
                                ],
                              ),
                            ),
                            if (!last)
                              const Divider(
                                height: 1,
                                color: AppColors.kBorder,
                                indent: 62,
                              ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // Timing options
                    sectionCard(
                      label: 'Reminder Timing',
                      children: List.generate(vm.timingLabels.length, (i) {
                        final sel = vm.isTimingSelected(i);
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => vm.selectTiming(i),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 13,
                                ),
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: sel
                                              ? AppColors.kGreenLight
                                              : AppColors.kBorder,
                                          width: sel ? 5 : 2,
                                        ),
                                        color: AppColors.kBg,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        vm.timingLabels[i],
                                        style: TextStyle(
                                          color: sel
                                              ? AppColors.kText
                                              : Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    if (sel)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.kPrimary,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Text(
                                          'Active',
                                          style: TextStyle(
                                            color: AppColors.kText,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if (i < vm.timingLabels.length - 1)
                              const Divider(
                                height: 1,
                                color: AppColors.kBorder,
                                indent: 50,
                              ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GreenButton(
                        text: 'Save preferences',
                        onTap: () async {
                          await vm.savePreferences();
                          if (context.mounted) context.pop();
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
