import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/drawer/about_controller.dart';
import '../../resources/mColours.dart';
import '../../resources/res.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/custom_appbar.dart';

class AboutUsPage extends GetView<AboutController> {
  const AboutUsPage({super.key});

  IconData _getIcon(String icon) {
    switch (icon) {
      case "local_shipping":
        return Icons.local_shipping;

      case "location_on":
        return Icons.location_on_rounded;

      case "verified_user":
        return Icons.verified_user_rounded;

      case "supervised_user_circle":
        return Icons.supervised_user_circle_rounded;

      default:
        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.white,

      appBar: CustomAppBar(
        title: "About Us",

        backgroundColor: Colors.white,

        iconColor: const Color(0xFF2F66F6),

        showBack: true,

        showDrawer: false,

        showNotification: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: EdgeInsets.only(bottom: 24.h),

          child: Column(
            children: [
              /// =====================
              /// HERO SECTION
              /// =====================
              Container(
                margin: EdgeInsets.all(16.w),

                padding: EdgeInsets.all(24.w),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,

                    end: Alignment.bottomRight,

                    colors: [Color(0xFF2F66F6), Color(0xFF5A84FF)],
                  ),

                  borderRadius: BorderRadius.circular(30.r),
                ),

                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,

                      children: [
                        /// =========================
                        /// OUTER GLOW
                        /// =========================
                        Container(
                          width: 165.w,
                          height: 165.w,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.20),

                                Colors.white.withOpacity(0.02),
                              ],
                            ),
                          ),
                        ),

                        /// =========================
                        /// MIDDLE GLASS LAYER
                        /// =========================
                        Container(
                          width: 132.w,
                          height: 132.w,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),

                              width: 1.5,
                            ),

                            gradient: LinearGradient(
                              begin: Alignment.topLeft,

                              end: Alignment.bottomRight,

                              colors: [
                                Colors.white.withOpacity(0.30),

                                Colors.white.withOpacity(0.08),
                              ],
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),

                                blurRadius: 24,

                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                        ),

                        /// =========================
                        /// MAIN LOGO CONTAINER
                        /// =========================
                        Container(
                          width: 112.w,
                          height: 112.w,

                          decoration: BoxDecoration(
                            color: Colors.white,

                            shape: BoxShape.circle,

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),

                                blurRadius: 20,

                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: EdgeInsets.all(10.w),

                            child: Image.asset(
                              Res.logoSplash,

                              fit: BoxFit.contain,

                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),

                        /// =========================
                        /// FLOATING DOT TOP
                        /// =========================
                        Positioned(
                          top: 20.h,
                          right: 10.w,

                          child: Container(
                            width: 16.w,
                            height: 16.w,

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.75),

                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                        /// =========================
                        /// FLOATING DOT BOTTOM
                        /// =========================
                        Positioned(
                          bottom: 14.h,
                          left: 12.w,

                          child: Container(
                            width: 12.w,
                            height: 12.w,

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.45),

                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    Obx(
                      () => Text(
                        controller.appName.value,

                        textAlign: TextAlign.center,

                        style: CustomTextTheme.extraBold(
                          color: Colors.white,

                          fontSize: 28.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Obx(
                      () => Text(
                        controller.slogan.value,

                        textAlign: TextAlign.center,

                        style: CustomTextTheme.medium(
                          color: Colors.white70,

                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// =====================
              /// DESCRIPTION
              /// =====================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),

                child: Obx(
                  () => Text(
                    controller.description.value,

                    textAlign: TextAlign.center,

                    style: CustomTextTheme.medium(
                      color: Colors.black87,

                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 28.h),

              /// =====================
              /// STATS
              /// =====================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),

                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: "Vehicles",

                        value: controller.totalVehicles.value,
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: _StatCard(
                        title: "Drivers",

                        value: controller.activeDrivers.value,
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: _StatCard(
                        title: "Trips",

                        value: controller.completedTrips.value,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              /// =====================
              /// FEATURES TITLE
              /// =====================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),

                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Why Choose Us",

                    style: CustomTextTheme.bold(
                      color: Colors.black,

                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 18.h),

              /// =====================
              /// FEATURES LIST
              /// =====================
              Obx(
                () => ListView.builder(
                  itemCount: controller.features.length,

                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  padding: EdgeInsets.symmetric(horizontal: 16.w),

                  itemBuilder: (context, index) {
                    final item = controller.features[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),

                      padding: EdgeInsets.all(18.w),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(24.r),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),

                            blurRadius: 18,

                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Container(
                            width: 54.w,
                            height: 54.w,

                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2F66F6), Color(0xFF5A84FF)],
                              ),

                              borderRadius: BorderRadius.circular(18.r),
                            ),

                            child: Icon(
                              _getIcon(item["icon"]),

                              color: Colors.white,

                              size: 28.sp,
                            ),
                          ),

                          SizedBox(width: 16.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  item["title"],

                                  style: CustomTextTheme.bold(
                                    color: Colors.black,

                                    fontSize: 16.sp,
                                  ),
                                ),

                                SizedBox(height: 6.h),

                                Text(
                                  item["description"],

                                  style: CustomTextTheme.medium(
                                    color: Colors.black54,

                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =========================
/// STAT CARD
/// =========================

class _StatCard extends StatelessWidget {
  final String title;

  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.h),

      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FF),

        borderRadius: BorderRadius.circular(22.r),
      ),

      child: Column(
        children: [
          Text(
            value,

            style: CustomTextTheme.extraBold(
              color: const Color(0xFF2F66F6),

              fontSize: 24.sp,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            title,

            style: CustomTextTheme.medium(
              color: Colors.black54,

              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
