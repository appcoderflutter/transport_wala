import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/toaster.dart';
import '../../model/notification_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';

class NotificationController extends GetxController {
  /// =========================
  /// LOADING
  /// =========================

  RxBool isLoading = false.obs;

  /// PAGINATION LOADING

  RxBool isPaginationLoading = false.obs;

  /// HAS MORE DATA

  bool hasMoreData = true;

  /// CURRENT PAGE

  int currentPage = 1;

  /// SCROLL CONTROLLER

  final ScrollController scrollController = ScrollController();

  /// =========================
  /// NOTIFICATION LIST
  /// =========================

  RxList<NotificationItem> notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();

    getNotifications();

    /// PAGINATION

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isPaginationLoading.value &&
          hasMoreData) {
        loadMoreNotifications();
      }
    });
  }

  /// =========================
  /// GET NOTIFICATIONS
  /// =========================

  Future<void> getNotifications() async {
    try {
      currentPage = 1;

      hasMoreData = true;

      isLoading.value = true;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getNotificationList(currentPage))
          .execute<NotificationModel>(
            fromJson: (json) => NotificationModel.fromJson(json),

            onSuccess: (response) {
              notifications.value =
                  response.payload?.notificationList?.data ?? [];

              final total = response.payload?.notificationList?.total ?? 0;

              hasMoreData = notifications.length < total;
            },

            onFailure: (message, {code}) {
              notifications.clear();

              AppToast.short(message);
            },
          );
    } catch (e) {
      notifications.clear();

      AppToast.short("Failed to load notifications");
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================
  /// LOAD MORE
  /// =========================

  Future<void> loadMoreNotifications() async {
    try {
      isPaginationLoading.value = true;

      currentPage++;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getNotificationList(currentPage))
          .execute<NotificationModel>(
            fromJson: (json) => NotificationModel.fromJson(json),

            onSuccess: (response) {
              final newNotifications =
                  response.payload?.notificationList?.data ?? [];

              final total = response.payload?.notificationList?.total ?? 0;

              if (newNotifications.isEmpty) {
                hasMoreData = false;
              } else {
                notifications.addAll(newNotifications);

                hasMoreData = notifications.length < total;
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

  @override
  void onClose() {
    scrollController.dispose();

    super.onClose();
  }
}
