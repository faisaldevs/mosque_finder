import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

// final class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF7B39ED), // Vibrant Purple
//               Color(0xFF4117B1), // Deep Indigo
//             ],
//             // If you want the transition to be smoother, you can add
//             // stops: [0.0, 1.0],
//           ),
//         ),

//         // islogin: true,
//         // child: Center(
//         //   child: SizedBox(
//         //     width: 156.w,
//         //     child: Image.asset(
//         //       Assets.images.bcsAppLogo.path,
//         //     ),
//         //   ),
//         // ),
//       ),
//     );
//   }
// }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));
    _ctrl.forward();

    // Future.delayed(const Duration(milliseconds: 2500), () {
    //   if (mounted) {
    //     Navigator.pushReplacement(
    //       context,
    //       PageRouteBuilder(
    //         pageBuilder: (_, __, ___) => const SignUpPage(),
    //         transitionsBuilder: (_, anim, __, child) =>
    //             FadeTransition(opacity: anim, child: child),
    //         transitionDuration: const Duration(milliseconds: 500),
    //       ),
    //     );
    //   }
    // });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _splashCircle(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.12),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: Stack(
        children: [
          // Decorative circles - same language as auth screens but fuller
          Positioned(bottom: -80, left: -80, child: _splashCircle(300)),
          Positioned(bottom: 60, left: 60, child: _splashCircle(200)),
          Positioned(top: -60, right: -60, child: _splashCircle(260)),
          Positioned(top: 80, right: 80, child: _splashCircle(140)),

          // Center content
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.35),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Text('🕌', style: TextStyle(fontSize: 52)),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Mosque Finder',
                      style: TextStyle(
                        color: AppColors.kTextWhite,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Find mosques near you',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom loading + tagline
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                children: [
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Made with ♥ for the Ummah',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThreeDotLoading extends StatefulWidget {
  const ThreeDotLoading({super.key});

  @override
  State<ThreeDotLoading> createState() => _ThreeDotLoadingState();
}

class _ThreeDotLoadingState extends State<ThreeDotLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Duration for one full cycle of the dots
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // This creates a staggered delay for each dot
            final double delay = index * 0.2;
            final double progress = (_controller.value - delay).clamp(0.0, 1.0);

            // Calculating a simple bounce/opacity effect
            final double opacity =
                0.3 + (0.7 * (1.0 - (progress - 0.5).abs() * 2));

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: opacity.clamp(0.3, 1.0)),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}
