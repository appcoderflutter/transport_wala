import 'package:get/get.dart';

import '../../helpers/toaster.dart';
import '../../model/notification_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';

class NotificationController extends GetxController {

  /// LOADING
  RxBool isLoading = false.obs;

  /// NOTIFICATION LIST
  RxList<NotificationItem> notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();

    getNotifications();
  }

  /// =========================
  /// GET NOTIFICATIONS
  /// =========================

  Future<void> getNotifications() async {
    try {
      isLoading.value = true;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getNotificationList)
          .execute<NotificationModel>(
            fromJson: (json) => NotificationModel.fromJson(json),

            onSuccess: (response) {
              notifications.value =
                  response.payload?.notificationList?.data ?? [];
            },

            onFailure: (message, {code}) {
              AppToast.short(message);
            },
          );
    } catch (e) {
      AppToast.short("Failed to load notifications");
    } finally {
      isLoading.value = false;
    }
  }
}
