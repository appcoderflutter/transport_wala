import 'package:get/get.dart';

import '../../helpers/toaster.dart';
import '../../model/contact_us_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';

class ContactUsController extends GetxController {
  /// LOADING

  RxBool isLoading = false.obs;

  /// CONTACT DATA

  Rxn<ContactUsData> contactUsData = Rxn<ContactUsData>();

  @override
  void onInit() {
    super.onInit();

    getContactUs();
  }

  /// =========================
  /// GET CONTACT API
  /// =========================

  Future<void> getContactUs() async {
    isLoading.value = true;

    await DioHelper.builder()
        .setMethod("GET")
        .setUrl(ApiEndpoints.getContactUs)
        .execute<ContactUsModel>(
          fromJson: (json) => ContactUsModel.fromJson(json),

          onSuccess: (response) {
            contactUsData.value = response.contactUsData;
          },

          onFailure: (message, {code}) {
            AppToast.short(message);
          },
        );

    isLoading.value = false;
  }
}
