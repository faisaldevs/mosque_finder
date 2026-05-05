import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/router/config/route_names.dart';
import 'package:mosque_finder_app/feature/auth/presentation/view/forgot_pass_screen.dart';
import 'package:mosque_finder_app/feature/auth/presentation/view/login_screen.dart';

class AuthRouter {
  static List<GoRoute> get routes => [
    GoRoute(
      path: RouteNames.login,
      name: RouteNames.login.name,
      builder: (_, __) => LoginScreen(),
    ),
    // GoRoute(
    //   path: RouteNames.signup,
    //   name: RouteNames.signup.name,
    //   builder: (_, __) => SignUpScreen(),
    // ),
    // GoRoute(
    //   path: RouteNames.signupOtp,
    //   name: RouteNames.signupOtp.name,
    //   builder: (_, __) => SignupOtpVerificationScreen(),
    // ),
    // GoRoute(
    //   path: RouteNames.signupNumer,
    //   name: RouteNames.signupNumer.name,

    //   // builder: (_, __) => SignupNumberVerificationScreen(),
    //   builder: (context, state) {
    //     final data = state.extra as Map;

    //     return SignupNumberVerificationScreen(
    //       isForgotPass: data["isForgotPass"],
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: RouteNames.forgotPassNumber,
    //   name: RouteNames.forgotPassNumber.name,
    //   builder: (_, __) => ForgotPassNumberScreen(),
    // ),
    // GoRoute(
    //   path: RouteNames.forgotPassOtp,
    //   name: RouteNames.forgotPassOtp.name,
    //   builder: (context, state) {
    //     final data = state.extra as Map;
    //     return ForgotPassOtpScreen(
    //       phone: data["phone"],
    //     );
    //   },
    // ),
    GoRoute(
      path: RouteNames.forgotPass,
      name: RouteNames.forgotPass.name,
      // builder: (_, __) => ForgotPassScreen(),
      builder: (context, state) {
        // final data = state.extra as Map;
        return ForgotPasswordPage(
          // phone: data["phone"],
          // otp: data["otp"],
        );
      },
    ),
    // GoRoute(
    //   path: RouteNames.forgotPassSuccess,
    //   name: RouteNames.forgotPassSuccess.name,
    //   builder: (_, __) => ForgotPassSuccess(),
    // ),
  ];
}
