import 'package:get/get.dart';

import '../../controllers/drawer/kyc_controller.dart';

class KycBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<KycController>(
          () => KycController(),
    );
  }
}