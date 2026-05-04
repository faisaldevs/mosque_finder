import 'package:flutter/material.dart';

void main() {
  runApp(const MosqueFinderApp());
}

class MosqueFinderApp extends StatelessWidget {
  const MosqueFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mosque Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF2E7D32),
          surface: const Color(0xFF1A1A1A),
        ),
        useMaterial3: true,
      ),
      home: const SignInPage(),
    );
  }
}

// ─── Shared Palette & Styles ──────────────────────────────────────────────────

const kGreen = Color(0xFF2E7D32);
const kGreenLight = Color(0xFF4CAF50);
const kBg = Color(0xFF1C1C1E);
const kCard = Color(0xFF2A2A2C);
const kBorder = Color(0xFF3A3A3C);
const kText = Color(0xFFFFFFFF);
const kSubText = Color(0xFF8E8E93);
const kError = Color(0xFFFF453A);

// ─── Reusable Widgets ─────────────────────────────────────────────────────────

class _AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _AppHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 36),
      decoration: const BoxDecoration(color: kGreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo circle
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Text('🕌', style: TextStyle(fontSize: 30)),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: kText,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool obscure;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const _AuthTextField({
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.obscure = false,
    this.suffix,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: kText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(color: kText, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kSubText),
            prefixIcon: Icon(prefixIcon, color: kSubText, size: 20),
            suffixIcon: suffix,
            filled: true,
            fillColor: kCard,
            errorText: errorText,
            errorStyle: const TextStyle(color: kError),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kGreenLight, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kError),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kError, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _GreenButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;

  const _GreenButton({required this.text, this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? kGreen : kGreen.withValues(alpha: 0.5),
          foregroundColor: kText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

// ─── Sign In Page ─────────────────────────────────────────────────────────────

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _AppHeader(
              title: 'Welcome back',
              subtitle: 'Sign in to your account',
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _AuthTextField(
                    label: 'Email',
                    hint: 'user@gmail.com',
                    prefixIcon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  _AuthTextField(
                    label: 'Password',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline_rounded,
                    obscure: !_showPassword,
                    suffix: IconButton(
                      icon: Icon(
                        _showPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: kSubText,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _showPassword = !_showPassword),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: kGreenLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _GreenButton(text: 'Sign in', onTap: () {}),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: kBorder, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or continue with',
                          style: TextStyle(color: kSubText, fontSize: 13),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: kBorder, thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Text(
                        'G',
                        style: TextStyle(
                          color: Color(0xFF4285F4),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      label: const Text(
                        'Google',
                        style: TextStyle(color: kText, fontSize: 15),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpPage()),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: kSubText, fontSize: 14),
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                color: kGreenLight,
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

// ─── Sign Up Page ─────────────────────────────────────────────────────────────

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
  Color _strengthColor = kBorder;

  void _evaluatePassword(String value) {
    double strength = 0;
    if (value.length >= 8) strength += 0.33;
    if (value.contains(RegExp(r'[A-Z]'))) strength += 0.33;
    if (value.contains(RegExp(r'[0-9!@#\$%^&*]'))) strength += 0.34;

    String label = '';
    Color color = kBorder;
    if (strength > 0 && strength <= 0.33) {
      label = 'Weak';
      color = kError;
    } else if (strength > 0.33 && strength <= 0.66) {
      label = 'Fair';
      color = const Color(0xFFFF9500);
    } else if (strength > 0.66) {
      label = 'Good strength';
      color = kGreenLight;
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
      backgroundColor: kBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _AppHeader(
              title: 'Create account',
              subtitle: 'Join the Mosque Finder community',
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _AuthTextField(
                    label: 'Full name',
                    hint: 'Faisal Ahmed',
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 20),
                  _AuthTextField(
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
                      color: kText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onChanged: _evaluatePassword,
                    style: const TextStyle(color: kText, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: '••••••••••',
                      hintStyle: const TextStyle(color: kSubText),
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: kSubText,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: kCard,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: kBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: kGreenLight,
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
                        backgroundColor: kBorder,
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
                          activeColor: kGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: const BorderSide(color: kBorder),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(color: kSubText, fontSize: 13),
                            children: [
                              TextSpan(
                                text: 'Terms',
                                style: TextStyle(
                                  color: kGreenLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: kGreenLight,
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
                  _GreenButton(
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
                          style: TextStyle(color: kSubText, fontSize: 14),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                color: kGreenLight,
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
