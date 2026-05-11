import 'package:get/get.dart';

class AboutController
    extends GetxController {

  /// =========================
  /// APP INFO
  /// =========================

  final appName =
      "Transport Wala".obs;

  final slogan =
      "Smart logistics for modern transport business."
          .obs;

  final description =
      "Transport Wala helps transport owners manage vehicles, drivers, bookings, and logistics operations with a seamless digital experience."
          .obs;

  /// =========================
  /// STATS
  /// =========================

  final totalVehicles =
      "1200+".obs;

  final activeDrivers =
      "850+".obs;

  final completedTrips =
      "15K+".obs;

  /// =========================
  /// FEATURES
  /// API READY
  /// =========================

  final RxList<Map<String, dynamic>>
  features =
      <Map<String, dynamic>>[

        {
          "title":
          "Smart Vehicle Management",

          "description":
          "Track and manage all transport vehicles in one premium dashboard.",

          "icon":
          "local_shipping",
        },

        {
          "title":
          "Real-time Booking",

          "description":
          "Manage transport requests and lane activities instantly.",

          "icon":
          "location_on",
        },

        {
          "title":
          "Secure & Reliable",

          "description":
          "Advanced security and protected transport operations.",

          "icon":
          "verified_user",
        },

        {
          "title":
          "Driver Management",

          "description":
          "Manage drivers, trips, and activities efficiently.",

          "icon":
          "supervised_user_circle",
        },

      ].obs;
}