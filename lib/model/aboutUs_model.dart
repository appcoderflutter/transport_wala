class AboutModel {

  final int status;
  final String msg;
  final AboutData aboutData;

  AboutModel({
    required this.status,
    required this.msg,
    required this.aboutData,
  });

  factory AboutModel.fromJson(
      Map<String, dynamic> json) {

    return AboutModel(

      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      aboutData: AboutData.fromJson(
        json["payload"]["aboutUs"],
      ),
    );
  }
}

class AboutData {

  final String aboutUs;

  AboutData({
    required this.aboutUs,
  });

  factory AboutData.fromJson(
      Map<String, dynamic> json) {

    return AboutData(

      aboutUs:
      json["aboutUs"] ?? "",
    );
  }
}