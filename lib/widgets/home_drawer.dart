import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:transport_wala/utility/utility.dart';

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

              /// PROFILE CARD
              Container(
                padding: EdgeInsets.all(14.w),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,

                  borderRadius: BorderRadius.circular(18.r),
                ),

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32.r,

                      backgroundImage: AssetImage(Res.splashTruck),
                    ),

                    SizedBox(width: 16.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Prosenjit Swarnakar",

                            style: CustomTextTheme.bold(
                              color: Colors.black,

                              fontSize: 19.sp,
                            ),
                          ),

                          Text(
                            "Owner",

                            style: CustomTextTheme.medium(
                              color: Colors.black54,

                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {},

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
              ),

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

                  Get.toNamed(
                    AppRoutes.driverPage,
                  );
                },
              ),

              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.info_outline_rounded,

                title: "About Us",

                onTap: () {

                  Get.back();

                  Get.toNamed(
                    AppRoutes.aboutPage,
                  );
                },
              ),

              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.gavel_rounded,

                title: "Terms & Conditions",

                onTap: () {

                  Get.back();

                  Get.toNamed(
                    AppRoutes.termsPage,
                  );
                },
              ),
              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.privacy_tip_outlined,

                title: "Privacy Policy",

                onTap: () {

                  Get.back();

                  Get.toNamed(
                    AppRoutes.privacyPolicyPage,
                  );
                },
              ),

              SizedBox(height: 24.h),

              _DrawerItem(
                icon: Icons.contact_mail_outlined,

                title: "Contact Us",

                onTap: () {

                  Get.back();

                  Get.toNamed(
                    AppRoutes.contactUsPage,
                  );
                },
              ),


              const Spacer(),

              Divider(color: Colors.black12),

              SizedBox(height: 14.h),

              /// LOGOUT
              Row(
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
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;

  final String title;

  final VoidCallback? onTap;

  const _DrawerItem({
    required this.icon,

    required this.title,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Row(
        children: [

          Icon(
            icon,

            size: 24.sp,

            color: Colors.black87,
          ),

          SizedBox(width: 18.w),

          Text(
            title,

            style:
            CustomTextTheme.semiBold(
              color: Colors.black87,

              fontSize: 17.sp,
            ),
          ),
        ],
      ),
    );
  }
}
