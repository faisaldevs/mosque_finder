// ═════════════════════════════════════════════════════════════════════════════
// ABOUT PAGE
// ═════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:mosque_finder_app/feature/profile/widgets/profile_widgets.dart';
import 'package:mosque_finder_app/feature/profile/widgets/sub_page_header.dart';

import '../../../app/theme/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: Column(
        children: [
          const SubPageHeader(
            title: 'About',
            subtitle: 'Mosque Finder app info',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // App card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.kCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.kBorder),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: AppColors.kPrimary,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Center(
                              child: Text('🕌', style: TextStyle(fontSize: 38)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Mosque Finder',
                            style: TextStyle(
                              color: AppColors.kText,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Version 1.0.0 · Build 1',
                            style: TextStyle(
                              color: AppColors.kSubText,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _chip('Free', AppColors.kPrimary),
                              const SizedBox(width: 8),
                              _chip('OpenStreetMap', const Color(0xFF1565C0)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Data sources
                  sectionCard(
                    label: 'Data Sources',
                    children: [
                      _sourceRow(
                        Icons.map_outlined,
                        'Map & mosque data',
                        'OpenStreetMap',
                      ),
                      _sourceRow(
                        Icons.access_time_rounded,
                        'Prayer times',
                        'Adhan library',
                      ),
                      _sourceRow(
                        Icons.location_on_outlined,
                        'Tile server',
                        'tile.openstreet...',
                        isLast: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Rate us
                  sectionCard(
                    label: 'Rate Us',
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < 4
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  color: const Color(0xFFFFB300),
                                  size: 26,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Enjoying the app? Leave a review on the Play Store',
                              style: TextStyle(
                                color: AppColors.kSubText,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: AppColors.kBorder,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Rate on Play Store',
                                  style: TextStyle(
                                    color: AppColors.kText,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Legal links
                  sectionCard(
                    label: '',
                    children: [
                      settingsRow(
                        icon: Icons.shield_outlined,
                        iconBg: const Color(0xFF37474F),
                        title: 'Privacy Policy',
                        onTap: () {},
                      ),
                      settingsRow(
                        icon: Icons.description_outlined,
                        iconBg: const Color(0xFF37474F),
                        title: 'Terms of Service',
                        onTap: () {},
                      ),
                      settingsRow(
                        icon: Icons.code_rounded,
                        iconBg: const Color(0xFF37474F),
                        title: 'Open source licenses',
                        onTap: () {},
                        isLast: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Made with care · No API key required',
                      style: TextStyle(color: AppColors.kSubText, fontSize: 12),
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
  }

  Widget _chip(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      label,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
    ),
  );

  Widget _sourceRow(
    IconData icon,
    String title,
    String sub, {
    bool isLast = false,
  }) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.kPrimary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.kGreenLight, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.kText,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    sub,
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
      if (!isLast)
        const Divider(height: 1, color: AppColors.kBorder, indent: 62),
    ],
  );
}
