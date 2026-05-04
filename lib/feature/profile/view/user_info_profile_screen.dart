// ═════════════════════════════════════════════════════════════════════════════
// PERSONAL INFO PAGE
// ═════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_textfield_widget.dart';
import 'package:mosque_finder_app/feature/profile/vm/user_info_profile_vm.dart';
import 'package:mosque_finder_app/feature/profile/widgets/sub_page_header.dart';
import 'package:provider/provider.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProfileVm>(
      builder: (context, vm, child) {
        if (vm.fullName.isEmpty && vm.phoneNumber.isEmpty && vm.city.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => vm.loadUserData(),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.kBg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SubPageHeader(
                  title: 'Personal info',
                  subtitle: 'Edit your profile details',
                ),
                const SizedBox(height: 20),

                // Avatar picker
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kCard,
                          border: Border.all(color: AppColors.kGreen, width: 2),
                        ),
                        child: const Center(
                          child: Text('🧑', style: TextStyle(fontSize: 42)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: AppColors.kGreen,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.kBg, width: 2),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColors.kText,
                            size: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Change photo',
                  style: TextStyle(
                    color: AppColors.kGreenLight,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // Form
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
                          label: 'Full name',
                          hint: vm.fullName.isNotEmpty
                              ? vm.fullName
                              : 'Faisal Ahmed',
                          prefixIcon: Icons.person_outline_rounded,
                          onChanged: vm.setFullName,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: 'Phone number',
                          hint: vm.phoneNumber.isNotEmpty
                              ? vm.phoneNumber
                              : '+880 1712 345 678',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          onChanged: vm.setPhoneNumber,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: 'Email (optional)',
                          hint: vm.email.isNotEmpty
                              ? vm.email
                              : 'Add email address',
                          prefixIcon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: vm.setEmail,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: 'City',
                          hint: vm.city.isNotEmpty ? vm.city : 'Dhaka',
                          prefixIcon: Icons.location_city_outlined,
                          onChanged: vm.setCity,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GreenButton(
                    text: 'Save changes',
                    onTap: () async {
                      await vm.saveChanges();
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
