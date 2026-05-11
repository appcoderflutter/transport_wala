import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverController
    extends GetxController {

  /// =========================
  /// OVERVIEW
  /// =========================

  final totalDrivers =
      28.obs;

  final activeDrivers =
      20.obs;

  final onTripDrivers =
      14.obs;

  /// =========================
  /// SEARCH
  /// =========================

  final searchText =
      "".obs;

  /// SEARCH CONTROLLER
  final searchController =
  TextEditingController();

  /// SEARCH FOCUS
  final searchFocusNode =
  FocusNode();

  /// =========================
  /// DRIVER LIST
  /// API READY
  /// =========================

  final RxList<Map<String, dynamic>>
  drivers =
      <Map<String, dynamic>>[

        {
          "name":
          "Arijit Das",

          "phone":
          "+91 9876543210",

          "truck":
          "Mahindra Blazo",

          "experience":
          "8 Years",

          "rating":
          "4.9",

          "status":
          "On Trip",

          "image":
          "",
        },

        {
          "name":
          "Rahul Sharma",

          "phone":
          "+91 9123456780",

          "truck":
          "Tata Signa",

          "experience":
          "5 Years",

          "rating":
          "4.7",

          "status":
          "Available",

          "image":
          "",
        },

        {
          "name":
          "Sourav Roy",

          "phone":
          "+91 9988776655",

          "truck":
          "Ashok Leyland",

          "experience":
          "10 Years",

          "rating":
          "5.0",

          "status":
          "On Trip",

          "image":
          "",
        },

        {
          "name":
          "Arijit Das",

          "phone":
          "+91 9876543210",

          "truck":
          "Mahindra Blazo",

          "experience":
          "8 Years",

          "rating":
          "4.9",

          "status":
          "On Trip",

          "image":
          "",
        },

        {
          "name":
          "Rahul Sharma",

          "phone":
          "+91 9123456780",

          "truck":
          "Tata Signa",

          "experience":
          "5 Years",

          "rating":
          "4.7",

          "status":
          "Available",

          "image":
          "",
        },

        {
          "name":
          "Sourav Roy",

          "phone":
          "+91 9988776655",

          "truck":
          "Ashok Leyland",

          "experience":
          "10 Years",

          "rating":
          "5.0",

          "status":
          "On Trip",

          "image":
          "",
        },

      ].obs;

  /// =========================
  /// FILTERED LIST
  /// =========================

  List<Map<String, dynamic>>
  get filteredDrivers {

    if (searchText.value
        .trim()
        .isEmpty) {

      return drivers;
    }

    return drivers.where((driver) {

      final name =
      (driver["name"] ?? "")
          .toString()
          .toLowerCase();

      return name.contains(
        searchText.value
            .toLowerCase(),
      );
    }).toList();
  }

  /// =========================
  /// CLEAR SEARCH
  /// =========================

  void clearSearch() {

    /// CLEAR TEXTFIELD
    searchController.clear();

    /// CLEAR SEARCH VALUE
    searchText.value = "";

    /// REMOVE KEYBOARD
    searchFocusNode.unfocus();
  }

  @override
  void onClose() {

    searchController.dispose();

    searchFocusNode.dispose();

    super.onClose();
  }
}