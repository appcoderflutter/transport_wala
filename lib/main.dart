import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:transport_wala/resources/app_theme.dart';
import 'package:transport_wala/resources/mStrings.dart';
import 'package:transport_wala/routes/app_routes.dart';
import 'package:transport_wala/service/app_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// System UI
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /// Portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// Critical initialization BEFORE app starts
  await AppInitializer.initCritical();

  /// Run app
  runApp(const MyApp());

  /// Background initialization AFTER app starts
  Future.delayed(const Duration(seconds: 2), () async {
    await AppInitializer.initBackground();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 968),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: MString.appName,

          /// Theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,

          /// Debug
          debugShowCheckedModeBanner: false,

          /// Navigation animation
          defaultTransition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),

          /// Navigator key
          navigatorKey: navigatorKey,

          /// Initial route
          initialRoute: AppRoutes.splash,

          /// Routes
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
