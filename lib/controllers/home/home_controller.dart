import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/notification_count_model.dart';
import '../../model/route_list_model.dart';
import '../../model/vehicle_list_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../utility/utility.dart';

class HomeController extends GetxController {
  /// =========================
  /// USER DATA
  /// =========================

  final ownerName = "Owner".obs;

  RxInt activeLanes = 0.obs;

  RxInt loadRequests = 0.obs;

  /// NOTIFICATION COUNT

  RxInt notificationCount = 0.obs;

  RxBool isVehicleLoading = false.obs;

  /// PAGINATION

  RxBool isPaginationLoading = false.obs;

  bool hasMoreData = true;

  int currentPage = 1;

  /// SCROLL CONTROLLER

  final ScrollController scrollController = ScrollController();

  /// =========================
  /// VEHICLE LIST
  /// API READY
  /// =========================

  final RxList<VehicleData> vehicles = <VehicleData>[].obs;

  /// =========================
  /// GET VEHICLE LIST
  /// =========================

  Future<void> getVehicleList() async {
    try {
      currentPage = 1;

      hasMoreData = true;

      isVehicleLoading.value = true;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getVehicleList(currentPage))
          .execute<VehicleListModel>(
            fromJson: (json) => VehicleListModel.fromJson(json),

            onSuccess: (response) {
              vehicles.value = response.payload?.vehicleList?.data ?? [];

              /// TOTAL COUNT

              loadRequests.value = response.payload?.vehicleList?.total ?? 0;

              /// HAS MORE

              hasMoreData = vehicles.length < loadRequests.value;
            },

            onFailure: (message, {code}) {
              vehicles.clear();

              loadRequests.value = 0;
            },
          );
    } catch (e) {
      vehicles.clear();

      loadRequests.value = 0;
    } finally {
      isVehicleLoading.value = false;
    }
  }

  /// =========================
  /// LOAD MORE VEHICLES
  /// =========================

  Future<void> loadMoreVehicles() async {
    try {
      isPaginationLoading.value = true;

      currentPage++;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getVehicleList(currentPage))
          .execute<VehicleListModel>(
            fromJson: (json) => VehicleListModel.fromJson(json),

            onSuccess: (response) {
              final newVehicles = response.payload?.vehicleList?.data ?? [];

              if (newVehicles.isEmpty) {
                hasMoreData = false;
              } else {
                vehicles.addAll(newVehicles);

                hasMoreData = vehicles.length < loadRequests.value;
              }
            },

            onFailure: (message, {code}) {
              currentPage--;
            },
          );
    } catch (e) {
      currentPage--;
    } finally {
      isPaginationLoading.value = false;
    }
  }

  /// =========================
  /// GET ROUTE LIST
  /// =========================

  Future<void> getRouteList() async {
    try {
      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getRouteList)
          .execute<RouteListModel>(
            fromJson: (json) => RouteListModel.fromJson(json),

            onSuccess: (response) {
              /// ACTIVE LANES COUNT

              activeLanes.value =
                  response.payload?.vehicleRouteList?.total ?? 0;
            },

            onFailure: (message, {code}) {
              activeLanes.value = 0;
            },
          );
    } catch (e) {
      activeLanes.value = 0;
    }
  }

  /// =========================
  /// EXIT DIALOG
  /// =========================

  Future<bool> onWillPop() async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),

        titlePadding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 0),

        contentPadding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 0),

        actionsPadding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 18.h),

        /// TITLE
        title: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEEF3FF),
              ),

              child: Icon(
                Icons.logout_rounded,
                color: const Color(0xFF2F66F6),
                size: 22.sp,
              ),
            ),

            wGap(12.w),

            Text(
              "Exit App",

              style: CustomTextTheme.bold(color: Colors.black, fontSize: 20.sp),
            ),
          ],
        ),

        /// CONTENT
        content: Text(
          "Are you sure you want to exit the app?",

          style: CustomTextTheme.medium(color: Colors.black54, fontSize: 14.sp),
        ),

        /// ACTIONS
        actions: [
          /// CANCEL
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },

            child: Text(
              "Cancel",

              style: CustomTextTheme.semiBold(
                color: Colors.black54,
                fontSize: 14.sp,
              ),
            ),
          ),

          /// EXIT
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,

              backgroundColor: const Color(0xFF2F66F6),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),

            onPressed: () {
              Get.back(result: true);

              SystemNavigator.pop();
            },

            child: Text(
              "Exit",

              style: CustomTextTheme.bold(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// =========================
  /// GET NOTIFICATION COUNT
  /// =========================

  Future<void> getNotificationCount() async {
    try {
      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getNotificationCount)
          .execute<NotificationCountModel>(
            fromJson: (json) => NotificationCountModel.fromJson(json),

            onSuccess: (response) {
              notificationCount.value = response.payload?.count ?? 0;
            },

            onFailure: (message, {code}) {
              notificationCount.value = 0;
            },
          );
    } catch (e) {
      notificationCount.value = 0;
    }
  }

  @override
  void onInit() {
    super.onInit();

    getNotificationCount();

    getVehicleList();

    getRouteList();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isPaginationLoading.value &&
          hasMoreData) {
        loadMoreVehicles();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();

    super.onClose();
  }
}
