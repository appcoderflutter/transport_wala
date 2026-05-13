import 'package:get/get.dart';

import '../../prefs/prefs.dart';

class ProfileController extends GetxController {
  /// USER

  final user = Prefs.userRx;

  /// =========================
  /// PROFILE IMAGE
  /// =========================

  bool get hasImage {
    return user.value?.profilePic != null &&
        user.value!.profilePic!.isNotEmpty &&
        user.value!.profilePic != "NA";
  }

  bool get isEmailVerified {

    return user.value
        ?.isEmailVerified == "1";
  }

  bool get isPhoneVerified {

    return user.value
        ?.isPhoneVerified == "1";
  }

  /// =========================
  /// NAME
  /// =========================

  String get name {
    return user.value?.name?.isNotEmpty == true
        ? user.value!.name!
        : "Not Available";
  }

  /// =========================
  /// USER TYPE
  /// =========================

  String get userType {
    return user.value?.userType?.isNotEmpty == true
        ? user.value!.userType!
        : "Not Available";
  }

  /// =========================
  /// EMAIL
  /// =========================

  String get email {
    return user.value?.email?.isNotEmpty == true && user.value!.email != "NA"
        ? user.value!.email!
        : "Not Available";
  }

  /// =========================
  /// PHONE
  /// =========================

  String get phone {
    return user.value?.phone?.isNotEmpty == true
        ? user.value!.phone!
        : "Not Available";
  }
}
