import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/custome_loader.dart';
import '../../helpers/toaster.dart';
import '../../model/register_send_otp_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../routes/app_routes.dart';

class RegisterController extends GetxController {
  /// TEXT CONTROLLERS
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  RxBool isLoading = false.obs;

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

    /// NAME

    if (name.isEmpty) {
      AppToast.short("Please enter your name");

      return;
    }

    /// PHONE

    if (phone.isEmpty || phone.length != 10) {
      AppToast.short("Please enter valid phone number");

      return;
    }

    try {
      isLoading.value = true;

      Loader.show();

      /// USER TYPE

      final userType = role == "Transporter" ? "TRANSPORTER" : "VEHICLE_OWNER";

      await DioHelper.builder()
          .setMethod("POST")
          .setUrl(ApiEndpoints.registerSendOtp)
          .setData({"name": name, "phone": phone, "userType": userType})
          .execute<RegisterSendOtpModel>(
            fromJson: (json) => RegisterSendOtpModel.fromJson(json),

            onSuccess: (response) {
              AppToast.short(response.msg);

              final otp = response.payload?.otp.toString() ?? "";

              /// HIDE LOADER

              Loader.hide();

              /// GO OTP PAGE

              Get.toNamed(
                AppRoutes.otpPage,

                arguments: {
                  "type": "register",

                  "name": name,

                  "phone": phone,

                  "userType": userType,

                  "otp": otp,
                },
              );
            },

            onFailure: (message, {code}) {
              AppToast.short(message);
            },
          );
    } catch (e) {
      AppToast.short("Something went wrong");
    } finally {
      isLoading.value = false;

      Loader.hide();
    }
  }

  /// LOGIN
  void onLogin() async {
    try {
      /// GO LOGIN PAGE
      Get.toNamed(AppRoutes.loginPage);
    } catch (e) {
      AppToast.short("Something went wrong");

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
