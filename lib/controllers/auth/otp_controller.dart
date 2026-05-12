import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/custome_loader.dart';
import '../../helpers/toaster.dart';
import '../../model/login_model.dart';
import '../../model/register_model.dart';
import '../../model/user_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../prefs/prefs.dart';
import '../../routes/app_routes.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();

  late String type;

  late String otpCode;

  late String name;

  late String userType;

  /// LOADING

  RxBool isLoading = false.obs;

  /// TIMER

  RxInt seconds = 30.obs;

  Timer? _timer;

  /// PHONE

  late String phone;

  @override
  void onInit() {
    super.onInit();

    phone = Get.arguments?["phone"] ?? "";

    otpCode = Get.arguments?["otp"] ?? "";

    type = Get.arguments?["type"] ?? "";

    name = Get.arguments?["name"] ?? "";

    userType = Get.arguments?["userType"] ?? "";

    startTimer();
  }

  /// START TIMER

  void startTimer() {
    seconds.value = 30;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  /// RESEND OTP

  void resendOtp() {
    startTimer();

    AppToast.short("OTP resent successfully");
  }

  /// VERIFY OTP

  Future<void> verifyOtp() async {
    final enteredOtp = otpController.text.trim();

    /// EMPTY CHECK

    if (enteredOtp.isEmpty) {
      AppToast.short("Please enter OTP");

      return;
    }

    /// LENGTH CHECK

    if (enteredOtp.length != 4) {
      AppToast.short("Please enter valid OTP");

      return;
    }

    /// OTP MATCH CHECK

    if (enteredOtp != otpCode) {
      /// CLEAR OTP FIELD

      otpController.clear();

      AppToast.short("Invalid OTP");

      return;
    }

    try {
      isLoading.value = true;

      Loader.show();

      /// =========================
      /// REGISTER FLOW
      /// =========================

      if (type == "register") {
        await DioHelper.builder()
            .setMethod("POST")
            .setUrl(ApiEndpoints.register)
            .setData({"name": name, "phone": phone, "userType": userType})
            .execute<RegisterModel>(
              fromJson: (json) => RegisterModel.fromJson(json),

              onSuccess: (response) {
                /// TOKEN

                final token = response.payload?.token ?? "";

                /// TOKEN SAVE

                if (token.isNotEmpty) {
                  Prefs.setToken(token);
                }

                /// ✅ SAVE USER DATA
                final registerUser = response.payload?.user;
                if (registerUser != null) {
                  final userModel = UserModel(
                    userId: registerUser.userId,
                    name: registerUser.name.isNotEmpty
                        ? registerUser.name
                        : null,
                    phone: registerUser.phone.isNotEmpty
                        ? registerUser.phone
                        : null,
                    userType: registerUser.userType.isNotEmpty
                        ? registerUser.userType
                        : null,
                    profilePic: registerUser.profilePic?.isNotEmpty == true
                        ? registerUser.profilePic
                        : null,
                  );
                  Prefs.setUserData(userModel);
                }

                /// LOGIN STATE

                Prefs.setIsLogin(true);

                AppToast.short(response.msg);

                /// HIDE LOADER

                Loader.hide();

                /// GO HOME

                Get.offAllNamed(AppRoutes.homePage);
              },

              onFailure: (message, {code}) {
                AppToast.short(message);
              },
            );
      }
      /// =========================
      /// LOGIN FLOW
      /// =========================
      else if (type == "login") {
        await DioHelper.builder()
            .setMethod("POST")
            .setUrl(ApiEndpoints.login)
            .setData({"phone": phone})
            .execute<LoginModel>(
              fromJson: (json) => LoginModel.fromJson(json),

              onSuccess: (response) {
                /// TOKEN

                final token = response.payload?.token ?? "";

                /// SAVE TOKEN

                if (token.isNotEmpty) {
                  Prefs.setToken(token);
                }

                /// ✅ SAVE USER DATA
                final loginUser = response.payload?.user;
                if (loginUser != null) {
                  final userModel = UserModel(
                    userId: loginUser.userId,
                    name: loginUser.name.isNotEmpty ? loginUser.name : null,
                    phone: loginUser.phone.isNotEmpty ? loginUser.phone : null,
                    userType: loginUser.userType.isNotEmpty
                        ? loginUser.userType
                        : null,
                    profilePic: loginUser.profilePic?.isNotEmpty == true
                        ? loginUser.profilePic
                        : null,
                  );
                  Prefs.setUserData(userModel);
                }

                /// LOGIN STATE

                Prefs.setIsLogin(true);

                AppToast.short(response.msg);

                /// HIDE LOADER

                Loader.hide();

                /// GO HOME

                Get.offAllNamed(AppRoutes.homePage);
              },

              onFailure: (message, {code}) {
                AppToast.short(message);
              },
            );
      }
    } catch (e) {
      AppToast.short("OTP Verification Failed");

      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();

    _timer?.cancel();

    super.onClose();
  }
}
