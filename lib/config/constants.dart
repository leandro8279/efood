class AppConstants._() {
  static const String appName = "eFood";
  static const double appVersion = 9.0;
  static const String configUrl = '/config';
  static const String categoriesUrl = '/categories';
  static const String customerInfoUrl = '/customer/info';
  static const String updateProfileUrl = '/customer/update-profile';
  static const String policyPage = '/policy-page';
  static const String loginUrl = "/auth/login";
  static const String registerUrl = "/auth/registration";
  static const String checkEmailUrl = "/auth/check-email";
  static const String checkPhoneUrl = "/auth/check-phone";
  static const String forgetUrl = "/auth/forgot-password";
  static const String verifyEmailUrl = "/auth/verify-email";
  static const String verifyPhoneUrl = "/auth/verify-phone";

  static const List<Map<Object, String>> languages = [
    {'countryCode': 'US', 'languageCode': 'en'},
    {'countryCode': 'ES', 'languageCode': 'es'},
  ];
}
