// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// Widget loadingIndicatorCircle({
//   required BuildContext context,
//   Color? color,
//   double? size,
// }) {
//   double loaderSize = 200.sp;
//   return Center(
//     child: SizedBox(
//       height: 40,
//       width: 40,
//       child: CircularProgressIndicator(),
//     ),
//   );
// }

// // Widget shimmer({
// //   String? name,
// //   required BuildContext context,
// //   Color? color,
// //   double? size,
// // }) {
// //   return Center(
// //     child: Container(
// //       child: Lottie.asset(name ?? Assets.lottie.hamburger, width: size, height: size),
// //     ),
// //   );
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // import '../../../gen/assets.gen.dart';

// // Widget loadingIndicatorCircle({
// //   required BuildContext context,
// //   Color? color,
// //   double? size,
// // }) {
// //   double loaderSize = 200.sp;
// //   return DotLottieLoader.fromAsset(Assets.lottie.wedeAnimation, frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
// //     if (dotlottie != null) {
// //       return Center(
// //         child: Container(
// //           child: Lottie.memory(dotlottie.animations.values.single, height: loaderSize, width: loaderSize),
// //         ),
// //       );
// //     } else {
// //       return Container();
// //     }
// //   });
// // }

// // Widget shimmer({
// //   String? name,
// //   required BuildContext context,
// //   Color? color,
// //   double? size,
// // }) {
// //   return Center(
// //     child: Container(
// //       child: Lottie.asset(name ?? Assets.lottie.hamburger, width: size, height: size),
// //     ),
// //   );
// // }

import 'package:flutter/material.dart';

Widget loadingIndicatorCircle({
  Color? color,
  double? size,
}) {
  return Center(
    child: SizedBox(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: color ?? Colors.blueAccent,
      ),
    ),
  );
}
