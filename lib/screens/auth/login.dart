import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/auth/login_controller.dart';
import '../../resources/res.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/auth_text_field.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

          child: Padding(
            padding: EdgeInsets.only(
              left: 26.w,
              right: 26.w,

              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),

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
                Image.asset(Res.signupImage, width: 340.w, fit: BoxFit.contain),

                SizedBox(height: 12.h),

                /// TITLE
                Text(
                  "Welcome Back",

                  style: CustomTextTheme.extraBold(
                    fontSize: 28.sp,

                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 10.h),

                /// SUBTITLE
                Text(
                  "Login with your registered number to continue",

                  textAlign: TextAlign.center,

                  style: CustomTextTheme.medium(
                    color: Colors.black54,

                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 42.h),

                /// PHONE FIELD
                AuthTextField(
                  hint: "Enter your phone number",

                  keyboardType: TextInputType.phone,

                  controller: controller.phoneController,

                  maxLength: 10,
                ),

                SizedBox(height: 42.h),

                /// BUTTON
                Obx(() {
                  return GestureDetector(
                    onTap: controller.isLoading.value
                        ? null
                        : controller.onLogin,

                    child: Container(
                      width: 250.w,

                      height: 58.h,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),

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
                        child: controller.isLoading.value
                            ? SizedBox(
                                width: 24.w,
                                height: 24.w,

                                child: const CircularProgressIndicator(
                                  color: Colors.white,

                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Login",

                                style: CustomTextTheme.bold(
                                  color: Colors.white,

                                  fontSize: 17.sp,
                                ),
                              ),
                      ),
                    ),
                  );
                }),

                SizedBox(height: 22.h),

                /// SIGN UP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      "Don't have an account? ",

                      style: CustomTextTheme.medium(
                        color: Colors.black87,

                        fontSize: 14.sp,
                      ),
                    ),

                    GestureDetector(
                      onTap: controller.goToRegister,

                      child: Text(
                        "Sign Up",

                        style: CustomTextTheme.bold(
                          color: const Color(0xFF2F66F6),

                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 100.h),
              ],
            ),
          ),),
      ),
    );
  }
}
