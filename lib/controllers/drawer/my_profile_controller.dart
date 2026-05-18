/// =========================
/// PROFILE CONTROLLER
/// =========================

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transport_wala/model/user_model.dart';

import '../../helpers/photoPicker/photo_picker.dart';
import '../../helpers/toaster.dart';
import '../../model/profile_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../prefs/prefs.dart';

class ProfileController extends GetxController {
  /// USER

  final user = Prefs.userRx;

  /// =========================
  /// LOADING
  /// =========================

  RxBool isUploading = false.obs;

  /// =========================
  /// PROFILE IMAGE
  /// =========================

  bool get hasImage {
    return user.value?.profilePic != null &&
        user.value!.profilePic!.isNotEmpty &&
        user.value!.profilePic != "NA";
  }

  bool get isEmailVerified {
    return user.value?.isEmailVerified == "1";
  }

  bool get isPhoneVerified {
    return user.value?.isPhoneVerified == "1";
  }

  /// =========================
  /// NAME
  /// =========================

  String get name {
    return user.value?.name?.isNotEmpty == true
        ? user.value!.name!
        : "Not Available";
  }

  /// =========================
  /// USER TYPE
  /// =========================

  String get userType {
    return user.value?.userType?.isNotEmpty == true
        ? user.value!.userType!
        : "Not Available";
  }

  /// =========================
  /// EMAIL
  /// =========================

  String get email {
    return user.value?.email?.isNotEmpty == true && user.value!.email != "NA"
        ? user.value!.email!
        : "Not Available";
  }

  /// =========================
  /// PHONE
  /// =========================

  String get phone {
    return user.value?.phone?.isNotEmpty == true
        ? user.value!.phone!
        : "Not Available";
  }

  /// =========================
  /// PICK PROFILE IMAGE
  /// =========================

  Future<void> pickProfileImage() async {
    PhotoPicker.show(
      onImageSelected: (file) {
        uploadProfileImage(file);
      },
    );
  }

  /// =========================
  /// UPLOAD PROFILE IMAGE
  /// =========================

  Future<void> uploadProfileImage(File file) async {
    try {
      isUploading.value = true;

      /// FILE BYTES

      final bytes = await file.readAsBytes();

      /// BASE64

      final base64Image = base64Encode(bytes);

      /// MIME

      final extension = file.path.split(".").last.toLowerCase();

      final mimeType = "image/$extension";

      /// FINAL IMAGE

      final imageData = "data:$mimeType;base64,$base64Image";

      /// API CALL

      await DioHelper.builder()
          .setMethod("POST")
          .setUrl(ApiEndpoints.uploadProfilePic)
          .setData({"profilePic": imageData})
          .execute<dynamic>(
            fromJson: (json) => json,

            onSuccess: (response) async {
              /// =========================
              /// INSTANT UI UPDATE
              /// =========================

              final currentUser = Prefs.userRx.value;

              if (currentUser != null) {
                Prefs.setUserData(currentUser.copyWith(profilePic: imageData));
              }

              AppToast.short("Profile picture updated");

              /// REFRESH PROFILE

              await getProfile();
            },

            onFailure: (message, {code}) {
              AppToast.short(message);
            },
          );
    } catch (e) {
      AppToast.short("Failed to upload image");

      debugPrint(e.toString());
    } finally {
      isUploading.value = false;
    }
  }

  /// =========================
  /// GET PROFILE
  /// =========================

  Future<void> getProfile() async {
    try {
      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getProfile)
          .execute<ProfileModel>(
            fromJson: (json) => ProfileModel.fromJson(json),

            onSuccess: (response) async {
              final profileUser = response.payload?.user;

              if (profileUser != null) {
                Prefs.setUserData(
                  UserModel(
                    userId: profileUser.userId,

                    uniqueUserId: profileUser.uniqueUserId,

                    userType: profileUser.userType,

                    name: profileUser.name,

                    email: profileUser.email,

                    isEmailVerified: profileUser.isEmailVerified,

                    isdCode: profileUser.isdCode,

                    phone: profileUser.phone,

                    isPhoneVerified: profileUser.isPhoneVerified,

                    profilePic: profileUser.profilePic,

                    userActiveRoutes: profileUser.userActiveRoutes,

                    userActiveVehicles: profileUser.userActiveVehicles,

                    isKycVerified: profileUser.isKycVerified,

                    paymentTerm: profileUser.paymentTerm,

                    avgRating: profileUser.avgRating,

                    kycData: profileUser.kycData,
                  ),
                );
              }
            },

            onFailure: (message, {code}) {
              AppToast.short(message);
            },
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
