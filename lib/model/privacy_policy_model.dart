class PrivacyPolicyModel {

  final int status;
  final String msg;
  final PrivacyPolicyData privacyPolicyData;

  PrivacyPolicyModel({
    required this.status,
    required this.msg,
    required this.privacyPolicyData,
  });

  factory PrivacyPolicyModel.fromJson(
      Map<String, dynamic> json) {

    return PrivacyPolicyModel(

      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      privacyPolicyData:
      PrivacyPolicyData.fromJson(
        json["payload"]
        ["privacyPolicy"],
      ),
    );
  }
}

class PrivacyPolicyData {

  final String title;
  final String privacyPolicy;

  PrivacyPolicyData({
    required this.title,
    required this.privacyPolicy,
  });

  factory PrivacyPolicyData.fromJson(
      Map<String, dynamic> json) {

    return PrivacyPolicyData(

      title: json["title"] ?? "",

      privacyPolicy:
      json["privacyPolicy"] ?? "",
    );
  }
}