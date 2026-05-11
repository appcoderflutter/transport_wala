class TermsModel {

  final int status;
  final String msg;
  final TermsData termsData;

  TermsModel({
    required this.status,
    required this.msg,
    required this.termsData,
  });

  factory TermsModel.fromJson(
      Map<String, dynamic> json) {

    return TermsModel(

      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      termsData: TermsData.fromJson(
        json["payload"]["termsConditions"],
      ),
    );
  }
}

class TermsData {

  final String title;
  final String termsConditions;

  TermsData({
    required this.title,
    required this.termsConditions,
  });

  factory TermsData.fromJson(
      Map<String, dynamic> json) {

    return TermsData(

      title: json["title"] ?? "",

      termsConditions:
      json["termsConditions"] ?? "",
    );
  }
}