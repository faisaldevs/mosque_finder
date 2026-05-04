// // ignore_for_file: use_build_context_synchronously

// import 'package:bcs_booster_app/app/router/config/route_extention.dart';
// import 'package:bcs_booster_app/shared/networks/loading/loading_indicators.dart';
// import 'package:flutter/material.dart';

// extension Loader on Future {
//   Future<dynamic> waitingForFuture(BuildContext context) async {
//     showDialog(
//       context: context,
//       // barrierColor: Color(0xFFF0F0F0).withValues(alpha: .2),

//       builder: (context) => loadingIndicatorCircle(context: context),
//     );

//     try {
//       // Wait for the original future to complete
//       dynamic result = await this;

//       return result;
//     } finally {
//       // Close the loading dialog
//       //       nav.goBack();
//       nav.goBack();
//     }
//   }

//   // Future<dynamic> waitingAddToCart(BuildContext context) async {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => Center(
//   //         child: shimmer(context: context, name: Assets.lottie.addToCart)),
//   //   );

//   //   try {
//   //     // Wait for the original future to complete
//   //     dynamic result = await this;

//   //     return result;
//   //   } finally {
//   //     // Close the loading dialog
//   //     nav.goBack();
//   //   }
//   // }

//   // Future<dynamic> waitingRemoveFromCart(BuildContext context) async {
//   //   showDialog(
//   //     // barrierDismissible: false,
//   //     // barrierColor: AppColors.cF4F4F4.withValues(alpha: .8),
//   //     context: context,
//   //     builder: (context) => Center(
//   //       child: shimmer(
//   //           context: context, name: Assets.lottie.removeFromCart, size: 120.sp),
//   //     ),
//   //   );

//   //   try {
//   //     // Wait for the original future to complete
//   //     dynamic result = await this;

//   //     return result;
//   //   } finally {
//   //     // Close the loading dialog
//   //     nav.goBack();
//   //   }
//   // }

//   // Future<dynamic> waitingForFutureWithoutBg(BuildContext context) async {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => loadingIndicatorCircle(context: context),
//   //   );

//   //   try {
//   //     // Wait for the original future to complete
//   //     dynamic result = await this;
//   //     return result;
//   //   } finally {
//   //     // Close the loading dialog
//   //     nav.goBack();
//   //   }
//   // }

//   // Future<void> waitingForFuturewithTime(BuildContext context) async {
//   //   try {
//   //     showDialog(
//   //       context: context,
//   //       barrierColor: AppColors.cF0F0F0,
//   //       builder: (context) => loadingIndicatorCircle(context: context),
//   //     );
//   //     bool result = await this;
//   //     nav.goBack();
//   //     if (result) {
//   //       showDialog(
//   //         context: context,
//   //         builder: (context) => shimmer(
//   //             context: context, name: Assets.lottie.success, size: 120.sp),
//   //       );
//   //       await Future.delayed(const Duration(milliseconds: 800), () {
//   //         nav.goBack();
//   //       });
//   //     }
//   //   } catch (e) {
//   //     nav.goBack();
//   //     log(e.toString());
//   //   }
//   // }

//   // Future<void> waitingForSuccessShow(BuildContext context) async {
//   //   try {
//   //     bool result = await this;
//   //     if (result) {
//   //       showDialog(
//   //         context: context,
//   //         builder: (context) => shimmer(
//   //             context: context, name: Assets.lottie.success, size: 120.sp),
//   //       );
//   //       await Future.delayed(const Duration(milliseconds: 800), () {
//   //         nav.goBack();
//   //       });
//   //     }
//   //   } catch (e) {
//   //     nav.goBack();
//   //     log(e.toString());
//   //   }
//   // }

//   // Future<bool> customeThen(BuildContext context) async {
//   //   bool retunValue = await then(
//   //     (value) async {
//   //       showDialog(
//   //         context: context,
//   //         builder: (context) => shimmer(
//   //             context: context, name: Assets.lottie.success, size: 120.sp),
//   //       );
//   //       await Future.delayed(const Duration(milliseconds: 800), () {
//   //         nav.goBack();
//   //       });
//   //       DefaultResponse defaultResponse = value as DefaultResponse;
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text(defaultResponse.message!),
//   //         ),
//   //       );
//   //       return true;
//   //     },
//   //     onError: (value) {
//   //       Failure failureresponse = value as Failure;
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text(failureresponse.responseMessage),
//   //         ),
//   //       );
//   //       return false;
//   //     },
//   //   );
//   //   return retunValue;
//   // }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:mosque_finder_app/core/networks/loading/loading_indicators.dart';

extension Loader on Future {
  /// Show a loading dialog globally (no context needed),
  /// wait for the Future, then close the dialog.
  Future<dynamic> waitingForFuture() async {
    // Show the loader using your global navigation service
    showDialog(
      context: nav.router.routerDelegate.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (_) => loadingIndicatorCircle(),
    );

    try {
      final result = await this;
      return result;
    } finally {
      // Close the dialog safely
      if (nav.router.canPop()) {
        nav.goBack();
      }
    }
  }
}
