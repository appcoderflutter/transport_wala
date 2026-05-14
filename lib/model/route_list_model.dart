class RouteListModel {
  final int status;

  final String msg;

  final RoutePayload? payload;

  RouteListModel({required this.status, required this.msg, this.payload});

  factory RouteListModel.fromJson(Map<String, dynamic> json) {
    return RouteListModel(
      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      payload: json["payload"] != null
          ? RoutePayload.fromJson(json["payload"])
          : null,
    );
  }
}

class RoutePayload {
  final VehicleRouteList? vehicleRouteList;

  RoutePayload({this.vehicleRouteList});

  factory RoutePayload.fromJson(Map<String, dynamic> json) {
    return RoutePayload(
      vehicleRouteList: json["vehicleRouteList"] != null
          ? VehicleRouteList.fromJson(json["vehicleRouteList"])
          : null,
    );
  }
}

class VehicleRouteList {
  final int? currentPage;

  final int? total;

  final List<RouteData> data;

  VehicleRouteList({this.currentPage, this.total, this.data = const []});

  factory VehicleRouteList.fromJson(Map<String, dynamic> json) {
    return VehicleRouteList(
      currentPage: json["current_page"],

      total: json["total"],

      data: json["data"] != null
          ? List<RouteData>.from(json["data"].map((x) => RouteData.fromJson(x)))
          : [],
    );
  }
}

class RouteData {
  final int? routeId;

  final int? fromCityId;

  final String? fromCity;

  final int? toCityId;

  final String? toCity;

  final String? status;

  RouteData({
    this.routeId,

    this.fromCityId,

    this.fromCity,

    this.toCityId,

    this.toCity,

    this.status,
  });

  factory RouteData.fromJson(Map<String, dynamic> json) {
    return RouteData(
      routeId: json["routeId"],

      fromCityId: json["fromCityId"],

      fromCity: json["fromCity"],

      toCityId: json["toCityId"],

      toCity: json["toCity"],

      status: json["status"],
    );
  }
}
