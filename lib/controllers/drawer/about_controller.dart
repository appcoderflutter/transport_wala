import 'package:get/get.dart';

import '../../helpers/toaster.dart';
import '../../model/aboutUs_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';

class AboutController
    extends GetxController {

  /// LOADING

  RxBool isLoading = false.obs;

  /// APP INFO

  final appName =
      "Transport Wala".obs;

  final slogan =
      "Smart logistics for modern transport business."
          .obs;

  /// ABOUT DATA

  Rxn<AboutData> aboutData =
  Rxn<AboutData>();

  @override
  void onInit() {

    super.onInit();

    getAboutUs();
  }

  /// =========================
  /// GET ABOUT API
  /// =========================

  Future<void> getAboutUs()
  async {

    isLoading.value = true;

    await DioHelper.builder()

        .setMethod("GET")

        .setUrl(
        ApiEndpoints.getAboutUs)

        .execute<AboutModel>(

      fromJson: (json) =>
          AboutModel.fromJson(json),

      onSuccess: (response) {

        aboutData.value =
            response.aboutData;
      },

      onFailure:
          (message, {code}) {

        AppToast.short(message);
      },
    );

    isLoading.value = false;
  }
}