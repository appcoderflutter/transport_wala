import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../bindings/auth/login_binding.dart';
import '../bindings/auth/otp_binding.dart';
import '../bindings/auth/register_binding.dart';
import '../bindings/drawer/about_binding.dart';
import '../bindings/drawer/contact_us_binding.dart';
import '../bindings/drawer/driver_binding.dart';
import '../bindings/drawer/kyc_binding.dart';
import '../bindings/drawer/my_profile_binding.dart';
import '../bindings/drawer/privacy_policy_binding.dart';
import '../bindings/drawer/terms_binding.dart';
import '../bindings/home/add_vehicle_binding.dart';
import '../bindings/home/home_binding.dart';
import '../bindings/home/notification_binding.dart';
import '../bindings/home/vehicle_details_binding.dart';
import '../bindings/onboarding/onboarding_binding.dart';
import '../screens/auth/login.dart';
import '../screens/auth/otp.dart';
import '../screens/auth/register.dart';
import '../screens/drawer/about.dart';
import '../screens/drawer/contact_us.dart';
import '../screens/drawer/driver.dart';
import '../screens/drawer/kyc.dart';
import '../screens/drawer/my_profile.dart';
import '../screens/drawer/privacy_policy.dart';
import '../screens/drawer/terms_condition.dart';
import '../screens/home/add_vehicle.dart';
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
  static const myProfilePage = '/my-profile';
  static const termsPage = '/terms-condition';
  static const aboutPage = '/about-us';
  static const driverPage = '/driver';
  static const privacyPolicyPage = '/privacy-policy';
  static const contactUsPage = '/contact-us';
  static const otpPage = '/otp';
  static const addVehiclePage = '/add-vehicle';
  static const kycPage = '/kyc';

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
    _getPage(loginPage, const LoginPage(), binding: LoginBinding(),
    ),
    _getPage(registerPage, const RegisterPage(), binding: RegisterBinding()),
    _getPage(otpPage, const OtpPage(), binding: OtpBinding()),
    _getPage(homePage, const HomePage(), binding: HomeBinding()),
    _getPage(vehicleDetailsPage, const VehicleDetailsPage(), binding: VehicleDetailsBinding()),
    _getPage(notificationPage, const NotificationPage(), binding: NotificationBinding()),
    _getPage(termsPage, const TermsConditionPage(), binding: TermsBinding()),
    _getPage(aboutPage, const AboutUsPage(), binding: AboutBinding()),
    _getPage(driverPage, const DriverPage(), binding: DriverBinding()),
    _getPage(privacyPolicyPage, const PrivacyPolicyPage(), binding: PrivacyPolicyBinding()),
    _getPage(contactUsPage, const ContactUsPage(), binding: ContactUsBinding()),
    _getPage(myProfilePage, const MyProfilePage(), binding: ProfileBinding()),
    _getPage(addVehiclePage, const AddVehiclePage(), binding: AddVehicleBinding()),
    _getPage(kycPage, const KycPage(), binding: KycBinding()),

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
