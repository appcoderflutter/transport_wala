/// =============================
/// REGISTER PAGE
/// =============================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:transport_wala/utility/utility.dart';

import '../../controllers/auth/register_controller.dart';
import '../../resources/res.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/auth_text_field.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: Get.height),

            child: Padding(
              padding: EdgeInsets.only(
                left: 26.w,
                right: 26.w,

                /// KEYBOARD SPACE
                bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
              ),

              child: IntrinsicHeight(
                child: Column(
                  children: [
                    /// APPBAR
                    SizedBox(height: 10.h),

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

                    /// IMAGE
                    Expanded(
                      flex: 5,

                      child: Center(
                        child: Image.asset(
                          Res.signupImage,
                          width: 400.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    /// TITLE
                    Text(
                      "Create an Account",

                      style: CustomTextTheme.extraBold(
                        fontSize: 24.sp,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: 30.h),

                    /// NAME
                    AuthTextField(
                      hint: "Enter your name",
                      controller: controller.nameController,
                    ),

                    SizedBox(height: 16.h),

                    /// PHONE
                    AuthTextField(
                      hint: "Enter your phone number",
                      keyboardType: TextInputType.phone,
                      controller: controller.phoneController,
                      maxLength: 10,
                    ),

                    SizedBox(height: 16.h),

                    /// DROPDOWN
                    Obx(
                      () => Container(
                        height: 52.h,
                        width: double.infinity,

                        padding: EdgeInsets.symmetric(horizontal: 16.w),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(8.r),
                        ),

                        child: DropdownButton<String>(
                          value: controller.selectedRole.value,

                          isExpanded: true,

                          underline: const SizedBox(),

                          borderRadius: BorderRadius.circular(10.r),

                          menuMaxHeight: 200,

                          alignment: Alignment.centerLeft,

                          dropdownColor: Colors.white,

                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.black45,
                            size: 24.sp,
                          ),

                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          items: const [
                            DropdownMenuItem(
                              value: "Vehicle Owner",
                              child: Text("Vehicle Owner"),
                            ),

                            DropdownMenuItem(
                              value: "Transporter",
                              child: Text("Transporter"),
                            ),
                          ],

                          onChanged: (value) {
                            if (value != null) {
                              controller.changeRole(value);
                            }
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 42.h),

                    /// BUTTON
                    GestureDetector(
                      onTap: controller.onSubmit,

                      child: Container(
                        width: 250.w,
                        height: 58.h,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),

                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,

                            colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                          ),
                        ),

                        child: Center(
                          child: Text(
                            "Submit",

                            style: CustomTextTheme.bold(
                              color: Colors.white,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// LOGIN
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

                    hGap(100.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
