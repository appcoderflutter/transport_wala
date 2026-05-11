import 'package:get/get.dart';

import '../../helpers/toaster.dart';
import '../../model/privacy_policy_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';

class PrivacyPolicyController extends GetxController {
  /// LOADING

  RxBool isLoading = false.obs;

  /// PRIVACY DATA

  Rxn<PrivacyPolicyData> privacyPolicyData = Rxn<PrivacyPolicyData>();

  @override
  void onInit() {
    super.onInit();

    getPrivacyPolicy();
  }

  /// =========================
  /// GET PRIVACY POLICY API
  /// =========================

  Future<void> getPrivacyPolicy() async {
    isLoading.value = true;

    await DioHelper.builder()
        .setMethod("GET")
        .setUrl(ApiEndpoints.getPrivacyPolicy)
        .execute<PrivacyPolicyModel>(
          fromJson: (json) => PrivacyPolicyModel.fromJson(json),

          onSuccess: (response) {
            privacyPolicyData.value = response.privacyPolicyData;
          },

          onFailure: (message, {code}) {
            AppToast.short(message);
          },
        );

    isLoading.value = false;
  }
}
