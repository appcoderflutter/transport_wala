import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding/onboarding_controller.dart';
import '../../resources/mColours.dart';
import '../../resources/res.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../utility/utility.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.white,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),

          child: Column(
            children: [
              /// TOP SPACE

              /// IMAGE
              Expanded(
                flex: 6,

                child: Center(
                  child: Hero(
                    tag: "onboarding_image",

                    child: Image.asset(
                      Res.onboardingImage,
                      width: 410.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              /// TITLE
              Text(
                "Connect smoothly\nand Run Business Long",

                textAlign: TextAlign.center,

                style: CustomTextTheme.extraBold(
                  fontSize: 22.sp,
                  color: Colors.black,
                ),
              ),

              hGap(18.h),

              /// DESCRIPTION
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),

                child: Text(
                  "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.",

                  textAlign: TextAlign.center,

                  style: CustomTextTheme.medium(
                    fontSize: 15.sp,
                    color: Colors.black87,
                  ),
                ),
              ),

              /// BUTTON SPACE
              hGap(40.h),

              /// GET STARTED BUTTON
              GestureDetector(
                onTap: controller.onGetStarted,

                child: Container(
                  width: 270.w,
                  height: 58.h,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),

                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,

                      colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2F66F6).withOpacity(0.22),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Center(
                    child: Text(
                      "Get Started",

                      style: CustomTextTheme.bold(
                        color: Colors.white,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
              ),

              hGap(20.h),

              /// LOGIN TEXT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Already have a account ? ",

                    style: CustomTextTheme.medium(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),

                  GestureDetector(
                    onTap: controller.onLogin,

                    child: Text(
                      "Login",
                      style: CustomTextTheme.bold(
                        fontSize: 14.sp,
                        color: const Color(0xFF2F66F6),
                      ),
                    ),
                  ),
                ],
              ),
              hGap(50.h),
            ],
          ),
        ),
      ),
    );
  }
}
