import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_header_widget.dart';
import 'package:mosque_finder_app/feature/auth/presentation/widgets/auth_textfield_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreed = false;
  bool _emailError = false;
  double _passwordStrength = 0;
  String _strengthLabel = '';
  Color _strengthColor = AppColors.kBorder;

  void _evaluatePassword(String value) {
    double strength = 0;
    if (value.length >= 8) strength += 0.33;
    if (value.contains(RegExp(r'[A-Z]'))) strength += 0.33;
    if (value.contains(RegExp(r'[0-9!@#\$%^&*]'))) strength += 0.34;

    String label = '';
    Color color = AppColors.kBorder;
    if (strength > 0 && strength <= 0.33) {
      label = 'Weak';
      color = AppColors.kError;
    } else if (strength > 0.33 && strength <= 0.66) {
      label = 'Fair';
      color = const Color(0xFFFF9500);
    } else if (strength > 0.66) {
      label = 'Good strength';
      color = AppColors.kGreenLight;
    }

    setState(() {
      _passwordStrength = strength;
      _strengthLabel = label;
      _strengthColor = color;
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _emailError =
          value.isNotEmpty && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(
              title: 'Create account',
              subtitle: 'Join the Mosque Finder community',
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthTextField(
                    label: 'Full name',
                    hint: 'Faisal Ahmed',
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    label: 'Email',
                    hint: 'user@gmail.com',
                    prefixIcon: Icons.mail_outline_rounded,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: _validateEmail,
                    errorText: _emailError
                        ? 'Enter a valid email address'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  // Password with strength bar
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: AppColors.kText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onChanged: _evaluatePassword,
                    style: const TextStyle(
                      color: AppColors.kText,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: '••••••••••',
                      hintStyle: const TextStyle(color: AppColors.kSubText),
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: AppColors.kSubText,
                        size: 20,
                      ),
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
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  if (_passwordStrength > 0) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _passwordStrength,
                        minHeight: 4,
                        backgroundColor: AppColors.kBorder,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _strengthColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _strengthLabel,
                      style: TextStyle(color: _strengthColor, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 20),
                  // Terms checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: _agreed,
                          onChanged: (v) =>
                              setState(() => _agreed = v ?? false),
                          activeColor: AppColors.kGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: const BorderSide(color: AppColors.kBorder),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(
                              color: AppColors.kSubText,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms',
                                style: TextStyle(
                                  color: AppColors.kGreenLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.kGreenLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  GreenButton(
                    text: 'Create account',
                    enabled: _agreed,
                    onTap: () {},
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: AppColors.kSubText,
                            fontSize: 14,
                          ),
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
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
