import 'package:get/get.dart';

import '../../helpers/toaster.dart';
import '../../model/profile_model.dart';
import '../../model/user_model.dart';
import '../../network_call/apis/apis_endpoint.dart';
import '../../network_call/dio_helper/dio_helper.dart';

class KycController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<ProfileUser> user = Rxn<ProfileUser>();

  Rxn<KycData> kycData = Rxn<KycData>();

  @override
  void onInit() {
    getProfile();

    super.onInit();
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;

      await DioHelper.builder()
          .setMethod("GET")
          .setUrl(ApiEndpoints.getProfile)
          .execute<ProfileModel>(
            fromJson: (json) => ProfileModel.fromJson(json),

            onSuccess: (response) {
              user.value = response.payload?.user;

              final kycList = response.payload?.user?.kycData ?? [];

              if (kycList.isNotEmpty) {
                kycData.value = kycList.first;
              }
            },

            onFailure: (message, {code}) {
              AppToast.short(message);
            },
          );
    } catch (e) {
      AppToast.short("Failed to load KYC");
    } finally {
      isLoading.value = false;
    }
  }
}
