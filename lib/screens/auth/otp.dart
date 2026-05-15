import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../controllers/auth/otp_controller.dart';
import '../../resources/res.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../utility/utility.dart';

class OtpPage extends GetView<OtpController> {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 68.w,
      height: 68.w,

      textStyle: TextStyle(
        fontSize: 24.sp,

        fontWeight: FontWeight.w700,

        color: Colors.black,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FF),

        borderRadius: BorderRadius.circular(22.r),

        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),

            child: Column(
              children: [
                SizedBox(height: 16.h),

                /// BACK
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),

                      child: Icon(
                        Icons.arrow_back,
                        size: 30.sp,
                        color: const Color(0xFF2F66F6),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                /// IMAGE
                Image.asset(Res.signupImage, width: 290.w, fit: BoxFit.contain),

                SizedBox(height: 20.h),

                /// TITLE
                Text(
                  "OTP Verification",

                  style: CustomTextTheme.extraBold(
                    color: Colors.black,

                    fontSize: 28.sp,
                  ),
                ),

                SizedBox(height: 12.h),

                /// SUBTITLE
                Text(
                  "We have sent a verification code to\n+91 ${controller.phone}",

                  textAlign: TextAlign.center,

                  style: CustomTextTheme.medium(
                    color: Colors.black54,

                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 20.h),

                /// DEMO OTP BOX
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 8.h,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7FF),

                    borderRadius: BorderRadius.circular(14.r),

                    border: Border.all(color: const Color(0xFFDCE5FF)),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Container(
                        width: 18.w,
                        height: 18.w,

                        decoration: BoxDecoration(
                          color: const Color(0xFF2F66F6),

                          borderRadius: BorderRadius.circular(12.r),
                        ),

                        child: Icon(
                          Icons.lock_rounded,

                          color: Colors.white,

                          size: 11.sp,
                        ),
                      ),

                      SizedBox(width: 14.w),

                      Obx(() {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "OTP : ",

                                style: TextStyle(
                                  color: Colors.black54,

                                  fontSize: 15.sp,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              TextSpan(
                                text: controller.otpCode.value,

                                style: TextStyle(
                                  color: const Color(0xFF2F66F6),

                                  fontSize: 15.sp,

                                  fontWeight: FontWeight.w800,

                                  letterSpacing: 3,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                hGap(20.h),

                /// OTP FIELD
                Pinput(
                  controller: controller.otpController,

                  length: 4,

                  defaultPinTheme: defaultPinTheme,

                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                    border: Border.all(
                      color: const Color(0xFF2F66F6),

                      width: 1.5,
                    ),

                    color: Colors.white,
                  ),

                  submittedPinTheme: defaultPinTheme.copyDecorationWith(
                    color: const Color(0xFFEFF3FF),
                  ),
                ),

                SizedBox(height: 28.h),

                /// RESEND
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "Didn't receive code? ",

                        style: CustomTextTheme.medium(
                          color: Colors.black54,

                          fontSize: 14.sp,
                        ),
                      ),

                      controller.seconds.value == 0
                          ? GestureDetector(
                              onTap: controller.resendOtp,

                              child: Text(
                                "Resend OTP",

                                style: CustomTextTheme.bold(
                                  color: const Color(0xFF2F66F6),

                                  fontSize: 14.sp,
                                ),
                              ),
                            )
                          : Text(
                              "00:${controller.seconds.value}",

                              style: CustomTextTheme.bold(
                                color: const Color(0xFF2F66F6),

                                fontSize: 14.sp,
                              ),
                            ),
                    ],
                  );
                }),

                SizedBox(height: 30.h),

                /// BUTTON
                GestureDetector(
                  onTap: controller.verifyOtp,

                  child: Container(
                    width: 250.w,

                    height: 58.h,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),

                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,

                        end: Alignment.centerRight,

                        colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2F66F6).withOpacity(0.25),

                          blurRadius: 18,

                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Center(
                      child: Text(
                        "Verify OTP",

                        style: CustomTextTheme.bold(
                          color: Colors.white,

                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
