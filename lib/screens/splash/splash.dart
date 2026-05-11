import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:transport_wala/utility/utility.dart';
import 'package:get/get.dart';

import '../../resources/mColours.dart';
import '../../resources/res.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../routes/app_routes.dart';
import '../../utility/const.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static bool _navigated = false;

  static final Future<String> _versionFuture = _getVersion();

  static Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    return 'V${info.version}';
  }

  static void startNavigation() async {
    if (_navigated) return;

    _navigated = true;

    await Future.delayed(
      const Duration(milliseconds: Consts.splashDelay),
    );

    Get.offAllNamed(AppRoutes.onboarding);

    // ========= FUTURE READY =========

    // bool seenOnboarding = Prefs.getSeenOnboarding();
    // bool isLoggedIn = Prefs.isLoggedIn();
    //
    // if (!seenOnboarding) {
    //   Get.offAllNamed(AppRoutes.onboarding);
    // } else if (isLoggedIn) {
    //   Get.offAllNamed(AppRoutes.bottomNav);
    // } else {
    //   Get.offAllNamed(AppRoutes.login);
    // }
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      startNavigation();
    });

    return Scaffold(
      backgroundColor: MColors.white,

      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,

          child: Column(
            children: [

              const Spacer(),

              /// Truck Image
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.92, end: 1),
                duration: const Duration(milliseconds: 1400),
                curve: Curves.easeInOut,

                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },

                child: Image.asset(
                  Res.splashTruck,
                  width: 180.w,
                ),
              ),

              hGap(18.h),

              /// Logo Text Image
              Image.asset(
                Res.logoSplash,
                width: 225.w,
                fit: BoxFit.contain,
              ),

              const Spacer(),

              /// Version
              FutureBuilder<String>(
                future: _versionFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  return Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Text(
                      snapshot.data!,
                      style: CustomTextTheme.medium(color: MColors.metaTextColor),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}