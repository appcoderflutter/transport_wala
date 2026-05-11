import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/home/vehicle_details_controller.dart';
import '../../resources/mColours.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/custom_appbar.dart';

class VehicleDetailsPage extends GetView<VehicleDetailsController> {
  const VehicleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicle = controller.vehicle;

    return Scaffold(
      backgroundColor: MColors.white,

      appBar: CustomAppBar(
        title:
        (vehicle["truckName"] ?? "")
            .toString()
            .trim()
            .isEmpty

            ? "Unknown Truck"

            : vehicle["truckName"],

        backgroundColor: Colors.white,

        iconColor: const Color(0xFF2F66F6),

        showBack: true,

        showDrawer: false,

        showNotification: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),

          child: Column(
            children: [
              /// =====================
              /// TOP CARD
              /// =====================
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,

                  borderRadius: BorderRadius.circular(18.r),
                ),

                child: Row(
                  children: [
                    /// LEFT
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            (vehicle["truckName"] ?? "")
                                .toString()
                                .trim()
                                .isEmpty

                                ? "Unknown Truck"

                                : vehicle["truckName"],

                            style: CustomTextTheme.bold(
                              color: Colors.black,

                              fontSize: 26.sp,
                            ),
                          ),

                          Text(
                            (vehicle["truckNumber"] ?? "")
                                .toString()
                                .trim()
                                .isEmpty

                                ? "Not Available"

                                : vehicle["truckNumber"],

                            style: CustomTextTheme.bold(
                              color: const Color(0xFF2F66F6),

                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 14.w),

                    /// IMAGE
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(14.r),

                      child:
                      (vehicle["image"] ?? "")
                          .toString()
                          .trim()
                          .isEmpty

                          ? Container(
                        width: 130.w,
                        height: 170.w,

                        color: Colors.grey.shade300,

                        child: Center(
                          child: Icon(
                            Icons
                                .image_not_supported_outlined,

                            color:
                            Colors.grey.shade500,

                            size: 38.sp,
                          ),
                        ),
                      )

                          : Image.asset(
                        vehicle["image"],

                        width: 130.w,

                        height: 170.w,

                        fit: BoxFit.cover,

                        errorBuilder:
                            (
                            context,
                            error,
                            stackTrace,
                            ) {

                          return Container(
                            width: 130.w,
                            height: 170.w,

                            color:
                            Colors.grey.shade300,

                            child: Center(
                              child: Icon(
                                Icons
                                    .image_not_supported_outlined,

                                color: Colors
                                    .grey.shade500,

                                size: 38.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// =====================
              /// DETAILS CARD
              /// =====================
              Container(
                padding: EdgeInsets.all(16.w),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(18.r),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),

                      blurRadius: 14,

                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    _detailsRow(
                      "Number of Tyre",
                      vehicle["tyre"],

                      "Power",
                      vehicle["power"],
                    ),

                    _divider(),

                    _detailsRow(
                      "Mileage",
                      vehicle["mileage"],

                      "GVW / GCW",
                      vehicle["weight"],
                    ),

                    _divider(),

                    _detailsRow(
                      "Truck Number",
                      vehicle["truckNumber"],

                      "Status",
                      vehicle["status"],
                    ),

                    _divider(),

                    _detailsRow(
                      "Vehicle Type",
                      vehicle["vehicleType"],

                      "Fuel",
                      vehicle["fuel"],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// =====================
              /// ACTIVE LANES
              /// =====================
              Container(
                width: double.infinity,

                padding: EdgeInsets.all(16.w),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(18.r),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),

                      blurRadius: 14,

                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Active Lanes",

                      style: CustomTextTheme.bold(
                        color: Colors.black,

                        fontSize: 16.sp,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Obx(
                      () => Wrap(
                        spacing: 10.w,

                        runSpacing: 10.h,

                        children: controller.activeLanes.map((lane) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,

                              vertical: 10.h,
                            ),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),

                              border: Border.all(color: Colors.black12),
                            ),

                            child: Text(
                              lane,

                              style: CustomTextTheme.medium(
                                color: Colors.black87,

                                fontSize: 13.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),

      child: Divider(color: Colors.blue.withOpacity(0.2), height: 0),
    );
  }

  Widget _detailsRow(
    String title1,
    String? value1,

    String title2,
    String? value2,
  ) {
    return Row(
      children: [
        Expanded(child: _item(title1, value1)),

        Expanded(child: _item(title2, value2)),
      ],
    );
  }

  Widget _item(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: CustomTextTheme.medium(color: Colors.black45, fontSize: 12.sp),
        ),

        SizedBox(height: 4.h),

        Text(
          (value ?? "")
              .trim()
              .isEmpty
              ? "--"
              : value!,

          style: CustomTextTheme.bold(color: Colors.black, fontSize: 16.sp),
        ),
      ],
    );
  }
}
