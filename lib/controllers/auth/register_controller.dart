import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/custome_loader.dart';
import '../../helpers/toaster.dart';
import '../../routes/app_routes.dart';

class RegisterController extends GetxController {

  /// TEXT CONTROLLERS
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  /// DROPDOWN
  final selectedRole = "Vehicle Owner".obs;

  /// CHANGE ROLE
  void changeRole(String value) {
    selectedRole.value = value;
  }

  /// SUBMIT
  void onSubmit() async {

    final name = nameController.text.trim();

    final phone = phoneController.text.trim();

    final role = selectedRole.value;

    /// NAME VALIDATION
    if (name.isEmpty) {

      AppToast.short(
        "Please enter your name",
      );

      return;
    }

    /// PHONE VALIDATION
    if (phone.isEmpty || phone.length < 10) {

      AppToast.short(
        "Please enter valid phone number",
      );

      return;
    }

    try {;

      debugPrint("Name : $name");

      debugPrint("Phone : $phone");

      debugPrint("Role : $role");

      /// SUCCESS TOAST
      AppToast.short(
        "Registration Successful",
      );

      /// GO TO HOME PAGE
      Get.offAllNamed(
        AppRoutes.homePage,
      );

    } catch (e) {

      AppToast.short(
        "Something went wrong",
      );

      debugPrint(e.toString());
    }
  }

  /// LOGIN
  void onLogin() async {

    try {

      await Future.delayed(
        const Duration(seconds: 2),
      );

      /// GO LOGIN PAGE
      /// Get.toNamed(AppRoutes.loginPage);

    } catch (e) {

      AppToast.short(
        "Something went wrong",
      );

      debugPrint(e.toString());
    }
  }

  @override
  void onClose() {

    nameController.dispose();

    phoneController.dispose();

    super.onClose();
  }
}