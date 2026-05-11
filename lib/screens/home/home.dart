import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/home/home_controller.dart';
import '../../resources/mColours.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/home_drawer.dart';
import '../../widgets/vehicle_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      onPopInvoked: (didPop) async {
        if (didPop) return;

        final shouldExit = await controller.onWillPop();

        if (shouldExit) {
          Get.back();
        }
      },
      child: Scaffold(
        drawer: const HomeDrawer(),
        extendBodyBehindAppBar: true,
        backgroundColor: MColors.white,
        appBar: PreferredSize(

          preferredSize:
          Size.fromHeight(
            kToolbarHeight,
          ),

          child: Builder(

            builder: (context) {

              return CustomAppBar(

                title: null,

                backgroundColor:
                const Color(0xFF2F66F6),

                iconColor:
                MColors.white,

                showBack: false,

                showNotification: true,

                showDrawer: true,

                hasNotification: false,

                onNotification: () {

                  Get.toNamed(
                    AppRoutes.notificationPage,
                  );
                },

                onDrawer: () {

                  Scaffold.of(context)
                      .openDrawer();
                },
              );
            },
          ),
        ),

        body: SafeArea(
          child: Column(
            children: [
              /// TOP SECTION
              Stack(
                clipBehavior: Clip.none,
          
                children: [
                  /// BLUE BG
                  Container(
                    width: double.infinity,
                    height: 200.h,

                    decoration: BoxDecoration(
                      color: const Color(0xFF2F66F6),

                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14.r),
                        bottomRight: Radius.circular(14.r),
                      ),
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 26.w, top: 5.h),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Hi Owner,",

                            style: CustomTextTheme.extraBold(
                              color: Colors.white,
                              fontSize: 34.sp,
                            ),
                          ),

                          Text(
                            "Check your booking",

                            style: CustomTextTheme.medium(
                              color: Colors.white70,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          
                  /// OVERLAP CARD
                  Positioned(
                    left: 22.w,
                    right: 22.w,
                    bottom: -90.h,
          
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18.h),
          
                      decoration: BoxDecoration(
                        color: Colors.white,
          
                        borderRadius: BorderRadius.circular(20.r),
          
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
          
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
          
                      child: Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${controller.activeLanes.value}",
          
                                    style: TextStyle(
                                      color: const Color(0xFF7ED957),
          
                                      fontSize: 80.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
          
                                  SizedBox(height: 8.h),
          
                                  Text(
                                    "Active lanes",
          
                                    style: CustomTextTheme.bold(
                                      fontSize: 17.sp,
                                      color: const Color(0xFF2F66F6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
          
                            Container(
                              width: 1.2.w,
                              height: 120.h,
                              color: Colors.black12,
                            ),
          
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${controller.loadRequests.value}",
          
                                    style: TextStyle(
                                      color: const Color(0xFF2F66F6),
          
                                      fontSize: 80.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
          
                                  SizedBox(height: 8.h),
          
                                  Text(
                                    "Load request",
          
                                    style: CustomTextTheme.bold(
                                      fontSize: 17.sp,
                                      color: const Color(0xFF7ED957),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 105.h),
          
              /// HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
          
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                  children: [
                    Text(
                      "Your Vehicles",
          
                      style: CustomTextTheme.bold(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                    ),
          
                    Text(
                      "Add More",
          
                      style: CustomTextTheme.medium(
                        fontSize: 13.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
          
              SizedBox(height: 14.h),
          
              /// ONLY THIS PART SCROLL
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
          
                  child: Obx(
                        () {

                      /// EMPTY STATE
                      if (controller.vehicles.isEmpty) {

                        return Center(

                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 26.w,
                            ),

                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,

                              children: [

                                /// ICON CONTAINER
                                Container(
                                  width: 120.w,
                                  height: 120.w,

                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,

                                    color:
                                    const Color(0xFFEEF3FF),
                                  ),

                                  child: Center(
                                    child: Icon(
                                      Icons.local_shipping_outlined,

                                      size: 58.sp,

                                      color:
                                      const Color(0xFF2F66F6),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 26.h),

                                /// TITLE
                                Text(
                                  "No Vehicles Added Yet",

                                  textAlign: TextAlign.center,

                                  style:
                                  CustomTextTheme.bold(
                                    color: Colors.black,

                                    fontSize: 22.sp,
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                /// DESC
                                Text(
                                  "Add your trucks and manage all transport activities from one place.",

                                  textAlign: TextAlign.center,

                                  style:
                                  CustomTextTheme.medium(
                                    color: Colors.black54,

                                    fontSize: 14.sp,
                                  ),
                                ),

                                SizedBox(height: 28.h),

                                /// BUTTON
                                GestureDetector(
                                  onTap: () {},

                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 26.w,
                                      vertical: 14.h,
                                    ),

                                    decoration: BoxDecoration(

                                      borderRadius:
                                      BorderRadius.circular(
                                          14.r),

                                      gradient:
                                      const LinearGradient(
                                        colors: [
                                          Color(0xFF2F66F6),
                                          Color(0xFF001A9F),
                                        ],
                                      ),

                                      boxShadow: [

                                        BoxShadow(
                                          color:
                                          const Color(0xFF2F66F6)
                                              .withOpacity(0.25),

                                          blurRadius: 16,

                                          offset:
                                          const Offset(0, 8),
                                        ),
                                      ],
                                    ),

                                    child: Row(
                                      mainAxisSize:
                                      MainAxisSize.min,

                                      children: [

                                        Icon(
                                          Icons.add_rounded,

                                          color: Colors.white,

                                          size: 20.sp,
                                        ),

                                        SizedBox(width: 8.w),

                                        Text(
                                          "Add Vehicle",

                                          style:
                                          CustomTextTheme.bold(
                                            color: Colors.white,

                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      /// VEHICLE LIST
                      return ListView.builder(

                        padding:
                        EdgeInsets.only(bottom: 20.h),

                        itemCount:
                        controller.vehicles.length,

                        itemBuilder: (context, index) {

                          final Map<String, dynamic>
                          vehicle =
                          controller.vehicles[index];

                          return VehicleCard(

                            image:
                            vehicle["image"] ?? "",

                            truckName:
                            vehicle["truckName"] ?? "",

                            truckNumber:
                            vehicle["truckNumber"] ?? "",

                            tyre:
                            vehicle["tyre"] ?? "",

                            power:
                            vehicle["power"] ?? "",

                            mileage:
                            vehicle["mileage"] ?? "",

                            weight:
                            vehicle["weight"] ?? "",

                            onTap: () {

                              Get.toNamed(
                                AppRoutes.vehicleDetailsPage,

                                arguments: vehicle,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
