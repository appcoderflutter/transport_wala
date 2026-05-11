import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class OnboardingController extends GetxController {

  /// GET STARTED
  void onGetStarted() async {

    /// GO TO REGISTER
    Get.toNamed(AppRoutes.registerPage);
  }

  /// LOGIN
  void onLogin() async {

    /// GO TO LOGIN
    // Get.toNamed(AppRoutes.loginPage);
  }
}