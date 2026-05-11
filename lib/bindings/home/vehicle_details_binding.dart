import 'package:get/get.dart';

import '../../controllers/home/vehicle_details_controller.dart';

class VehicleDetailsBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut(
          () => VehicleDetailsController(),
    );
  }
}