class UserModel {
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

  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,

      "uniqueUserId": uniqueUserId,

      "userType": userType,

      "name": name,

      "email": email,

      "isEmailVerified": isEmailVerified,

      "isdCode": isdCode,

      "phone": phone,

      "isPhoneVerified": isPhoneVerified,

      "profilePic": profilePic,

      "userActiveRoutes": userActiveRoutes,

      "userActiveVehicles": userActiveVehicles,

      "isKycVerified": isKycVerified,

      "paymentTerm": paymentTerm,

      "avgRating": avgRating,

      "kycData": kycData.map((e) => e.toJson()).toList(),
    };
  }

  /// =========================
  /// COPY WITH
  /// =========================

  UserModel copyWith({
    int? userId,

    int? uniqueUserId,

    String? userType,

    String? name,

    String? email,

    String? isEmailVerified,

    String? isdCode,

    String? phone,

    String? isPhoneVerified,

    String? profilePic,

    int? userActiveRoutes,

    int? userActiveVehicles,

    String? isKycVerified,

    String? paymentTerm,

    dynamic avgRating,

    List<KycData>? kycData,
  }) {
    return UserModel(
      userId: userId ?? this.userId,

      uniqueUserId: uniqueUserId ?? this.uniqueUserId,

      userType: userType ?? this.userType,

      name: name ?? this.name,

      email: email ?? this.email,

      isEmailVerified: isEmailVerified ?? this.isEmailVerified,

      isdCode: isdCode ?? this.isdCode,

      phone: phone ?? this.phone,

      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,

      profilePic: profilePic ?? this.profilePic,

      userActiveRoutes: userActiveRoutes ?? this.userActiveRoutes,

      userActiveVehicles: userActiveVehicles ?? this.userActiveVehicles,

      isKycVerified: isKycVerified ?? this.isKycVerified,

      paymentTerm: paymentTerm ?? this.paymentTerm,

      avgRating: avgRating ?? this.avgRating,

      kycData: kycData ?? this.kycData,
    );
  }
}

class KycData {
  final String? address;

  final String? aadharNo;

  final String? aadharCardFrontSide;

  final String? aadharCardBackSide;

  final String? companyName;

  final String? mainOfficeAddress;

  final String? mainOfficePhoneNo;

  final String? branchOfficeAddress;

  final String? branchOfficePhoneNo;

  final String? contactPersonName;

  final String? contactPersonPhoneNo;

  final String? gstNo;

  final String? transportLicence;

  const KycData({
    this.address,

    this.aadharNo,

    this.aadharCardFrontSide,

    this.aadharCardBackSide,

    this.companyName,

    this.mainOfficeAddress,

    this.mainOfficePhoneNo,

    this.branchOfficeAddress,

    this.branchOfficePhoneNo,

    this.contactPersonName,

    this.contactPersonPhoneNo,

    this.gstNo,

    this.transportLicence,
  });

  factory KycData.fromJson(Map<String, dynamic> json) {
    return KycData(
      address: json["address"],

      aadharNo: json["aadharNo"],

      aadharCardFrontSide: json["aadharCardFrontSide"],

      aadharCardBackSide: json["aadharCardBackSide"],

      companyName: json["companyName"],

      mainOfficeAddress: json["mainOfficeAddress"],

      mainOfficePhoneNo: json["mainOfficePhoneNo"],

      branchOfficeAddress: json["branchOfficeAddress"],

      branchOfficePhoneNo: json["branchOfficePhoneNo"],

      contactPersonName: json["contactPersonName"],

      contactPersonPhoneNo: json["contactPersonPhoneNo"],

      gstNo: json["gstNo"],

      transportLicence: json["transportLicence"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,

      "aadharNo": aadharNo,

      "aadharCardFrontSide": aadharCardFrontSide,

      "aadharCardBackSide": aadharCardBackSide,

      "companyName": companyName,

      "mainOfficeAddress": mainOfficeAddress,

      "mainOfficePhoneNo": mainOfficePhoneNo,

      "branchOfficeAddress": branchOfficeAddress,

      "branchOfficePhoneNo": branchOfficePhoneNo,

      "contactPersonName": contactPersonName,

      "contactPersonPhoneNo": contactPersonPhoneNo,

      "gstNo": gstNo,

      "transportLicence": transportLicence,
    };
  }
}
