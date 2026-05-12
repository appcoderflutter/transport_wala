
import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

import '../model/user_model.dart';
import '../utility/const.dart';

class Prefs {
  const Prefs._();

  static GetStorage _store() => GetStorage(Consts.storageName);

  // Keys
  static const String _userData = 'userData';
  static const String _token = 'token';
  static const String _isLogin = 'isLogin';
  static const String _isLoginProvider = 'isLoginProvider';
  static const String _seenOnboarding = 'seenOnboarding';


  // ------------------ REACTIVE USER ------------------
  static Rx<UserModel?> userRx = Rx<UserModel?>(getUserData());

  // ------------------ INIT LISTENERS ------------------
  // Call this in main() after GetStorage.init()
  static void initListeners() {
    // Listen user data changes internally
    _store().listenKey(_userData, (value) {
      if (value == null) {
        userRx.value = null;
      } else {
        userRx.value = UserModel.fromJson(jsonDecode(value));
      }
    });
  }

  /// ------------------ ONBOARDING --------------------

  static void setSeenOnboarding(
      bool value) {

    _store().write(
      _seenOnboarding,
      value,
    );
  }

  static bool getSeenOnboarding() {

    return _store().read(
        _seenOnboarding) ?? false;
  }

  // ------------------ USER DATA ----------------------

  static void setUserData(UserModel user) {
    final data = jsonEncode(user.toJson());
    print('💾 Saving User: $data');
    _store().write(_userData, data);
    userRx.value = user;
  }

  static UserModel? getUserData() {
    final data = _store().read(_userData);
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  // ------------------ TOKEN --------------------------

  static void setToken(String token) => _store().write(_token, token);

  static String? getToken() => _store().read(_token);

  // ------------------ LOGIN STATE --------------------

  static void setIsLogin(bool value) => _store().write(_isLogin, value);

  static bool getIsLogin() => _store().read(_isLogin) ?? false;

  // ------------------ LOGIN PROVIDER STATE ----------

  static void setIsLoginProvider(String value) {
    _store().write(_isLoginProvider, value);
  }

  static String getIsLoginProvider() {
    return _store().read(_isLoginProvider) ?? '';
  }

  // ------------------ LOGOUT / CLEAR -----------------

  static void clearAll() {
    _store().remove(_userData);
    _store().remove(_token);
    _store().remove(_isLogin);
    _store().remove(_isLoginProvider);
  }
}
