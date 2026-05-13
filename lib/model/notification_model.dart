class NotificationModel {
  final int status;
  final String msg;
  final NotificationPayload? payload;

  NotificationModel({required this.status, required this.msg, this.payload});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      payload: json["payload"] != null
          ? NotificationPayload.fromJson(json["payload"])
          : null,
    );
  }
}

class NotificationPayload {
  final NotificationPagination? notificationList;

  NotificationPayload({this.notificationList});

  factory NotificationPayload.fromJson(Map<String, dynamic> json) {
    return NotificationPayload(
      notificationList: json["notificationList"] != null
          ? NotificationPagination.fromJson(json["notificationList"])
          : null,
    );
  }
}

class NotificationPagination {
  final int currentPage;

  final List<NotificationItem> data;

  final int total;

  NotificationPagination({
    required this.currentPage,

    required this.data,

    required this.total,
  });

  factory NotificationPagination.fromJson(Map<String, dynamic> json) {
    return NotificationPagination(
      currentPage: json["current_page"] ?? 0,

      total: json["total"] ?? 0,

      data: json["data"] != null
          ? List<NotificationItem>.from(
              json["data"].map((x) => NotificationItem.fromJson(x)),
            )
          : [],
    );
  }
}

class NotificationItem {
  final int id;

  final String title;

  final String message;

  final String createdAt;

  NotificationItem({
    required this.id,

    required this.title,

    required this.message,

    required this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json["id"] ?? 0,

      title: json["title"] ?? "",

      message: json["message"] ?? "",

      createdAt: json["created_at"] ?? "",
    );
  }
}
