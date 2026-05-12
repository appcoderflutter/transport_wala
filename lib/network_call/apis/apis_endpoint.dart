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



  ////////////////////////////////// Mall ////////////////////////////////////



  //////////////////////////////// search ///////////////////////////////////


  //////////////////////////////// Agency Search //////////////////////////////


  ///////////////////////////////// Room ///////////////////////////////////


  ////////////////////////////////// Setting  //////////////////////////////

  static final String getTermsConditions = '${baseUrl}getTermsConditions';
  static final String getAboutUs = '${baseUrl}getAboutUs';
  static final String getContactUs = '${baseUrl}getContactUs';
  static final String getPrivacyPolicy = '${baseUrl}getPrivacyPolicy';

}
