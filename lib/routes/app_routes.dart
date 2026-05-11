import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../bindings/auth/register_binding.dart';
import '../bindings/drawer/about_binding.dart';
import '../bindings/drawer/driver_binding.dart';
import '../bindings/drawer/terms_binding.dart';
import '../bindings/home/home_binding.dart';
import '../bindings/home/notification_binding.dart';
import '../bindings/home/vehicle_details_binding.dart';
import '../bindings/onboarding/onboarding_binding.dart';
import '../screens/auth/register.dart';
import '../screens/drawer/about.dart';
import '../screens/drawer/driver.dart';
import '../screens/drawer/terms_condition.dart';
import '../screens/home/home.dart';
import '../screens/home/notification.dart';
import '../screens/home/vehicle_details.dart';
import '../screens/onboarding/onboarding.dart';
import '../screens/splash/splash.dart';

class AppRoutes {
  const AppRoutes._();

  static const splash = '/';

  // auth
  static const loginPage = '/login';
  static const onboarding = '/onboarding';
  static const registerPage = '/register';
  static const homePage = '/home';
  static const vehicleDetailsPage = '/vehicle-details';
  static const notificationPage = '/notification';
  static const termsPage = '/terms-condition';
  static const aboutPage = '/about-us';
  static const driverPage = '/driver';
  static const otpPage = '/otp';

  static GetPage _getPage(
      String name,
      Widget page, {
        Bindings? binding,
        Object? args,
      }) =>
      GetPage(name: name, page: () => page, binding: binding, arguments: args);
  static List<GetPage> routes = [
    _getPage(splash, const SplashPage()),
    _getPage(onboarding, const OnboardingPage(), binding: OnboardingBinding()),
    _getPage(registerPage, const RegisterPage(), binding: RegisterBinding()),
    _getPage(homePage, const HomePage(), binding: HomeBinding()),
    _getPage(vehicleDetailsPage, const VehicleDetailsPage(), binding: VehicleDetailsBinding()),
    _getPage(notificationPage, const NotificationPage(), binding: NotificationBinding()),
    _getPage(termsPage, const TermsConditionPage(), binding: TermsBinding()),
    _getPage(aboutPage, const AboutUsPage(), binding: AboutBinding()),
    _getPage(driverPage, const DriverPage(), binding: DriverBinding()),


  ];
}

// Get.toNamed()	➜ Push page (Back works ✅)
// Get.offNamed()	➜ Replace current page (Back ❌)
// Get.offAllNamed()	➜ Clear all pages (Back ❌❌)
// Route is removed (Get.back(), Get.off(), Get.offAll())
// | Scenario      | Use                 |
// | ------------- | ------------------- |
// | Back button   | `Get.back()`        |
// | Open new page | `Get.to()`          |
// | Replace page  | `Get.off()`         |
// | Clear history | `Get.offAll()`      |
// | Logout        | `Get.offAll(Login)` |
// | Login success | `Get.offAll(Home)`  |
// | Method               | Stack Behavior                      | Back Button                    |
// | -------------------- | ----------------------------------- | ------------------------------ |
// | `Get.to(Page())`     | Pushes a new page on top            | `Get.back()` works             |
// | `Get.off(Page())`    | Replaces current page               | `Get.back()` **does NOT work** |
// | `Get.offAll(Page())` | Clears entire stack and pushes page | `Get.back()` **does NOT work** |
