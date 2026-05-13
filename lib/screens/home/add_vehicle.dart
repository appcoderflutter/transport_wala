import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:transport_wala/utility/utility.dart';

import '../../controllers/home/add_vehicle_controller.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/custom_appbar.dart';

class AddVehiclePage extends GetView<AddVehicleController> {
  const AddVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const CustomAppBar(
        title: "Add Vehicle",

        showBack: true,

        backgroundColor: Colors.white,

        iconColor: Color(0xFF2F66F6),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),

          child: Column(
            children: [
              /// =========================
              /// IMAGE CONTAINER
              /// =========================
              Container(
                width: 220.w,
                height: 200.h,

                padding: EdgeInsets.symmetric(vertical: 12.h),

                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),

                  borderRadius: BorderRadius.circular(22.r),

                  border: Border.all(
                    color: const Color(0xFFE5E7EB),

                    width: 1.5,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),

                      blurRadius: 14,

                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                      width: 86.w,

                      height: 86.w,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: Colors.white,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),

                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: Icon(
                        Icons.add_photo_alternate_rounded,

                        size: 46.sp,

                        color: const Color(0xFF2F66F6),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      "Upload Vehicle Image",

                      style: CustomTextTheme.bold(
                        fontSize: 15.sp,

                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      "PNG, JPG or JPEG",

                      style: CustomTextTheme.medium(
                        fontSize: 12.sp,

                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 56.h),

              /// MODEL NUMBER
              AuthTextField(
                hint: "Enter Model Number",

                controller: controller.modelController,
              ),

              SizedBox(height: 16.h),

              /// REGISTRATION NUMBER
              AuthTextField(
                hint: "Enter Vehicle Registration Number",

                controller: controller.registrationController,
              ),

              SizedBox(height: 16.h),

              /// CAPACITY
              AuthTextField(
                hint: "Enter Capacity",

                controller: controller.capacityController,

                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 16.h),

              /// MILEAGE
              AuthTextField(
                hint: "Enter Mileage (KMPL)",

                controller: controller.mileageController,

                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 50.h),

              /// BUTTON
              GestureDetector(
                onTap: () {
                  Get.back();
                },

                child: Container(
                  width: 250.w,
                  height: 58.h,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),

                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,

                      end: Alignment.centerRight,

                      colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2F66F6).withOpacity(0.22),

                        blurRadius: 18,

                        offset: const Offset(0, 8),
                      ),
                    ],
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

              hGap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
