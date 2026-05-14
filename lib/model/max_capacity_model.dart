class MaxCapacityModel {
  final int status;

  final String msg;

  final MaxCapacityPayload? payload;

  MaxCapacityModel({required this.status, required this.msg, this.payload});

  factory MaxCapacityModel.fromJson(Map<String, dynamic> json) {
    return MaxCapacityModel(
      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      payload: json["payload"] != null
          ? MaxCapacityPayload.fromJson(json["payload"])
          : null,
    );
  }
}

class MaxCapacityPayload {
  final List<MaxCapacityData> maxCapacityList;

  MaxCapacityPayload({this.maxCapacityList = const []});

  factory MaxCapacityPayload.fromJson(Map<String, dynamic> json) {
    return MaxCapacityPayload(
      maxCapacityList: json["maxCapacityList"] != null
          ? List<MaxCapacityData>.from(
              json["maxCapacityList"].map((x) => MaxCapacityData.fromJson(x)),
            )
          : [],
    );
  }
}

class MaxCapacityData {
  final int? maxCapacityId;

  final String? maxCapacity;

  MaxCapacityData({this.maxCapacityId, this.maxCapacity});

  factory MaxCapacityData.fromJson(Map<String, dynamic> json) {
    return MaxCapacityData(
      maxCapacityId: json["maxCapacityId"],

      maxCapacity: json["maxCapacity"],
    );
  }
}
