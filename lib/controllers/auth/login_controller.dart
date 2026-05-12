import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/custome_loader.dart';
import '../../helpers/toaster.dart';
import '../../model/login_send_otp_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  /// PHONE CONTROLLER

  final phoneController = TextEditingController();

  /// LOADING

  RxBool isLoading = false.obs;

  /// LOGIN

  Future<void> onLogin() async {
    final phone = phoneController.text.trim();

    /// EMPTY CHECK

    if (phone.isEmpty) {
      AppToast.short("Please enter phone number");

      return;
    }

    /// VALIDATION

    if (phone.length != 10) {
      AppToast.short("Please enter valid phone number");

      return;
    }

    try {
      isLoading.value = true;

      Loader.show();

      await DioHelper.builder()
          .setMethod("POST")
          .setUrl(ApiEndpoints.loginSendOTP)
          .setData({"phone": phone})
          .execute<LoginSendOtpModel>(
            fromJson: (json) => LoginSendOtpModel.fromJson(json),

            onSuccess: (response) {
              AppToast.short(response.msg);

              final otp = response.payload?.otp.toString() ?? "";

              /// HIDE LOADER

              Loader.hide();

              /// OTP PAGE

              Get.toNamed(
                AppRoutes.otpPage,

                arguments: {"type": "login", "phone": phone, "otp": otp},
              );
            },

            onFailure: (message, {code}) {
              AppToast.short(message);
            },
          );
    } catch (e) {
      AppToast.short("Something went wrong");

      debugPrint(e.toString());
    } finally {
      isLoading.value = false;

      Loader.hide();
    }
  }

  /// SIGN UP

  void goToRegister() {
    Get.toNamed(AppRoutes.registerPage);
  }

  @override
  void onClose() {
    phoneController.dispose();

    super.onClose();
  }
}
