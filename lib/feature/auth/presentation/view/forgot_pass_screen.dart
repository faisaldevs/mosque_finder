// ═════════════════════════════════════════════════════════════════════════════
// FORGOT PASSWORD PAGE
// ═════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_header_widget.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_textfield_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  int _step = 0; // 0 = email entry, 1 = OTP + new password
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocus = List.generate(6, (_) => FocusNode());
  int _resendSeconds = 54;

  void _sendCode() {
    setState(() => _step = 1);
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendSeconds > 0) {
        setState(() => _resendSeconds--);
        _startResendTimer();
      }
    });
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocus) {
      f.dispose();
    }
    _emailController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(
              title: 'Reset password',
              subtitle: _step == 0
                  ? "We'll send a code to your email"
                  : 'Enter the code we sent you',
              // showBack: true,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: _step == 0 ? _buildEmailStep() : _buildCodeStep(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        AuthTextField(
          label: 'Your email address',
          hint: 'user@gmail.com',
          prefixIcon: Icons.mail_outline_rounded,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 28),
        GreenButton(text: 'Send reset code', onTap: _sendCode),
        const SizedBox(height: 28),
        Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: RichText(
              text: const TextSpan(
                text: 'Remembered it? ',
                style: TextStyle(color: AppColors.kSubText, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(
                      color: AppColors.kGreenLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildCodeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Read-only email display with icon
        const Text(
          'Your email address',
          style: TextStyle(
            color: AppColors.kText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.mail_outline_rounded,
                color: AppColors.kSubText,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                _emailController.text.isEmpty
                    ? 'user@gmail.com'
                    : _emailController.text,
                style: const TextStyle(color: AppColors.kText, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Divider
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.kBorder, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'then enter code below',
                style: TextStyle(color: AppColors.kSubText, fontSize: 12),
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.kBorder, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Verification code
        const Text(
          'Verification code',
          style: TextStyle(
            color: AppColors.kText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (i) => _otpBox(i)),
        ),
        const SizedBox(height: 12),

        // Resend timer
        Row(
          children: [
            Text(
              'Resend code in ',
              style: TextStyle(color: AppColors.kSubText, fontSize: 13),
            ),
            Text(
              '${_resendSeconds}s',
              style: const TextStyle(
                color: AppColors.kGreenLight,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),

        // New password
        AuthTextField(
          label: 'New password',
          hint: 'Enter new password',
          prefixIcon: Icons.lock_outline_rounded,
          obscure: true,
          controller: _newPasswordController,
        ),
        const SizedBox(height: 28),

        GreenButton(
          text: 'Confirm reset',
          onTap: () {
            nav.toLogin();
          },
        ),
        const SizedBox(height: 28),

        Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: RichText(
              text: const TextSpan(
                text: 'Remembered it? ',
                style: TextStyle(color: AppColors.kSubText, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(
                      color: AppColors.kGreenLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _otpBox(int index) {
    return SizedBox(
      width: 46,
      height: 52,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _otpFocus[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          color: AppColors.kText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.kPrimary.withValues(alpha: 0.05),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.kBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.kGreenLight,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (val) {
          if (val.isNotEmpty && index < 5) {
            _otpFocus[index + 1].requestFocus();
          } else if (val.isEmpty && index > 0) {
            _otpFocus[index - 1].requestFocus();
          }
          setState(() {});
        },
      ),
    );
  }
}
