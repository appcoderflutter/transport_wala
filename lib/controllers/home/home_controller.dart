import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/notification_count_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../utility/utility.dart';

class HomeController extends GetxController {
  /// =========================
  /// USER DATA
  /// =========================

  final ownerName = "Owner".obs;

  final activeLanes = 15.obs;

  final loadRequests = 14.obs;

  /// NOTIFICATION COUNT

  RxInt notificationCount = 0.obs;

  /// =========================
  /// VEHICLE LIST
  /// API READY
  /// =========================

  final RxList<Map<String, dynamic>> vehicles = <Map<String, dynamic>>[
    {
      "image": "assets/images/card_truck.png",

      "truckName": "Mahindra Blazo X 35 LIFT AXLE",

      "truckNumber": "KA-07-8742",

      "tyre": "12",

      "power": "276 hp",

      "mileage": "4.5 kmpl",

      "weight": "35000 kg",

      "status": "Active",

      "vehicleType": "Big Truck",

      "fuel": "Petrol",
    },

    {
      "image": "",

      "truckName": "",

      "truckNumber": "",

      "tyre": "",

      "power": "",

      "mileage": "",

      "weight": "",

      "status": "",

      "vehicleType": "",

      "fuel": "",
    },
    {
      "image": "assets/images/card_truck.png",

      "truckName": "Tata Signa 5530.S",

      "truckNumber": "WB-24-4587",

      "tyre": "14",

      "power": "300 hp",

      "mileage": "5.2 kmpl",

      "weight": "42000 kg",

      "status": "Active",

      "vehicleType": "Truck",

      "fuel": "Diesel",
    },
    {
      "image": "assets/images/card_truck.png",

      "truckName": "Mahindra Blazo X 35 LIFT AXLE",

      "truckNumber": "KA-07-8742",

      "tyre": "12",

      "power": "276 hp",

      "mileage": "4.5 kmpl",

      "weight": "35000 kg",

      "status": "Inactive",

      "vehicleType": "Truck",

      "fuel": "Petrol",
    },

    {
      "image": "assets/images/card_truck.png",

      "truckName": "Tata Signa 5530.S",

      "truckNumber": "WB-24-4587",

      "tyre": "14",

      "power": "300 hp",

      "mileage": "5.2 kmpl",

      "weight": "42000 kg",

      "status": "Active",

      "vehicleType": "Truck",

      "fuel": "Diesel",
    },
    {
      "image": "assets/images/card_truck.png",

      "truckName": "Mahindra Blazo X 35 LIFT AXLE",

      "truckNumber": "KA-07-8742",

      "tyre": "12",

      "power": "276 hp",

      "mileage": "4.5 kmpl",

      "weight": "35000 kg",

      "status": "Active",

      "vehicleType": "Truck",

      "fuel": "Diesel",
    },

    {
      "image": "assets/images/card_truck.png",

      "truckName": "Tata Signa 5530.S",

      "truckNumber": "WB-24-4587",

      "tyre": "14",

      "power": "300 hp",

      "mileage": "5.2 kmpl",

      "weight": "42000 kg",

      "status": "Active",

      "vehicleType": "Truck",

      "fuel": "Diesel",
    },
  ].obs;

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

  Future<void>
  getNotificationCount() async {

    try {

      await DioHelper.builder()

          .setMethod("GET")

          .setUrl(
          ApiEndpoints
              .getNotificationCount)

          .execute<NotificationCountModel>(

        fromJson: (json) =>

            NotificationCountModel
                .fromJson(json),

        onSuccess: (response) {

          notificationCount.value =

              response
                  .payload
                  ?.count ?? 0;
        },

        onFailure:
            (message, {code}) {

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
  }
}
