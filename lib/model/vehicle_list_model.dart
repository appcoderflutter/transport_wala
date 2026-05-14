class VehicleListModel {
  final int status;

  final String msg;

  final VehiclePayload? payload;

  VehicleListModel({required this.status, required this.msg, this.payload});

  factory VehicleListModel.fromJson(Map<String, dynamic> json) {
    return VehicleListModel(
      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      payload: json["payload"] != null
          ? VehiclePayload.fromJson(json["payload"])
          : null,
    );
  }
}

class VehiclePayload {
  final VehicleListData? vehicleList;

  VehiclePayload({this.vehicleList});

  factory VehiclePayload.fromJson(Map<String, dynamic> json) {
    return VehiclePayload(
      vehicleList: json["vehicleList"] != null
          ? VehicleListData.fromJson(json["vehicleList"])
          : null,
    );
  }
}

class VehicleListData {
  final int? currentPage;

  final int? total;

  final List<VehicleData> data;

  VehicleListData({this.currentPage, this.total, this.data = const []});

  factory VehicleListData.fromJson(Map<String, dynamic> json) {
    return VehicleListData(
      currentPage: json["current_page"],

      total: json["total"],

      data: json["data"] != null
          ? List<VehicleData>.from(
              json["data"].map((x) => VehicleData.fromJson(x)),
            )
          : [],
    );
  }
}

class VehicleData {
  final int? vehicleId;

  final int? routeId;

  final String? fromCity;

  final String? toCity;

  final String? routeStatus;

  final String? routeDirection;

  final int? vehicleTypeId;

  final String? vehicleType;

  final String? rcNo;

  final String? modelNo;

  final dynamic tryeCount;

  final String? maxPower;

  final String? maxCapacity;

  final String? maxVolume;

  final String? manufacturer;

  final String? vehicleImage;

  final String? status;

  final String? enRouteStatus;

  final String? preferredType;

  final String? hsd;

  final String? materialType;

  VehicleData({
    this.vehicleId,

    this.routeId,

    this.fromCity,

    this.toCity,

    this.routeStatus,

    this.routeDirection,

    this.vehicleTypeId,

    this.vehicleType,

    this.rcNo,

    this.modelNo,

    this.tryeCount,

    this.maxPower,

    this.maxCapacity,

    this.maxVolume,

    this.manufacturer,

    this.vehicleImage,

    this.status,

    this.enRouteStatus,

    this.preferredType,

    this.hsd,

    this.materialType,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      vehicleId: json["vehicleId"],

      routeId: json["routeId"],

      fromCity: json["fromCity"],

      toCity: json["toCity"],

      routeStatus: json["routeStatus"],

      routeDirection: json["routeDirection"],

      vehicleTypeId: json["vehicleTypeId"],

      vehicleType: json["vehicleType"],

      rcNo: json["rcNo"],

      modelNo: json["modelNo"],

      tryeCount: json["tryeCount"],

      maxPower: json["maxPower"],

      maxCapacity: json["maxCapacity"],

      maxVolume: json["maxVolume"],

      manufacturer: json["manufacturer"],

      vehicleImage: json["vehicleImage"],

      status: json["status"],

      enRouteStatus: json["enRouteStatus"],

      preferredType: json["preferredType"],

      hsd: json["hsd"],

      materialType: json["materialType"],
    );
  }
}
