import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:mosque_finder_app/feature/profile/widgets/sub_page_header.dart';
import 'package:provider/provider.dart';

import '../vm/profile_screen_vm.dart';

// ═════════════════════════════════════════════════════════════════════════════
// CALCULATION METHOD PAGE
// ═════════════════════════════════════════════════════════════════════════════

class CalcMethodPage extends StatelessWidget {
  const CalcMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileScreenVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.kBg,
        body: Column(
          children: [
            const SubPageHeader(
              title: 'Calculation method',
              subtitle: 'Affects prayer time accuracy',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.kCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.kBorder),
                      ),
                      child: Column(
                        children: List.generate(vm.calculationMethods.length, (
                          i,
                        ) {
                          final method = vm.calculationMethods[i];
                          final desc = vm.calculationMethodDescriptions[i];
                          final sel = i == vm.calculationMethodIndex;
                          return Column(
                            children: [
                              InkWell(
                                onTap: () => vm.updateCalculationMethod(i),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        width: 22,
                                        height: 22,
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  method,
                                                  style: TextStyle(
                                                    color: sel
                                                        ? AppColors.kText
                                                        : Colors.white70,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                if (sel) ...[
                                                  const SizedBox(width: 8),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.kGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: const Text(
                                                      'Active',
                                                      style: TextStyle(
                                                        color: AppColors.kText,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              desc,
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
                              ),
                              if (i < vm.calculationMethods.length - 1)
                                const Divider(
                                  height: 1,
                                  color: AppColors.kBorder,
                                  indent: 52,
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GreenButton(
                        text: 'Save method',
                        onTap: () => context.pop(),
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
