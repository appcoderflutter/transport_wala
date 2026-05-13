import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:transport_wala/utility/utility.dart';
import 'package:get/get.dart';

import '../../model/profile_model.dart';
import '../../model/user_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../prefs/prefs.dart';
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

      const Duration(
        milliseconds:
        Consts.splashDelay,
      ),
    );

    /// ONBOARDING CHECK

    final seenOnboarding =
    Prefs.getSeenOnboarding();

    if (!seenOnboarding) {

      Get.offAllNamed(
        AppRoutes.onboarding,
      );

      return;
    }

    /// TOKEN

    final token =
    Prefs.getToken();

    /// NO TOKEN

    if (token == null ||
        token.isEmpty) {

      Get.offAllNamed(
        AppRoutes.loginPage,
      );

      return;
    }

    try {

      await DioHelper.builder()

          .setMethod("GET")

          .setUrl(
          ApiEndpoints.getProfile)

          .execute<ProfileModel>(

        fromJson: (json) =>
            ProfileModel
                .fromJson(json),

        onSuccess: (response) {

          final user =
              response.payload?.user;

          /// SAVE USER DATA

          if (user != null) {

            Prefs.setUserData(

              UserModel(

                userId:
                user.userId,

                uniqueUserId:
                user.uniqueUserId,

                userType:
                user.userType,

                name:
                user.name,

                email:
                user.email,

                isEmailVerified:
                user.isEmailVerified,

                isdCode:
                user.isdCode,

                phone:
                user.phone,

                isPhoneVerified:
                user.isPhoneVerified,

                profilePic:
                user.profilePic,

                userActiveRoutes:
                user.userActiveRoutes,

                userActiveVehicles:
                user.userActiveVehicles,

                isKycVerified:
                user.isKycVerified,

                paymentTerm:
                user.paymentTerm,

                avgRating:
                user.avgRating,

                kycData:
                user.kycData,
              ),
            );
          }

          /// HOME

          Get.offAllNamed(
            AppRoutes.homePage,
          );
        },

        onFailure:
            (message, {code}) {

          /// TOKEN EXPIRED

          Prefs.setIsLogin(false);

          Prefs.setToken("");

          Get.offAllNamed(
            AppRoutes.loginPage,
          );
        },
      );

    } catch (e) {

      /// ERROR

      Prefs.setIsLogin(false);

      Prefs.setToken("");

      Get.offAllNamed(
        AppRoutes.loginPage,
      );
    }
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