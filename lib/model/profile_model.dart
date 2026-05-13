import 'package:transport_wala/model/user_model.dart';

class ProfileModel {
  final int status;

  final String msg;

  final ProfilePayload? payload;

  ProfileModel({required this.status, required this.msg, this.payload});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      payload: json["payload"] != null
          ? ProfilePayload.fromJson(json["payload"])
          : null,
    );
  }
}

class ProfilePayload {
  final ProfileUser? user;

  ProfilePayload({this.user});

  factory ProfilePayload.fromJson(Map<String, dynamic> json) {
    return ProfilePayload(
      user: json["user"] != null ? ProfileUser.fromJson(json["user"]) : null,
    );
  }
}

class ProfileUser {
  final int? userId;

  final int? uniqueUserId;

  final String? userType;

  final String? name;

  final String? email;

  final String? isEmailVerified;

  final String? isdCode;

  final String? phone;

  final String? isPhoneVerified;

  final String? profilePic;

  final int? userActiveRoutes;

  final int? userActiveVehicles;

  final String? isKycVerified;

  final String? paymentTerm;

  final dynamic avgRating;

  final List<KycData> kycData;

  ProfileUser({
    this.userId,

    this.uniqueUserId,

    this.userType,

    this.name,

    this.email,

    this.isEmailVerified,

    this.isdCode,

    this.phone,

    this.isPhoneVerified,

    this.profilePic,

    this.userActiveRoutes,

    this.userActiveVehicles,

    this.isKycVerified,

    this.paymentTerm,

    this.avgRating,

    this.kycData = const [],
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      userId: json["userId"],

      uniqueUserId: json["uniqueUserId"],

      userType: json["userType"],

      name: json["name"],

      email: json["email"],

      isEmailVerified: json["isEmailVerified"],

      isdCode: json["isdCode"],

      phone: json["phone"],

      isPhoneVerified: json["isPhoneVerified"],

      profilePic: json["profilePic"],

      userActiveRoutes: json["userActiveRoutes"],

      userActiveVehicles: json["userActiveVehicles"],

      isKycVerified: json["isKycVerified"],

      paymentTerm: json["paymentTerm"],

      avgRating: json["avgRating"],

      kycData: json["kycData"] != null
          ? List<KycData>.from(json["kycData"].map((x) => KycData.fromJson(x)))
          : [],
    );
  }
}
