import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:mosque_finder_app/feature/profile/vm/profile_screen_vm.dart';
import 'package:mosque_finder_app/feature/profile/widgets/sub_page_header.dart';
import 'package:provider/provider.dart';

// ═════════════════════════════════════════════════════════════════════════════
// SEARCH RADIUS PAGE
// ═════════════════════════════════════════════════════════════════════════════

class SearchRadiusPage extends StatelessWidget {
  const SearchRadiusPage({super.key});

  static const _options = [
    _RadiusOption(1, '1 km · Walking distance'),
    _RadiusOption(2, '2 km · Nearby'),
    _RadiusOption(3, '3 km · Recommended'),
    _RadiusOption(5, '5 km · Wider area'),
    _RadiusOption(10, '10 km · Large radius'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileScreenVm>(
      builder: (context, vm, child) {
        final selectedIndex = _options.indexWhere(
          (option) => option.km == vm.searchRadius.round(),
        );
        return Scaffold(
          backgroundColor: AppColors.kBg,
          body: Column(
            children: [
              const SubPageHeader(
                title: 'Search radius',
                subtitle: 'How far to search for mosques',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Slider card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.kCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.kBorder),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Current radius',
                              style: TextStyle(
                                color: AppColors.kSubText,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.kGreenLight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.kGreen.withValues(alpha: 0.08),
                              ),
                              child: Text(
                                '${vm.searchRadius.round()} km',
                                style: const TextStyle(
                                  color: AppColors.kText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SliderTheme(
                              data: SliderThemeData(
                                activeTrackColor: AppColors.kGreenLight,
                                inactiveTrackColor: AppColors.kBorder,
                                thumbColor: AppColors.kGreenLight,
                                overlayColor: AppColors.kGreen.withValues(
                                  alpha: 0.2,
                                ),
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 10,
                                ),
                              ),
                              child: Slider(
                                value: vm.searchRadius,
                                min: 1,
                                max: 10,
                                divisions: 9,
                                onChanged: vm.updateSearchRadius,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  '1 km',
                                  style: TextStyle(
                                    color: AppColors.kSubText,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  '5 km',
                                  style: TextStyle(
                                    color: AppColors.kSubText,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  '10 km',
                                  style: TextStyle(
                                    color: AppColors.kSubText,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Quick select
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.kCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.kBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
                              child: Text(
                                'QUICK SELECT',
                                style: TextStyle(
                                  color: AppColors.kSubText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            ...List.generate(_options.length, (i) {
                              final sel = i == selectedIndex;
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () => vm.updateSearchRadius(
                                      _options[i].km.toDouble(),
                                    ),
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
                                              _options[i].label,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColors.kGreen,
                                                borderRadius:
                                                    BorderRadius.circular(20),
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
                                  if (i < _options.length - 1)
                                    const Divider(
                                      height: 1,
                                      color: AppColors.kBorder,
                                      indent: 50,
                                    ),
                                ],
                              );
                            }),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GreenButton(
                          text: 'Save radius',
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
        );
      },
    );
  }
}

class _RadiusOption {
  final int km;
  final String label;
  const _RadiusOption(this.km, this.label);
}
