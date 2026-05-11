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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),

                child: Obx(() {
                  /// LOADING

                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: 300.h,

                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  /// EMPTY

                  if (controller.aboutData.value == null) {
                    return Container(
                      width: double.infinity,

                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 30.h,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(28.r),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),

                            blurRadius: 18,

                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Container(
                            width: 72.w,
                            height: 72.w,

                            decoration: const BoxDecoration(
                              color: Color(0xFFEEF3FF),

                              shape: BoxShape.circle,
                            ),

                            child: Icon(
                              Icons.info_outline,

                              color: Color(0xFF2F66F6),

                              size: 34.sp,
                            ),
                          ),

                          SizedBox(height: 18.h),

                          Text(
                            "No Information Found",

                            style: CustomTextTheme.bold(
                              color: Colors.black87,

                              fontSize: 18.sp,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            "About us information is currently unavailable.",

                            textAlign: TextAlign.center,

                            style: CustomTextTheme.medium(
                              color: Colors.black54,

                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  /// DATA

                  return Container(
                    width: double.infinity,

                    padding: EdgeInsets.all(22.w),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(28.r),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),

                          blurRadius: 18,

                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Container(
                              width: 42.w,
                              height: 42.w,

                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2F66F6),

                                    Color(0xFF5A84FF),
                                  ],
                                ),

                                borderRadius: BorderRadius.circular(14.r),
                              ),

                              child: Icon(
                                Icons.info_rounded,

                                color: Colors.white,

                                size: 22.sp,
                              ),
                            ),

                            SizedBox(width: 12.w),

                            Text(
                              "About Company",

                              style: CustomTextTheme.bold(
                                color: Colors.black,

                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 22.h),

                        Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: (controller
                              .aboutData
                              .value
                              ?.aboutUs ?? "")

                              .split('\n')

                              .where((e) => e.trim().isNotEmpty)

                              .map(

                                (paragraph) => Padding(

                              padding:
                              EdgeInsets.only(
                                bottom: 16.h,
                              ),

                              child: Text(

                                paragraph.trim(),

                                style:
                                CustomTextTheme.regular(

                                  color:
                                  Colors.black87,

                                  fontSize:
                                  16.sp,
                                ),
                              ),
                            ),
                          )

                              .toList(),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
