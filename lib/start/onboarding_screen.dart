// import 'dart:async';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:imgori_app/app/constants/text_font_style.dart';
// import 'package:imgori_app/app/router/config/route_extention.dart';
// import 'package:imgori_app/gen/assets.gen.dart';
// import 'package:imgori_app/gen/colors.gen.dart';
// import 'package:imgori_app/utils/ui_helpers.dart';

// final class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             Assets.images.onboardingBg.path,
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.fill,
//           ),
//           Container(color: AppColors.c000000.withValues(alpha: .4)),
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   AppColors.c000000.withValues(alpha: .0),
//                   AppColors.c000000.withValues(alpha: .5),
//                   AppColors.c000000,
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: UIHelper.kDefaulutPadding(),
//             ),
//             child: Column(
//               children: [
//                 UIHelper.verticalSpace(50.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () => nav.toHome(),
//                       child: Text(
//                         "Skip",
//                         style: TextFontStyle.headline14w600cFFFFFFstyleInter,
//                       ),
//                     ),
//                   ],
//                 ),
//                 UIHelper.verticalSpace(40.h),
//                 Image.asset(Assets.images.appLogo.path, height: 40.h),
//               ],
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 40.h,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: UIHelper.kDefaulutPadding(),
//               ),
//               child: Column(
//                 children: [
//                   UIHelper.verticalSpace(50.h),
//                   SizedBox(
//                     height: 160.h,
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: TextSlider(),
//                     ),
//                   ),
//                   UIHelper.verticalSpace(40.h),
//                   GestureDetector(
//                     onTap: () => nav.toSignup(),
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 28.w,
//                         vertical: 14.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.allPrimaryColor,
//                       ),
//                       child: Text(
//                         'Sign Up',
//                         textAlign: TextAlign.center,
//                         style: TextFontStyle.headline16w600cFAFAFAstyleSora,
//                       ),
//                     ),
//                   ),
//                   UIHelper.verticalSpace(40.h),
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Already have an account? ',
//                           style: TextFontStyle.headline12w400cFFFFFFstyleInter
//                               .copyWith(
//                             color: AppColors.cFFFFFF.withValues(alpha: .6),
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'Log In',
//                           style: TextFontStyle.headline12w500cFFFFFFstyleInter
//                               .copyWith(
//                             decoration: TextDecoration.underline,
//                             decorationColor: AppColors.cFFFFFF,
//                           ),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () => nav.toLogin(),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class TextSlider extends StatefulWidget {
// //   const TextSlider({super.key});

// //   @override
// //   State<TextSlider> createState() => _TextSliderState();
// // }

// // class _TextSliderState extends State<TextSlider> {
// //   final PageController _controller = PageController();
// //   int _currentIndex = 0;

