import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVehicleController
    extends GetxController {

  /// =========================
  /// TEXT CONTROLLERS
  /// =========================

  final modelController =
  TextEditingController();

  final registrationController =
  TextEditingController();

  final capacityController =
  TextEditingController();

  final mileageController =
  TextEditingController();

  @override
  void onClose() {

    modelController.dispose();

    registrationController.dispose();

    capacityController.dispose();

    mileageController.dispose();

    super.onClose();
  }
}