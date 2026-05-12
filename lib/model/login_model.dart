class LoginModel {

  final int status;

  final String msg;

  final LoginPayload? payload;

  LoginModel({

    required this.status,

    required this.msg,

    this.payload,
  });

  factory LoginModel.fromJson(
      Map<String, dynamic> json) {

    return LoginModel(

      status:
      json["status"] ?? 0,

      msg:
      json["msg"] ?? "",

      payload:
      json["payload"] != null

          ? LoginPayload
          .fromJson(
          json["payload"])

          : null,
    );
  }
}

class LoginPayload {

  final String tokenType;

  final String token;

  final LoginUser? user;

  LoginPayload({

    required this.tokenType,

    required this.token,

    this.user,
  });

  factory LoginPayload.fromJson(
      Map<String, dynamic> json) {

    return LoginPayload(

      tokenType:
      json["tokenType"] ?? "",

      token:
      json["token"] ?? "",

      user:
      json["user"] != null
          ? LoginUser.fromJson(json["user"])
          : null,
    );
  }
}

class LoginUser {

  final int userId;

  final String name;

  final String phone;

  final String userType;

  final String? profilePic;

  LoginUser({

    required this.userId,

    required this.name,

    required this.phone,

    required this.userType,

    this.profilePic,
  });

  factory LoginUser.fromJson(
      Map<String, dynamic> json) {

    return LoginUser(

      userId: json["userId"] ?? 0,

      name: json["name"] ?? "",

      phone: json["phone"] ?? "",

      userType: json["userType"] ?? "",

      profilePic: json["profilePic"] as String?,
    );
  }
}