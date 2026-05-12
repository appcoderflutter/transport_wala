class RegisterModel {

  final int status;
  final String msg;
  final RegisterPayload? payload;

  RegisterModel({

    required this.status,

    required this.msg,

    this.payload,
  });

  factory RegisterModel.fromJson(
      Map<String, dynamic> json) {

    return RegisterModel(

      status:
      json["status"] ?? 0,

      msg:
      json["msg"] ?? "",

      payload:
      json["payload"] != null

          ? RegisterPayload.fromJson(
          json["payload"])

          : null,
    );
  }
}

class RegisterPayload {

  final String tokenType;
  final String token;
  final RegisterUser? user;

  RegisterPayload({

    required this.tokenType,

    required this.token,

    this.user,
  });

  factory RegisterPayload.fromJson(
      Map<String, dynamic> json) {

    return RegisterPayload(

      tokenType:
      json["tokenType"] ?? "",

      token:
      json["token"] ?? "",

      user:
      json["user"] != null

          ? RegisterUser.fromJson(
          json["user"])

          : null,
    );
  }
}

class RegisterUser {

  final int userId;

  final String name;

  final String phone;

  final String userType;

  final String? profilePic;

  RegisterUser({

    required this.userId,

    required this.name,

    required this.phone,

    required this.userType,

    this.profilePic,
  });

  factory RegisterUser.fromJson(
      Map<String, dynamic> json) {

    return RegisterUser(

      userId:
      json["userId"] ?? 0,

      name:
      json["name"] ?? "",

      phone:
      json["phone"] ?? "",

      userType:
      json["userType"] ?? "",

      profilePic:
      json["profilePic"] as String?,
    );
  }
}