import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/custome_loader.dart';
import '../../helpers/toaster.dart';
import '../../model/login_model.dart';
import '../../model/login_send_otp_model.dart';
import '../../model/profile_model.dart';
import '../../model/register_model.dart';
import '../../model/register_send_otp_model.dart';
import '../../model/user_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../prefs/prefs.dart';
import '../../routes/app_routes.dart';

class OtpController extends GetxController {
  /// =========================
  /// OTP CONTROLLER
  /// =========================

  final otpController = TextEditingController();

  /// =========================
  /// TYPE
  /// =========================

  late String type;

  /// =========================
  /// OTP
  /// =========================

  RxString otpCode = "".obs;

  /// =========================
  /// USER DATA
  /// =========================

  late String name;

  late String userType;

  late String phone;

  /// =========================
  /// TIMER
  /// =========================

  RxInt seconds = 30.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    phone = Get.arguments?["phone"] ?? "";

    otpCode.value = Get.arguments?["otp"] ?? "";

    type = Get.arguments?["type"] ?? "";

    name = Get.arguments?["name"] ?? "";

    userType = Get.arguments?["userType"] ?? "";

    startTimer();
  }

  /// =========================
  /// START TIMER
  /// =========================

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

  /// =========================
  /// RESEND OTP
  /// =========================

  Future<void> resendOtp() async {
    try {
      /// FULL SCREEN LOADER

      Loader.show();

      /// REGISTER

      if (type == "register") {
        await DioHelper.builder()
            .setMethod("POST")
            .setUrl(ApiEndpoints.registerSendOtp)
            .setData({"name": name, "phone": phone, "userType": userType})
            .execute<RegisterSendOtpModel>(
              fromJson: (json) => RegisterSendOtpModel.fromJson(json),

              onSuccess: (response) {
                otpCode.value = response.payload?.otp.toString() ?? "";

                startTimer();

                otpController.clear();

                Loader.hide();

                AppToast.short(response.msg);
              },

              onFailure: (message, {code}) {
                Loader.hide();

                AppToast.short(message);
              },
            );
      }
      /// LOGIN
      else if (type == "login") {
        await DioHelper.builder()
            .setMethod("POST")
            .setUrl(ApiEndpoints.loginSendOTP)
            .setData({"phone": phone})
            .execute<LoginSendOtpModel>(
              fromJson: (json) => LoginSendOtpModel.fromJson(json),

              onSuccess: (response) {
                otpCode.value = response.payload?.otp.toString() ?? "";

                startTimer();

                otpController.clear();

                Loader.hide();

                AppToast.short(response.msg);
              },

              onFailure: (message, {code}) {
                Loader.hide();

                AppToast.short(message);
              },
            );
      }
    } catch (e) {
      Loader.hide();

      AppToast.short("Failed to resend OTP");

      debugPrint(e.toString());
    }
  }

  /// =========================
  /// VERIFY OTP
  /// =========================

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

    /// MATCH CHECK

    if (enteredOtp != otpCode.value) {
      otpController.clear();

      AppToast.short("Invalid OTP");

      return;
    }

    try {
      /// FULL SCREEN LOADER

      Loader.show();

      /// REGISTER

      if (type == "register") {
        await DioHelper.builder()
            .setMethod("POST")
            .setUrl(ApiEndpoints.register)
            .setData({"name": name, "phone": phone, "userType": userType})
            .execute<RegisterModel>(
              fromJson: (json) => RegisterModel.fromJson(json),

              onSuccess: (response) async {
                final token = response.payload?.token ?? "";

                if (token.isNotEmpty) {
                  Prefs.setToken(token);
                }

                final registerUser = response.payload?.user;

                if (registerUser != null) {
                  final userModel = UserModel(
                    userId: registerUser.userId,

                    name: registerUser.name.isNotEmpty
                        ? registerUser.name
                        : null,

                    email:
                        registerUser.email?.isNotEmpty == true &&
                            registerUser.email != "NA"
                        ? registerUser.email
                        : null,

                    phone: registerUser.phone.isNotEmpty
                        ? registerUser.phone
                        : null,

                    userType: registerUser.userType.isNotEmpty
                        ? registerUser.userType
                        : null,

                    profilePic:
                        registerUser.profilePic?.isNotEmpty == true &&
                            registerUser.profilePic != "NA"
                        ? registerUser.profilePic
                        : null,
                  );

                  Prefs.setUserData(userModel);
                }

                Prefs.setIsLogin(true);

                await fetchAndSaveProfile();

                Loader.hide();

                AppToast.short(response.msg);

                Get.offAllNamed(AppRoutes.homePage);
              },

              onFailure: (message, {code}) {
                Loader.hide();

                AppToast.short(message);
              },
            );
      }
      /// LOGIN
      else if (type == "login") {
        await DioHelper.builder()
            .setMethod("POST")
            .setUrl(ApiEndpoints.login)
            .setData({"phone": phone})
            .execute<LoginModel>(
              fromJson: (json) => LoginModel.fromJson(json),

              onSuccess: (response) async {
                final token = response.payload?.token ?? "";

                if (token.isNotEmpty) {
                  Prefs.setToken(token);
                }

                final loginUser = response.payload?.user;

                if (loginUser != null) {
                  final userModel = UserModel(
                    userId: loginUser.userId,

                    name: loginUser.name.isNotEmpty ? loginUser.name : null,

                    email:
                        loginUser.email?.isNotEmpty == true &&
                            loginUser.email != "NA"
                        ? loginUser.email
                        : null,

                    phone: loginUser.phone.isNotEmpty ? loginUser.phone : null,

                    userType: loginUser.userType.isNotEmpty
                        ? loginUser.userType
                        : null,

                    profilePic:
                        loginUser.profilePic?.isNotEmpty == true &&
                            loginUser.profilePic != "NA"
                        ? loginUser.profilePic
                        : null,
                  );

                  Prefs.setUserData(userModel);
                }

                Prefs.setIsLogin(true);

                await fetchAndSaveProfile();

                Loader.hide();

                AppToast.short(response.msg);

                Get.offAllNamed(AppRoutes.homePage);
              },

              onFailure: (message, {code}) {
                Loader.hide();

                AppToast.short(message);
              },
            );
      }
    } catch (e) {
      Loader.hide();

      AppToast.short("OTP Verification Failed");

      debugPrint(e.toString());
    }
  }

  /// =========================
  /// FETCH PROFILE
  /// =========================

  Future<void> fetchAndSaveProfile() async {
    try {
      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getProfile)
          .execute<ProfileModel>(
            fromJson: (json) => ProfileModel.fromJson(json),

            onSuccess: (response) {
              final user = response.payload?.user;

              if (user != null) {
                Prefs.setUserData(
                  UserModel(
                    userId: user.userId,

                    uniqueUserId: user.uniqueUserId,

                    userType: user.userType,

                    name: user.name,

                    email: user.email,

                    isEmailVerified: user.isEmailVerified,

                    isdCode: user.isdCode,

                    phone: user.phone,

                    isPhoneVerified: user.isPhoneVerified,

                    profilePic: user.profilePic,

                    userActiveRoutes: user.userActiveRoutes,

                    userActiveVehicles: user.userActiveVehicles,

                    isKycVerified: user.isKycVerified,

                    paymentTerm: user.paymentTerm,

                    avgRating: user.avgRating,

                    kycData: user.kycData,
                  ),
                );
              }
            },

            onFailure: (message, {code}) {},
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onClose() {
    otpController.dispose();

    _timer?.cancel();

    super.onClose();
  }
}
