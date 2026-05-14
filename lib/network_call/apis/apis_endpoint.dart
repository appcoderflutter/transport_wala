class ApiEndpoints {
  static String get baseUrl =>
      'https://intelligentappsolutionsdemo.com/current-project/website/TransportApp/public/api/';

  ///////////////////////////////// Auth ///////////////////////////////////
  static final String registerSendOtp = '${baseUrl}auth/registerSendOTP';
  static final String register = '${baseUrl}auth/register';
  static final String login = '${baseUrl}auth/login';
  static final String loginSendOTP = '${baseUrl}auth/loginSendOTP';
  static final String getProfile = '${baseUrl}getProfile';
  static final String logout = '${baseUrl}auth/logout';


  ///////////////////////////////// Profile ///////////////////////////////////



  ////////////////////////////////// Home ////////////////////////////////////
  static final String getNotificationList = '${baseUrl}getNotificationList';
  static final String getNotificationCount = '${baseUrl}getNotificationCount';
  static String getVehicleList(int page) => '${baseUrl}getVehicleList?flag=GEN&page=$page';
  static final String getRouteList = '${baseUrl}getRouteList';
  static final String MaxCapacityList = '${baseUrl}MaxCapacityList';
  static final String saveVehicle = '${baseUrl}saveVehicle';


  //////////////////////////////// search ///////////////////////////////////


  //////////////////////////////// Agency Search //////////////////////////////


  ///////////////////////////////// Room ///////////////////////////////////


  ////////////////////////////////// Setting  //////////////////////////////
  static final String getTermsConditions = '${baseUrl}getTermsConditions';
  static final String getAboutUs = '${baseUrl}getAboutUs';
  static final String getContactUs = '${baseUrl}getContactUs';
  static final String getPrivacyPolicy = '${baseUrl}getPrivacyPolicy';

}
