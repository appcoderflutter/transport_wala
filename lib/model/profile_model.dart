class ProfileModel {

  final int status;

  final String msg;

  final ProfilePayload? payload;

  ProfileModel({

    required this.status,

    required this.msg,

    this.payload,
  });

  factory ProfileModel.fromJson(
      Map<String, dynamic> json) {

    return ProfileModel(

      status:
      json["status"] ?? 0,

      msg:
      json["msg"] ?? "",

      payload:
      json["payload"] != null

          ? ProfilePayload
          .fromJson(
          json["payload"])

          : null,
    );
  }
}

class ProfilePayload {

  final ProfileUser? user;

  ProfilePayload({
    this.user,
  });

  factory ProfilePayload.fromJson(
      Map<String, dynamic> json) {

    return ProfilePayload(

      user:
      json["user"] != null

          ? ProfileUser
          .fromJson(
          json["user"])

          : null,
    );
  }
}

class ProfileUser {

  final int userId;

  final String name;

  final String phone;

  final String userType;

  final String profilePic;

  ProfileUser({

    required this.userId,

    required this.name,

    required this.phone,

    required this.userType,

    required this.profilePic,
  });

  factory ProfileUser.fromJson(
      Map<String, dynamic> json) {

    return ProfileUser(

      userId:
      json["userId"] ?? 0,

      name:
      json["name"] ?? "",

      phone:
      json["phone"] ?? "",

      userType:
      json["userType"] ?? "",

      profilePic:
      json["profilePic"] ?? "",
    );
  }
}