import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:transport_wala/utility/utility.dart';

import '../helpers/custome_loader.dart';
import '../helpers/toaster.dart';
import '../network_call/apis/apis_endpoint.dart';
import '../network_call/dio_helper/dio_helper.dart';
import '../prefs/prefs.dart';
import '../resources/res.dart';
import '../resources/text_styes/custome_text.dart';
import '../routes/app_routes.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();

    return "V ${info.version}";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,

      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),

          child: Column(
            children: [
              SizedBox(height: 8.h),

              /// LOGO
              Align(
                alignment: Alignment.centerLeft,

                child: Image.asset(
                  Res.logoSplash,

                  width: 220.w,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 24.h),

              /// ✅ PROFILE CARD - DYNAMIC DATA
              Obx(() {
                final user = Prefs.userRx.value;
                final userName = user?.name?.isNotEmpty == true
                    ? user!.name!
                    : "User";
                final userRole = user?.userType?.isNotEmpty == true
                    ? user!.userType!
                    : "Owner";

                return Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Row(
                    children: [
                      /// ✅ DYNAMIC PROFILE IMAGE
                      Container(
                        width: 64.w,
                        height: 64.w,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,

                            end: Alignment.bottomRight,

                            colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                          ),

                          image: _hasProfileImage(user?.profilePic)
                              ? DecorationImage(
                                  image: NetworkImage(user!.profilePic!),

                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),

                        child: !_hasProfileImage(user?.profilePic)
                            ? Icon(
                                Icons.person_rounded,

                                color: Colors.white,

                                size: 34.sp,
                              )
                            : null,
                      ),

                      SizedBox(width: 16.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: CustomTextTheme.bold(
                                color: Colors.black,
                                fontSize: 19.sp,
                              ),
                            ),
                            Text(
                              userRole,
                              style: CustomTextTheme.medium(
                                color: Colors.black54,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {

                          Get.back();

                          Get.toNamed(
                            AppRoutes.myProfilePage,
                          );
                        },
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF2F66F6),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: const Color(0xFF2F66F6),
                            size: 17.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              SizedBox(height: 30.h),

              /// MENU
              _DrawerItem(icon: Icons.description_outlined, title: "KYC"),

              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.local_shipping_outlined,

                title: "Your Truck",
              ),

              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.supervised_user_circle_outlined,

                title: "Drivers",

                onTap: () {
                  Get.back();

                  Get.toNamed(AppRoutes.driverPage);
                },
              ),

              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.info_outline_rounded,

                title: "About Us",

                onTap: () {
                  Get.back();

                  Get.toNamed(AppRoutes.aboutPage);
                },
              ),

              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.gavel_rounded,

                title: "Terms & Conditions",

                onTap: () {
                  Get.back();

                  Get.toNamed(AppRoutes.termsPage);
                },
              ),
              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.privacy_tip_outlined,

                title: "Privacy Policy",

                onTap: () {
                  Get.back();

                  Get.toNamed(AppRoutes.privacyPolicyPage);
                },
              ),

              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.contact_mail_outlined,

                title: "Contact Us",

                onTap: () {
                  Get.back();

                  Get.toNamed(AppRoutes.contactUsPage);
                },
              ),

              const Spacer(),

              Divider(color: Colors.black12),

              SizedBox(height: 14.h),

              /// LOGOUT
              GestureDetector(
                onTap: () async {
                  final result = await Get.dialog<bool>(
                    Dialog(
                      backgroundColor: Colors.transparent,

                      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),

                      child: Container(
                        padding: EdgeInsets.all(24.w),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(32.r),
                        ),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            /// ICON
                            Container(
                              width: 82.w,
                              height: 82.w,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,

                                  end: Alignment.bottomRight,

                                  colors: [
                                    Color(0xFF2F66F6),

                                    Color(0xFF001A9F),
                                  ],
                                ),
                              ),

                              child: Icon(
                                Icons.power_settings_new_rounded,

                                color: Colors.white,

                                size: 40.sp,
                              ),
                            ),

                            SizedBox(height: 26.h),

                            /// TITLE
                            Text(
                              "Logout Account?",

                              style: CustomTextTheme.extraBold(
                                color: Colors.black,

                                fontSize: 24.sp,
                              ),
                            ),

                            SizedBox(height: 12.h),

                            /// SUBTITLE
                            Text(
                              "Are you sure you want to logout from your account?",

                              textAlign: TextAlign.center,

                              style: CustomTextTheme.medium(
                                color: Colors.black54,

                                fontSize: 14.sp,
                              ),
                            ),

                            SizedBox(height: 30.h),

                            /// BUTTONS
                            Row(
                              children: [
                                /// CANCEL
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back(result: false);
                                    },

                                    child: Container(
                                      height: 54.h,

                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF4F6FB),

                                        borderRadius: BorderRadius.circular(
                                          18.r,
                                        ),
                                      ),

                                      child: Center(
                                        child: Text(
                                          "Cancel",

                                          style: CustomTextTheme.bold(
                                            color: Colors.black87,

                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 14.w),

                                /// LOGOUT
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back(result: true);
                                    },

                                    child: Container(
                                      height: 54.h,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          18.r,
                                        ),

                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF2F66F6),

                                            Color(0xFF001A9F),
                                          ],
                                        ),
                                      ),

                                      child: Center(
                                        child: Text(
                                          "Logout",

                                          style: CustomTextTheme.bold(
                                            color: Colors.white,

                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  /// CONFIRM LOGOUT

                  if (result == true) {
                    try {
                      Loader.show();

                      await DioHelper.builder()
                          .setMethod("POST")
                          .setUrl(ApiEndpoints.logout)
                          .execute(
                            onSuccess: (response) {
                              /// CLEAR LOCAL DATA

                              Prefs.setIsLogin(false);

                              /// HIDE LOADER

                              Loader.hide();

                              AppToast.short("Logout Successful");

                              /// GO LOGIN

                              Get.offAllNamed(AppRoutes.loginPage);
                            },

                            onFailure: (message, {code}) {
                              /// EVEN IF API FAILS
                              /// FORCE LOGOUT

                              Prefs.setIsLogin(false);

                              Loader.hide();

                              Get.offAllNamed(AppRoutes.loginPage);
                            },
                          );
                    } catch (e) {
                      Loader.hide();

                      /// FORCE CLEAR

                      Prefs.setIsLogin(false);

                      Get.offAllNamed(AppRoutes.loginPage);
                    }
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.power_settings_new_rounded,

                      color: const Color(0xFF2F66F6),

                      size: 26.sp,
                    ),

                    SizedBox(width: 16.w),

                    Text(
                      "Logout",

                      style: CustomTextTheme.semiBold(
                        color: Colors.black87,

                        fontSize: 17.sp,
                      ),
                    ),

                    const Spacer(),

                    FutureBuilder<String>(
                      future: _getVersion(),

                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data ?? "",

                          style: CustomTextTheme.medium(
                            color: Colors.black38,

                            fontSize: 12.sp,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),

              /// BOTTOM IMAGE
              Image.asset(
                Res.sideNavBanner,

                width: double.infinity,

                fit: BoxFit.contain,
              ),
              hGap(5.h),
            ],
          ),
        ),
      ),
    );
  }

  bool _hasProfileImage(String? profilePic) {
    return profilePic != null && profilePic.isNotEmpty && profilePic != "NA";
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;

  final String title;

  final VoidCallback? onTap;

  const _DrawerItem({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Row(
        children: [
          Icon(icon, size: 24.sp, color: Colors.black87),

          SizedBox(width: 18.w),

          Text(
            title,

            style: CustomTextTheme.semiBold(
              color: Colors.black87,

              fontSize: 17.sp,
            ),
          ),
        ],
      ),
    );
  }
}
