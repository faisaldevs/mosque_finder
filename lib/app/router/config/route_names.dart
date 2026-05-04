class RouteNames {
  static const String initialLoading = "/";

  //======================
  // Auth Routes
  //======================

  static const String login = "/login";
  static const String signup = "/signup";
  static const String signupOtp = "/signup_otp";
  static const String signupNumer = "/signup_number";
  static const String forgotPassNumber = "/forgot_pass_number";
  static const String forgotPassOtp = "/forgot_pass_otp";
  static const String forgotPass = "/forgot_pass";
  static const String forgotPassSuccess = "/forgot_pass_success";

  //======================
  // Home Routes
  //======================
  static const String home = "/home";

  static const String notifications = "/notifications";
  static const String consult = "/consult";
  static const String events = "/events";
  static const String donate = "/donate";
  //======================
  // Exam Routes
  //======================
  static const String mosque = "/mosque";
  static const String prayerTimes = "/prayer-times";

  //======================
  // Feed Routes
  //======================
  static const String feed = "/feed";

  //======================
  // Profile Routes
  //======================
  static const String profile = "/profile";
  static const String userProfile = "/user_profile";
  static const String editProfile = "/edit_profile";
  static const String updatePass = "/update_password";
  static const String azanReminders = "/azan_reminders";
  static const String aboutUs = "/about_us";
  static const String searchRadius = "/search_radius";
  static const String calcMethod = "/calc_method";
}

extension AppRoutesName on String {
  /// Returns the route name by removing the leading "/" if present
  String get name => startsWith("/") ? substring(1) : this;
}
