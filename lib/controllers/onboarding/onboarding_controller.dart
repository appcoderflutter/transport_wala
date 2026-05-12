import 'package:get/get.dart';

import '../../prefs/prefs.dart';
import '../../routes/app_routes.dart';

class OnboardingController
    extends GetxController {

  /// GET STARTED

  void onGetStarted() {

    /// SAVE ONBOARDING

    Prefs.setSeenOnboarding(true);

    /// GO REGISTER

    Get.toNamed(
      AppRoutes.registerPage,
    );
  }

  /// LOGIN

  void onLogin() {

    /// SAVE ONBOARDING

    Prefs.setSeenOnboarding(true);

    /// GO LOGIN

    Get.toNamed(
      AppRoutes.loginPage,
    );
  }
}