import 'package:get/get.dart';

import '../../model/route_list_model.dart';
import '../../model/vehicle_list_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';

class VehicleDetailsController extends GetxController {
  /// =========================
  /// VEHICLE
  /// =========================

  late final VehicleData vehicle;

  /// =========================
  /// ACTIVE LANES
  /// =========================

  final RxList<String> activeLanes = <String>[].obs;

  /// =========================
  /// LOADING
  /// =========================

  RxBool isRouteLoading = false.obs;

  @override
  void onInit() {
    vehicle = Get.arguments as VehicleData;

    getRouteList();

    super.onInit();
  }

  /// =========================
  /// GET ROUTE LIST
  /// =========================

  Future<void> getRouteList() async {
    try {
      isRouteLoading.value = true;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getRouteList)
          .execute<RouteListModel>(
            fromJson: (json) => RouteListModel.fromJson(json),

            onSuccess: (response) {
              activeLanes.clear();

              final routes = response.payload?.vehicleRouteList?.data ?? [];

              for (final route in routes) {
                /// SAME ROUTE ID

                if (route.routeId == vehicle.routeId) {
                  final fromCity = route.fromCity?.trim() ?? "";

                  final toCity = route.toCity?.trim() ?? "";

                  /// NULL SAFETY

                  if (fromCity.isNotEmpty &&
                      toCity.isNotEmpty &&
                      fromCity != "NA" &&
                      toCity != "NA") {
                    activeLanes.add("$fromCity - $toCity");
                  }
                }
              }

              /// FALLBACK

              if (activeLanes.isEmpty) {
                final fromCity = vehicle.fromCity?.trim() ?? "";

                final toCity = vehicle.toCity?.trim() ?? "";

                if (fromCity.isNotEmpty &&
                    toCity.isNotEmpty &&
                    fromCity != "NA" &&
                    toCity != "NA") {
                  activeLanes.add("$fromCity - $toCity");
                }
              }
            },

            onFailure: (message, {code}) {
              activeLanes.clear();
            },
          );
    } catch (e) {
      activeLanes.clear();
    } finally {
      isRouteLoading.value = false;
    }
  }
}
