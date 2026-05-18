import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/drawer/my_profile_controller.dart';
import '../../resources/text_styes/custome_text.dart';

class MyProfilePage extends GetView<ProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      body: Obx(() {
        final user = controller.user.value;

        return Column(
          children: [
            /// =========================
            /// TOP SECTION
            /// =========================
            Container(
              width: double.infinity,

              padding: EdgeInsets.only(
                top: 50.h,
                left: 22.w,
                right: 22.w,
                bottom: 38.h,
              ),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                ),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),

                  bottomRight: Radius.circular(32.r),
                ),
              ),

              child: Column(
                children: [
                  /// APPBAR
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },

                        child: Icon(
                          Icons.arrow_back,

                          color: Colors.white,

                          size: 26.sp,
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            "My Profile",

                            style: CustomTextTheme.bold(
                              color: Colors.white,

                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 26.w),
                    ],
                  ),

                  SizedBox(height: 34.h),

                  /// =========================
                  /// PROFILE IMAGE
                  /// =========================
                  Stack(
                    clipBehavior: Clip.none,

                    children: [
                      /// IMAGE
                      GestureDetector(
                        onTap: () {
                          if (controller.hasImage) {
                            Get.dialog(
                              Dialog(
                                backgroundColor: Colors.black,

                                insetPadding: EdgeInsets.all(14.w),

                                child: InteractiveViewer(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(22.r),

                                    child: Image.network(
                                      user!.profilePic!,

                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },

                        child: Container(
                          width: 112.w,
                          height: 112.w,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            color: Colors.white,

                            border: Border.all(color: Colors.white, width: 3),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.18),

                                blurRadius: 22,

                                offset: const Offset(0, 10),
                              ),
                            ],

                            image: controller.hasImage
                                ? DecorationImage(
                                    image: NetworkImage(
                                      "${user!.profilePic!}?t=${DateTime.now().millisecondsSinceEpoch}",
                                    ),

                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),

                          child: controller.hasImage
                              ? null
                              : Icon(
                                  Icons.person_rounded,

                                  size: 54.sp,

                                  color: const Color(0xFF2F66F6),
                                ),
                        ),
                      ),

                      /// =========================
                      /// LOADER
                      /// =========================
                      if (controller.isUploading.value)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.45),

                              shape: BoxShape.circle,
                            ),

                            child: Center(
                              child: SizedBox(
                                width: 26.w,
                                height: 26.w,

                                child: const CircularProgressIndicator(
                                  color: Colors.white,

                                  strokeWidth: 2.5,
                                ),
                              ),
                            ),
                          ),
                        ),

                      /// =========================
                      /// EDIT BUTTON
                      /// =========================
                      Positioned(
                        right: -2,
                        bottom: -2,

                        child: GestureDetector(
                          onTap: () {
                            if (!controller.isUploading.value) {
                              controller.pickProfileImage();
                            }
                          },

                          child: Container(
                            width: 38.w,
                            height: 38.w,

                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                              ),

                              shape: BoxShape.circle,

                              border: Border.all(color: Colors.white, width: 2),

                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF2F66F6,
                                  ).withOpacity(.35),

                                  blurRadius: 14,

                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),

                            child: Icon(
                              Icons.camera_alt_rounded,

                              color: Colors.white,

                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// NAME
                  Text(
                    controller.name,

                    textAlign: TextAlign.center,

                    style: CustomTextTheme.extraBold(
                      color: Colors.white,

                      fontSize: 26.sp,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// TYPE
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),

                      borderRadius: BorderRadius.circular(30.r),
                    ),

                    child: Text(
                      controller.userType,

                      style: CustomTextTheme.medium(
                        color: Colors.white,

                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// =========================
            /// BODY
            /// =========================
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(22.w),

                child: Column(
                  children: [
                    /// INFO CARD
                    Container(
                      padding: EdgeInsets.all(22.w),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(24.r),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),

                            blurRadius: 20,

                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          _infoTile(
                            icon: Icons.email_outlined,

                            title: "Email",

                            value: controller.email,

                            isVerified:
                                controller.user.value?.isEmailVerified == "1",
                          ),

                          SizedBox(height: 24.h),

                          _infoTile(
                            icon: Icons.phone_outlined,

                            title: "Phone",

                            value: controller.phone,

                            isVerified:
                                controller.user.value?.isPhoneVerified == "1",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.h),

                    /// BUTTONS
                    Row(
                      children: [
                        /// ADD KYC
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              /// TODO
                            },

                            child: Container(
                              height: 58.h,

                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2F66F6),

                                    Color(0xFF001A9F),
                                  ],
                                ),

                                borderRadius: BorderRadius.circular(18.r),
                              ),

                              child: Center(
                                child: Text(
                                  "Add KYC",

                                  style: CustomTextTheme.bold(
                                    color: Colors.white,

                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 16.w),

                        /// EDIT PROFILE
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              /// TODO
                            },

                            child: Container(
                              height: 58.h,

                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(18.r),

                                border: Border.all(
                                  color: const Color(0xFF2F66F6),

                                  width: 1.5,
                                ),
                              ),

                              child: Center(
                                child: Text(
                                  "Edit Profile",

                                  style: CustomTextTheme.bold(
                                    color: const Color(0xFF2F66F6),

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
          ],
        );
      }),
    );
  }

  Widget _infoTile({
    required IconData icon,

    required String title,

    required String value,

    bool isVerified = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          width: 48.w,
          height: 48.w,

          decoration: BoxDecoration(
            color: const Color(0xFFEEF3FF),

            borderRadius: BorderRadius.circular(14.r),
          ),

          child: Icon(icon, color: const Color(0xFF2F66F6), size: 24.sp),
        ),

        SizedBox(width: 16.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: CustomTextTheme.medium(
                  color: Colors.black54,

                  fontSize: 13.sp,
                ),
              ),

              SizedBox(height: 6.h),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      value,

                      style: CustomTextTheme.bold(
                        color: Colors.black87,

                        fontSize: 16.sp,
                      ),
                    ),
                  ),

                  if (isVerified)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.12),

                        borderRadius: BorderRadius.circular(20.r),
                      ),

                      child: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Icon(
                            Icons.verified_rounded,

                            color: Colors.green,

                            size: 14.sp,
                          ),

                          SizedBox(width: 4.w),

                          Text(
                            "Verified",

                            style: TextStyle(
                              color: Colors.green,

                              fontSize: 11.sp,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
