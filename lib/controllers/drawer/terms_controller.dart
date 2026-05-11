import 'package:get/get.dart';

import '../../helpers/toaster.dart';
import '../../model/terms_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';

class TermsController extends GetxController {

  /// LOADING
  RxBool isLoading = false.obs;

  /// TERMS DATA
  Rxn<TermsData> termsData =
  Rxn<TermsData>();

  @override
  void onInit() {
    super.onInit();
    getTermsConditions();
  }

  /// GET TERMS API

  Future<void> getTermsConditions() async {

    isLoading.value = true;

    await DioHelper.builder()

        .setMethod("GET")

        .setUrl(
        ApiEndpoints.getTermsConditions)

        .execute<TermsModel>(

      fromJson: (json) =>
          TermsModel.fromJson(json),

      onSuccess: (response) {

        termsData.value =
            response.termsData;
      },

      onFailure: (message, {code}) {

        AppToast.short(message);
      },
    );

    isLoading.value = false;
  }
}