import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../helpers/toaster.dart';
import '../../model/route_list_model.dart';
import '../../model/vehicle_list_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../routes/app_routes.dart';
import 'home_controller.dart';

class VehicleDetailsController extends GetxController {

  late final VehicleData vehicle;

  final RxList<String> activeLanes = <String>[].obs;

  RxBool isRouteLoading = false.obs;
  RxBool isDeleteLoading = false.obs;

  @override
  void onInit() {
    vehicle = Get.arguments as VehicleData;

    getRouteList();

    super.onInit();
  }

  /// =========================
  /// GET ROUTE LIST
  /// =========================

  Future<void> getRouteList() async {
    try {
      isRouteLoading.value = true;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getRouteList)
          .execute<RouteListModel>(
            fromJson: (json) => RouteListModel.fromJson(json),

            onSuccess: (response) {
              activeLanes.clear();

              final routes = response.payload?.vehicleRouteList?.data ?? [];

              for (final route in routes) {
                /// SAME ROUTE ID

                if (route.routeId == vehicle.routeId) {
                  final fromCity = route.fromCity?.trim() ?? "";

                  final toCity = route.toCity?.trim() ?? "";

                  /// NULL SAFETY

                  if (fromCity.isNotEmpty &&
                      toCity.isNotEmpty &&
                      fromCity != "NA" &&
                      toCity != "NA") {
                    activeLanes.add("$fromCity - $toCity");
                  }
                }
              }

              /// FALLBACK

              if (activeLanes.isEmpty) {
                final fromCity = vehicle.fromCity?.trim() ?? "";

                final toCity = vehicle.toCity?.trim() ?? "";

                if (fromCity.isNotEmpty &&
                    toCity.isNotEmpty &&
                    fromCity != "NA" &&
                    toCity != "NA") {
                  activeLanes.add("$fromCity - $toCity");
                }
              }
            },

            onFailure: (message, {code}) {
              activeLanes.clear();
            },
          );
    } catch (e) {
      activeLanes.clear();
    } finally {
      isRouteLoading.value = false;
    }
  }

  /// =========================
  /// DELETE VEHICLE DIALOG
  /// =========================

  Future<void> showDeleteDialog() async {
    await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),

        contentPadding: EdgeInsets.all(22.w),

        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            /// ICON
            Container(
              width: 70.w,
              height: 70.w,

              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F1),

                shape: BoxShape.circle,
              ),

              child: Center(
                child: Icon(
                  Icons.delete_outline_rounded,

                  color: const Color(0xFFE53935),

                  size: 38.sp,
                ),
              ),
            ),

            SizedBox(height: 18.h),

            /// TITLE
            Text(
              "Delete Vehicle?",

              style: TextStyle(
                color: Colors.black,

                fontSize: 20.sp,

                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 10.h),

            /// DESC
            Text(
              "Are you sure you want to delete this vehicle permanently?",

              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.black54,

                fontSize: 14.sp,

                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 26.h),

            /// BUTTONS
            Row(
              children: [
                /// CANCEL
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },

                    child: Container(
                      height: 52.h,

                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,

                        borderRadius: BorderRadius.circular(16.r),
                      ),

                      child: Center(
                        child: Text(
                          "Cancel",

                          style: TextStyle(
                            color: Colors.black87,

                            fontSize: 15.sp,

                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 14.w),

                /// DELETE
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();

                      deleteVehicle();
                    },

                    child: Container(
                      height: 52.h,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),

                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF5C5C), Color(0xFFE53935)],
                        ),
                      ),

                      child: Center(
                        child: Text(
                          "Delete",

                          style: TextStyle(
                            color: Colors.white,

                            fontSize: 15.sp,

                            fontWeight: FontWeight.w700,
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
    );
  }

  /// =========================
  /// DELETE VEHICLE
  /// =========================

  Future<void> deleteVehicle() async {
    try {
      isDeleteLoading.value = true;

      Get.dialog(
        const Center(child: CircularProgressIndicator()),

        barrierDismissible: false,
      );

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.deleteVehicle(vehicle.vehicleId ?? 0))
          .execute<dynamic>(
            onSuccess: (response) async {
              /// CLOSE LOADER

              if (Get.isDialogOpen ?? false) {
                Get.back();
              }

              /// HOME CONTROLLER UPDATE

              if (Get.isRegistered<HomeController>()) {
                final homeController = Get.find<HomeController>();

                await homeController.getVehicleList();
              }

              /// GO HOME

              Get.offAllNamed(AppRoutes.homePage);

              AppToast.short("Vehicle deleted successfully");
            },

            onFailure: (message, {code}) {
              /// CLOSE LOADER

              if (Get.isDialogOpen ?? false) {
                Get.back();
              }

              AppToast.short(message);
            },
          );
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      AppToast.short("Something went wrong");
    } finally {
      isDeleteLoading.value = false;
    }
  }
}
