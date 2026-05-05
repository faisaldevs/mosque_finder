import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:mosque_finder_app/feature/profile/vm/profile_screen_vm.dart';
import 'package:mosque_finder_app/feature/profile/widgets/profile_widgets.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/app_colors.dart';

// ═════════════════════════════════════════════════════════════════════════════
// PROFILE MAIN PAGE
// ═════════════════════════════════════════════════════════════════════════════

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileScreenVm>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: AppColors.kBg,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileHeader(context),
                const SizedBox(height: 24),

                // ACCOUNT
                sectionCard(
                  label: 'Account',
                  children: [
                    settingsRow(
                      icon: Icons.person_outline_rounded,
                      iconBg: AppColors.kPrimary.withValues(alpha: 0.85),
                      title: 'Personal info',
                      subtitle: 'Name, phone, email',
                      onTap: () => nav.toUserProfileScreen(),
                    ),
                    settingsRow(
                      icon: Icons.lock_outline_rounded,
                      iconBg: AppColors.kDark.withValues(alpha: 0.85),
                      title: 'Change password',
                      subtitle: 'Last changed 3 months ago',
                      onTap: () => nav.toUpdatePassScreen(),
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // PREFERENCES
                sectionCard(
                  label: 'Preferences',
                  children: [
                    settingsRow(
                      icon: Icons.access_time_rounded,
                      iconBg: AppColors.kBlue.withValues(alpha: 0.85),
                      title: 'Calculation method',
                      onTap: () => nav.toCalcMethodScreen(),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.kBorder,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              vm.calculationMethod,
                              style: const TextStyle(
                                color: AppColors.kText,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.kSubText,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    settingsRow(
                      icon: Icons.radar_rounded,
                      iconBg: AppColors.kPrimary.withValues(alpha: 0.85),
                      title: 'Search radius',
                      onTap: () => nav.toSearchRadiusScreen(),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30,
                            height: 22,
                            decoration: BoxDecoration(
                              color: AppColors.kPrimary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                '${vm.searchRadius.round()}',
                                style: TextStyle(
                                  color: AppColors.kText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.kSubText,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    settingsRow(
                      icon: Icons.notifications_outlined,
                      iconBg: AppColors.kWarning.withValues(alpha: 0.85),
                      title: 'Azan reminders',
                      subtitle: 'Prayer notifications',
                      onTap: () => nav.toAzanRemindersScreen(),
                      trailing: Switch(
                        value: vm.azanRemindersEnabled,
                        onChanged: (v) => vm.toggleAzanReminders(v),
                        activeColor: AppColors.kGreenLight,
                        activeTrackColor: AppColors.kPrimary,
                      ),
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // APP
                sectionCard(
                  label: 'App',
                  children: [
                    settingsRow(
                      icon: Icons.info_outline_rounded,
                      iconBg: const Color(0xFF37474F),
                      title: 'About',
                      subtitle: 'Version 1.0.0',
                      onTap: () => nav.toAboutScreen(),
                    ),
                    settingsRow(
                      icon: Icons.star_outline_rounded,
                      iconBg: const Color(0xFF37474F),
                      title: 'Rate on Play Store',
                      onTap: () {},
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // LOG OUT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.kBorder),
                    ),
                    child: InkWell(
                      onTap: () => vm.logout(),
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.kError.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.kError.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.logout_rounded,
                                color: AppColors.kError,
                                size: 19,
                              ),
                            ),
                            const SizedBox(width: 13),
                            const Text(
                              'Log out',
                              style: TextStyle(
                                color: AppColors.kError,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Footer
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 28),
                    child: Text(
                      'Mosque Finder v1.0 · OpenStreetMap',
                      style: TextStyle(color: AppColors.kSubText, fontSize: 12),
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

  Widget buildProfileHeader(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
            color: AppColors.kPrimary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row
                Row(
                  children: [
                    const Text(
                      'My Profile',
                      style: TextStyle(
                        color: AppColors.kText,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.kCard,
                        border: Border.all(color: AppColors.kBorder, width: 1),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.kText,
                        size: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Avatar + info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kCard,
                            border: Border.all(
                              color: AppColors.kBorder,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text('🧑', style: TextStyle(fontSize: 36)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: AppColors.kBg,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.kPrimary,
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.kText,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Faisal Ahmed',
                            style: TextStyle(
                              color: AppColors.kText,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            '+880 1712 345 678',
                            style: TextStyle(
                              color: AppColors.kSubText,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.kCard.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.kBorder),
                            ),
                            child: const Text(
                              'Member since 2024',
                              style: TextStyle(
                                color: AppColors.kText,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Stats row
                Row(
                  children: [
                    stat('12', 'Saved'),
                    const SizedBox(width: 8),
                    stat('47', 'Visited'),
                    const SizedBox(width: 8),
                    stat('3 km', 'Radius'),
                    const SizedBox(width: 8),
                    stat('Hanafi', 'Method'),
                  ],
                ),
              ],
            ),
          ),
          // Decorative circles
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(top: -35, right: -35, child: hdrCircle(160)),
                Positioned(top: 18, right: 55, child: hdrCircle(95)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget stat(String value, String label) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.kText,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.kSubText, fontSize: 10.5),
          ),
        ],
      ),
    ),
  );

  Widget hdrCircle(double s) => Container(
    width: s,
    height: s,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      color: Colors.transparent,
    ),
  );
}
