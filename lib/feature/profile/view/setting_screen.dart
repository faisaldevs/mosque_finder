import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/profile/view/profile_screen.dart';
import 'package:mosque_finder_app/feature/profile/vm/profile_screen_vm.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileScreenVm>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Settings')),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── ACCOUNT ───────────────────────────────────────────────
                const SectionLabel(label: 'Account'),
                SettingsCard(
                  children: [
                    SettingRow(
                      icon: Icons.person_outline_rounded,
                      iconBg: AppColors.kPrimary,
                      title: 'Personal info',
                      subtitle: 'Name, phone, email',
                      onTap: () => nav.toUserProfileScreen(),
                    ),
                    SettingRow(
                      icon: Icons.lock_outline_rounded,
                      iconBg: const Color(0xFF2C2C2C),
                      title: 'Change password',
                      subtitle: 'Last changed 3 months ago',
                      onTap: () => nav.toUpdatePassScreen(),
                      isLast: true,
                    ),
                  ],
                ),

                // ── PREFERENCES ───────────────────────────────────────────
                const SectionLabel(label: 'Preferences'),
                SettingsCard(
                  children: [
                    SettingRow(
                      icon: Icons.access_time_rounded,
                      iconBg: AppColors.kBlue,
                      title: 'Calculation method',
                      onTap: () => nav.toCalcMethodScreen(),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Pill(label: vm.calculationMethod),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.kSubText,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                    SettingRow(
                      icon: Icons.radar_rounded,
                      iconBg: AppColors.kPrimary,
                      title: 'Search radius',
                      onTap: () => nav.toSearchRadiusScreen(),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadiusBadge(value: vm.searchRadius.round()),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.kSubText,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                    SettingRow(
                      icon: Icons.notifications_outlined,
                      iconBg: AppColors.kWarning,
                      title: 'Azan reminders',
                      subtitle: 'Prayer notifications',
                      onTap: () => nav.toAzanRemindersScreen(),
                      trailing: Switch(
                        value: vm.azanRemindersEnabled,
                        onChanged: vm.toggleAzanReminders,
                        activeColor: AppColors.kWhite,
                        activeTrackColor: AppColors.kPrimary,
                      ),
                      isLast: true,
                    ),
                  ],
                ),

                // ── APP ───────────────────────────────────────────────────
                const SectionLabel(label: 'App'),
                SettingsCard(
                  children: [
                    SettingRow(
                      icon: Icons.info_outline_rounded,
                      iconBg: const Color(0xFF37474F),
                      title: 'About',
                      subtitle: 'Version 1.0.0',
                      onTap: () => nav.toAboutScreen(),
                    ),
                    SettingRow(
                      icon: Icons.star_outline_rounded,
                      iconBg: const Color(0xFF37474F),
                      title: 'Rate on Play Store',
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),

                // ── LOG OUT ───────────────────────────────────────────────
                LogoutCard(onTap: () => vm.logout()),

                // ── Footer ────────────────────────────────────────────────
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 28),
                    child: Text(
                      'Mosque Finder v1.0 · OpenStreetMap',
                      style: TextStyle(
                        color: AppColors.kDarkLight,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
