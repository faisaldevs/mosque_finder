import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:mosque_finder_app/app/di/di.dart';
import 'package:mosque_finder_app/app/provider/register_provider.dart';
import 'package:mosque_finder_app/app/router/app_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set transparent status bar with black icons/text
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark, // For iOS - dark text
      statusBarIconBrightness: Brightness.dark, // For Android - dark icons
    ),
  );

  await initializeApp();
  runApp(MyApp());
}

Future<void> initializeApp() async {
  await initializeHive();

  await diSetup();
  AppRouter.setupRouter();

  // initiInternetChecker();

  // DioSingleton.instance.create();

  ///======================================================
  ///======================================================
  // // Firebase and Notifications setup (optional)
  // // Uncomment these if Firebase and notifications are needed
  ///======================================================
  ///======================================================

 
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
}

Future<void> initializeHive() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  // await UserProfileService().init();
  // await LoginLocalService().init();
  // await RememberMeService().init();
  // await ProfileLocalService().init();

  // await CurrentPlanLocalService().init();

  // // Adapters

  // // Hive.registerAdapter(UserProfileAdapter());
  // if (!Hive.isAdapterRegistered(0)) {
  //   Hive.registerAdapter(UserProfileAdapter());
  // }

  // // Hive.registerAdapter(WishlistLocalModelAdapter());
  // // Hive.registerAdapter(LoginLocalModelAdapter());
  // await Hive.openBox('hive_app');
  // await Hive.openBox<List>('selected_collections');
  // await Hive.openBox<String>('favouritesBox');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // rotation();
    // setInitValue();

    return MultiProvider(
      providers: providers,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, t) async {
          // showMaterialDialog(context: context);
        },
        child: const UtillScreenMobile(),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // Transparent background
            statusBarBrightness: Brightness.dark, // For iOS - dark text
            statusBarIconBrightness:
                Brightness.dark, // For Android - dark icons
          ),
          child: PopScope(
            canPop: false,

            onPopInvokedWithResult: (_, __) async {
              // showMaterialDialog(context: context);
            },
            
            child: MaterialApp.router(
              // scaffoldMessengerKey: SnackbarService().key,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            ),
          ),
        );
      },
    );
  }
}
