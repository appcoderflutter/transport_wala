class LoginSendOtpModel {

  final int status;

  final String msg;

  final LoginOtpPayload? payload;

  LoginSendOtpModel({

    required this.status,

    required this.msg,

    this.payload,
  });

  factory LoginSendOtpModel
      .fromJson(
      Map<String, dynamic> json) {

    return LoginSendOtpModel(

      status:
      json["status"] ?? 0,

      msg:
      json["msg"] ?? "",

      payload:
      json["payload"] != null

          ? LoginOtpPayload
          .fromJson(
          json["payload"])

          : null,
    );
  }
}

class LoginOtpPayload {

  final int otp;

  LoginOtpPayload({
    required this.otp,
  });

  factory LoginOtpPayload
      .fromJson(
      Map<String, dynamic> json) {

    return LoginOtpPayload(

      otp:
      json["otp"] ?? 0,
    );
  }
}