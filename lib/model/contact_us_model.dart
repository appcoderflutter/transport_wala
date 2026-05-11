class ContactUsModel {

  final int status;
  final String msg;
  final ContactUsData contactUsData;

  ContactUsModel({
    required this.status,
    required this.msg,
    required this.contactUsData,
  });

  factory ContactUsModel.fromJson(
      Map<String, dynamic> json) {

    return ContactUsModel(

      status: json["status"] ?? 0,

      msg: json["msg"] ?? "",

      contactUsData:
      ContactUsData.fromJson(
        json["payload"]
        ["contactUs"],
      ),
    );
  }
}

class ContactUsData {

  final String address;
  final String email;
  final String phone;
  final String whatsAppLink;

  ContactUsData({
    required this.address,
    required this.email,
    required this.phone,
    required this.whatsAppLink,
  });

  factory ContactUsData.fromJson(
      Map<String, dynamic> json) {

    return ContactUsData(

      address:
      json["address"] ?? "",

      email:
      json["email"] ?? "",

      phone:
      json["phone"] ?? "",

      whatsAppLink:
      json["whatsAppLink"] ?? "",
    );
  }
}