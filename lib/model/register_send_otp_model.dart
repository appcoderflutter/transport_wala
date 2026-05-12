class RegisterSendOtpModel {

  final int status;
  final String msg;
  final RegisterOtpData? payload;

  RegisterSendOtpModel({

    required this.status,

    required this.msg,

    required this.payload,
  });

  factory RegisterSendOtpModel
      .fromJson(
      Map<String, dynamic> json) {

    return RegisterSendOtpModel(

      status:
      json["status"] ?? 0,

      msg:
      json["msg"] ?? "",

      payload:
      json["payload"] != null

          ? RegisterOtpData
          .fromJson(
          json["payload"])

          : null,
    );
  }
}

class RegisterOtpData {

  final int otp;

  RegisterOtpData({
    required this.otp,
  });

  factory RegisterOtpData
      .fromJson(
      Map<String, dynamic> json) {

    return RegisterOtpData(

      otp:
      json["otp"] ?? 0,
    );
  }
}