import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';

import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    await _initializeApp();

    if (!mounted) return;
  }

  Future<void> _initializeApp() async {
    log("App initialization started");

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    log("App initialization finished");

    // final loginService = LoginLocalService();

    // if (loginService.isLoggedIn) {
    //   DioSingleton.instance.updateAuth(
    //     loginService.accessToken!,
    //   );

    //   nav.toNavigation();
    // } else {
    nav.toLogin();
    // }
  }

  @override
  Widget build(BuildContext context) {
    log("Building WelcomeScreen...");
    return const WelcomeScreen();
  }
}
