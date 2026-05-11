import 'package:get/get.dart';

class VehicleDetailsController extends GetxController {

  /// VEHICLE DATA
  late final Map<String, dynamic> vehicle;

  /// DUMMY ACTIVE LANES
  final activeLanes = [

    "Kolkata - Siliguri",

    "Kolkata - Durgapur",

    "Kolkata - Asansol",

    "Kolkata - Delhi",

    "Kolkata - Patna",

  ].obs;

  @override
  void onInit() {

    vehicle =
        Get.arguments ??
            {};

    super.onInit();
  }
}