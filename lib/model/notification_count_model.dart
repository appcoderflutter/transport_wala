class NotificationCountModel {
  final int status;

  final String msg;

  final NotificationCountPayload? payload;

  NotificationCountModel({
    required this.status,

    required this.msg,

    this.payload,
  });

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) {
    return NotificationCountModel(
      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      payload: json["payload"] != null
          ? NotificationCountPayload.fromJson(json["payload"])
          : null,
    );
  }
}

class NotificationCountPayload {
  final int count;

  NotificationCountPayload({required this.count});

  factory NotificationCountPayload.fromJson(Map<String, dynamic> json) {
    return NotificationCountPayload(count: json["count"] ?? 0);
  }
}
