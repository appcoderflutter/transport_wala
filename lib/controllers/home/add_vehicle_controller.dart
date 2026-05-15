import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/photoPicker/photo_picker.dart';
import '../../helpers/toaster.dart';
import '../../model/max_capacity_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';
import '../../routes/app_routes.dart';
import 'home_controller.dart';

class AddVehicleController extends GetxController {
  /// =========================
  /// SUBMIT LOADING
  /// =========================

  RxBool isSubmitting = false.obs;

  /// =========================
  /// IMAGE
  /// =========================

  Rx<File?> selectedImage = Rx<File?>(null);

  /// =========================
  /// TEXT CONTROLLERS
  /// =========================

  final modelController = TextEditingController();

  final registrationController = TextEditingController();

  final mileageController = TextEditingController();

  /// =========================
  /// CAPACITY LIST
  /// =========================

  RxBool isCapacityLoading = false.obs;

  RxList<MaxCapacityData> capacityList = <MaxCapacityData>[].obs;

  /// =========================
  /// SELECTED CAPACITY
  /// =========================

  Rxn<MaxCapacityData> selectedCapacity = Rxn<MaxCapacityData>();

  @override
  void onInit() {
    getMaxCapacityList();

    super.onInit();
  }

  /// =========================
  /// VALIDATE
  /// =========================

  bool validateFields() {
    if (modelController.text.trim().isEmpty) {
      AppToast.short("Enter model number");

      return false;
    }

    if (registrationController.text.trim().isEmpty) {
      AppToast.short("Enter registration number");

      return false;
    }

    if (selectedCapacity.value == null) {
      AppToast.short("Select capacity");

      return false;
    }

    if (mileageController.text.trim().isEmpty) {
      AppToast.short("Enter mileage");

      return false;
    }

    return true;
  }

  /// =========================
  /// SAVE VEHICLE
  /// =========================

  Future<void> saveVehicle() async {
    if (!validateFields()) {
      return;
    }

    try {
      isSubmitting.value = true;

      /// =====================
      /// BASE64 IMAGE
      /// =====================

      String base64Image = "";

      if (selectedImage.value != null) {
        final bytes = await selectedImage.value!.readAsBytes();

        final imageBase64 = base64Encode(bytes);

        base64Image = "data:image/jpeg;base64,$imageBase64";
      }

      await DioHelper.builder()
          .setMethod("POST")
          .setUrl(ApiEndpoints.saveVehicle)
          .setData({
            "vehicleTypeId": "2",

            "rcNo": registrationController.text.trim(),

            "modelNo": modelController.text.trim(),

            "tryeCountId": "2",

            "maxPower": "",

            "maxCapacityId":
                selectedCapacity.value?.maxCapacityId?.toString() ?? "",

            "maxVolume": "",

            "manufacturer": "",

            "vehicleImage": base64Image,

            "preferredType": "LOCAL",

            "hsd": mileageController.text.trim(),

            "materialType": "",
          })
          .execute(
            onSuccess: (response) async {
              /// REFRESH HOME LIST

              if (Get.isRegistered<HomeController>()) {
                final homeController = Get.find<HomeController>();

                await homeController.getVehicleList();
              }

              AppToast.short("Vehicle added successfully");

              /// GO BACK

              Get.offAllNamed(AppRoutes.homePage);
            },

            onFailure: (message, {code}) {
              AppToast.short(message);
            },
          );
    } catch (e) {
      AppToast.short("Something went wrong");
    } finally {
      isSubmitting.value = false;
    }
  }

  /// =========================
  /// GET MAX CAPACITY
  /// =========================

  Future<void> getMaxCapacityList() async {
    try {
      isCapacityLoading.value = true;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.MaxCapacityList)
          .execute<MaxCapacityModel>(
            fromJson: (json) => MaxCapacityModel.fromJson(json),

            onSuccess: (response) {
              capacityList.value = response.payload?.maxCapacityList ?? [];
            },

            onFailure: (message, {code}) {
              capacityList.clear();

              AppToast.short(message);
            },
          );
    } catch (e) {
      capacityList.clear();

      AppToast.short("Failed to load capacity list");
    } finally {
      isCapacityLoading.value = false;
    }
  }

  /// =========================
  /// PICK IMAGE
  /// =========================

  Future<void> pickVehicleImage() async {
    PhotoPicker.show(
      onImageSelected: (file) {
        selectedImage.value = file;
      },
    );
  }

  @override
  void onClose() {
    modelController.dispose();

    registrationController.dispose();

    mileageController.dispose();

    super.onClose();
  }
}
