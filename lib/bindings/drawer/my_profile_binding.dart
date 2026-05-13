import 'package:get/get.dart';

import '../../controllers/drawer/my_profile_controller.dart';

class ProfileBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut(
          () => ProfileController(),
    );
  }
}