import 'package:get/get.dart';

import '../../controllers/home/notification_controller.dart';

class NotificationBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut(
          () => NotificationController(),
    );
  }
}