// //   final List<Map<String, String>> _slides = [
// //     {
// //       'title': 'Discover Inspiration\n Anytime, Anywhere',
// //       'description':
// //           'High-resolution photos across categories like nature, business, lifestyle, and more. all at your fingertips.',
// //     },
// //     {
// //       'title': 'Free to Use\nPremium to Elevate',
// //       'description':
// //           'Enjoy free downloads or unlock powerful access with flexible image plans. starting at just \$1.',
// //     },
// //     {
// //       'title': 'Save, Download &\nManage With Ease',
// //       'description':
// //           'Access your downloads, manage your subscriptions, and get help. all from one place.',
// //     },
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         Expanded(
// //           child: PageView.builder(
// //             controller: _controller,
// //             itemCount: _slides.length,
// //             onPageChanged: (index) {
// //               setState(() => _currentIndex = index);
// //             },
// //             itemBuilder: (context, index) {
// //               final slide = _slides[index];
// //               return Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Padding(
// //                     padding: EdgeInsets.symmetric(horizontal: 8.sp),
// //                     child: Text(
// //                       slide['title']!,
// //                       textAlign: TextAlign.center,
// //                       style: TextFontStyle.headline16w600cFAFAFAstyleSora
// //                           .copyWith(fontSize: 24.sp),
// //                     ),
// //                   ),
// //                   UIHelper.verticalSpace(12.h),
// //                   Text(
// //                     slide['description']!,
// //                     textAlign: TextAlign.center,
// //                     style: TextFontStyle.headline12w400cFFFFFFstyleInter
// //                         .copyWith(fontSize: 16.sp),
// //                   ),
// //                 ],
// //               );
// //             },
// //           ),
// //         ),
// //         UIHelper.verticalSpace(24.h),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: List.generate(
// //             _slides.length,
// //             (index) => AnimatedContainer(
// //               duration: const Duration(milliseconds: 300),
// //               margin: const EdgeInsets.symmetric(horizontal: 4),
// //               width: _currentIndex == index ? 16 : 6,
// //               height: 6,
// //               decoration: BoxDecoration(
// //                 color: _currentIndex == index ? Colors.white : Colors.white38,
// //                 borderRadius: BorderRadius.circular(4),
// //               ),
// //             ),
// //           ),
// //         ),
// //         // const SizedBox(height: 32),
// //       ],
// //     );
// //   }
// // }
// class TextSlider extends StatefulWidget {
//   const TextSlider({super.key});

//   @override
//   State<TextSlider> createState() => _TextSliderState();
// }

// class _TextSliderState extends State<TextSlider> {
//   late final PageController _controller;
//   Timer? _timer;

//   final List<Map<String, String>> _slides = [
//     {
//       'title': 'Discover Inspiration\n Anytime, Anywhere',
//       'description':
//           'High-resolution photos across categories like nature, business, lifestyle, and more.',
//     },
//     {
//       'title': 'Free to Use\nPremium to Elevate',
//       'description':
//           'Enjoy free downloads or unlock powerful access with flexible image plans.',
//     },
//     {
//       'title': 'Save, Download &\nManage With Ease',
//       'description':
//           'Access your downloads, manage your subscriptions, and get help.',
//     },
//   ];

//   static const int _initialPage = 1000;
//   int _currentIndex = _initialPage;

//   @override
//   void initState() {
//     super.initState();
//     _controller = PageController(initialPage: _initialPage);
//     _startAutoSlide();
//   }

//   void _startAutoSlide() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (_) {
//       _currentIndex++;
//       _controller.animateToPage(
//         _currentIndex,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final slideCount = _slides.length;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: PageView.builder(
//             controller: _controller,
//             onPageChanged: (index) {
//               setState(() => _currentIndex = index);
//             },
//             itemBuilder: (context, index) {
//               final realIndex = index % slideCount;
//               final slide = _slides[realIndex];

//               return AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 500),
//                 transitionBuilder: (child, animation) {
//                   return FadeTransition(
//                     opacity: animation,
//                     child: SlideTransition(
//                       position: Tween<Offset>(
//                         begin: const Offset(0.1, 0),
//                         end: Offset.zero,
//                       ).animate(animation),
//                       child: child,
//                     ),
//                   );
//                 },
//                 child: Column(
//                   key: ValueKey(realIndex),
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.sp),
//                       child: Text(
//                         slide['title']!,
//                         textAlign: TextAlign.center,
//                         style: TextFontStyle.headline16w600cFAFAFAstyleSora
//                             .copyWith(fontSize: 24.sp),
//                       ),
//                     ),
//                     UIHelper.verticalSpace(12.h),
//                     Text(
//                       slide['description']!,
//                       textAlign: TextAlign.center,
//                       style: TextFontStyle.headline12w400cFFFFFFstyleInter
//                           .copyWith(fontSize: 16.sp),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         UIHelper.verticalSpace(24.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(slideCount, (index) {
//             final isActive = _currentIndex % slideCount == index;
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               width: isActive ? 16 : 6,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: isActive ? Colors.white : Colors.white38,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
