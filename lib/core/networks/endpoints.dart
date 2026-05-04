// ignore_for_file: constant_identifier_names

const String url = "https://www.baadol.com/api";
// const String imageUrl = "https://backend.bdbeponi.com/";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();

  ///============================
  /// **** AUthentication ****
  ///============================

  static String login() => "/auth/v1/login";
  static String logout() => "/auth/v1/logout";
  static String phoneVerify() => "/auth/v1/register/otp-request";
  static String phoneOtpVerify() => "/auth/v1/register/otp/verify";
  static String signup() => "/auth/v1/register/complete";
  static String checkReferralCode() => "/v1/referral-code/check";
  static String forgotPassOtp() => "/v1/reset/password/otp";
  static String forgotPassOtpVerify() => "/v1/reset/password/otp/verify";
  static String forgotPassword() => "/v1/reset/password";

  ///============================
  /// **** Explore List ****
  ///============================

  static String getSubjectList() => "/auth/v1/subjects/list";
  static String getQuickExamInfo() => "/auth/v1/quick-exam/info";
  static String getExamQues({int? examId}) => examId == null
      ? "/auth/v1/quick-exam/get-questions"
      : "/auth/v1/exam/get-questions";
  static String getQuickExamHistory() => "/auth/v1/quick-exam/history";
  static String submitQuickExam({required int? examId}) =>
      examId == null ? "/auth/v1/quick-exam/submit" : "/auth/v1/exam/submit";
  static String getImproveList() => "/auth/v1/quick-exam/improvement";
  static String getPracticeWrongQues({
    int? page,
    int? perPage,
    int? subjectId,
  }) {
    final queryParams = {
      if (page != null) "page": page.toString(),
      if (perPage != null) "per_page": perPage.toString(),
      if (subjectId != null) "subject_id": subjectId.toString(),
    };

    final queryString =
        queryParams.entries.map((e) => "${e.key}=${e.value}").join("&");

    return "/auth/v1/quick-exam/practise-wrong-answers?$queryString";
  }

  static String checkQuickExamEligibility() =>
      "/auth/v1/quick-exam/check-eligibility";

  // static String () => "/";

  static String getSecondChance({
    int? page,
    int? perPage,
  }) {
    final baseUrl = "/auth/v1/exam/second/chance";

    // Build query parameters
    final params = <String, String>{};

    if (page != null) {
      params['page'] = page.toString();
    }
    if (perPage != null) {
      params['per_page'] = perPage.toString();
    }

    // If no parameters, return base URL
    if (params.isEmpty) {
      return baseUrl;
    }

    // Build URL with query parameters
    final queryString = Uri(queryParameters: params).query;
    return '$baseUrl?$queryString';
  }

  ///============================
  /// **** Exam List ****
  ///============================

  // static String getAllExam() => "/auth/v1/exam/list";
  static String getAllExam({
    String? type,
    int? page,
    int? perPage,
  }) {
    final baseUrl = "/auth/v1/exam/list";

    // Build query parameters
    final params = <String, String>{};
    if (type != null && type.isNotEmpty) {
      params['type'] = type;
    }
    if (page != null) {
      params['page'] = page.toString();
    }
    if (perPage != null) {
      params['per_page'] = perPage.toString();
    }

    // If no parameters, return base URL
    if (params.isEmpty) {
      return baseUrl;
    }

    // Build URL with query parameters
    final queryString = Uri(queryParameters: params).query;
    return '$baseUrl?$queryString';
  }

  static String getExamDetails({required dynamic id}) =>
      "/auth/v1/exam/details/$id";
  static String examEligibilityCheck() => "/auth/v1/exam/check-eligibility";

  static String updateInterestedExam() => "/auth/v1/exam/interested";
  static String getCompleteExamResult({required dynamic id}) =>
      "/auth/v1/exam/result?exam_id=$id";
  // static String getCompleteExamReward({required dynamic id}) =>
  //     "/auth/v1/exam/6/award/winner";
  static String getCompleteExamReward(
          {required dynamic id, int page = 1, int perPage = 10}) =>
      '/auth/v1/exam/$id/award/winner?page=$page&per_page=$perPage';

  static String getCompleteExamResultRank(
          {required dynamic id, int page = 1, int perPage = 20}) =>
      '/auth/v1/exam/$id/rank?page=$page&per_page=$perPage';

  static String getCompleteExamPrctice() =>
      "/auth/v1/exam/review?per_page=1000";

  ///============================
  /// **** Leaderbord ****
  ///============================
  static String getCampaignHistory({required int page, required int perPage}) =>
      "/auth/v1/campaign/expired?page=$page&per_page=$perPage";
  // static String getUserPointHistory(
  //         {required dynamic id, required int page, required int perPage}) =>
  //     "/auth/v1/campaign/user-points/$id?page=$page&per_page=$perPage";
  static String getUserPointHistory(
          {required int id, required int page, required int perPage}) =>
      "/auth/v1/campaign/user-points/$id?page=$page&per_page=$perPage";

  static String getCampaignWinners({
    required int campaignId,
    required int page,
    required int perPage,
  }) =>
      "/auth/v1/campaign/winners/$campaignId?page=$page&per_page=$perPage";

  static String getCurrentCampaign() => "/auth/v1/campaign/ongoing";
  static String getCampaignDetails({required int id}) =>
      "/auth/v1/campaign/details/$id";

  ///============================
  /// **** Profile ****
  ///============================

  static String getProfile() => "/auth/v1/profile";
  static String editProfile() => "/auth/v1/profile/update";
  static String updatePassword() => "/auth/v1/password/update";

  ///============================
  /// **** Notification ****
  ///============================

  static String getNotifications({required int page, required int perPage}) =>
      "/auth/v1/notifications";

  ///============================
  /// **** Award LIst ****
  ///============================

  static String leaderboard(
      {required int page, required int perPage, String? search}) {
    final baseUrl = "/auth/v1/rewards/campaign";
    final params = <String, String>{
      'page': page.toString(),
      'per_page': perPage.toString(),
    };
    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }
    final queryString = Uri(queryParameters: params).query;
    return '$baseUrl?$queryString';
  }

  static String topper(
      {required int page, required int perPage, String? search}) {
    final baseUrl = "/auth/v1/rewards/exam";
    final params = <String, String>{
      'page': page.toString(),
      'per_page': perPage.toString(),
    };
    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }
    final queryString = Uri(queryParameters: params).query;
    return '$baseUrl?$queryString';
  }

  ///============================
  /// **** Wallets ****
  ///============================

  static String myWallets() => "/auth/v1/wallets/summary";
  static String getCoinHistory({required int page, required int perPage}) =>
      "/auth/v1/wallets/coin-history?page=$page&per_page=$perPage";
  static String getCoinRecharge({required int page, required int perPage}) =>
      "/auth/v1/wallets/recharge-history?page=$page&per_page=$perPage";

  static String getReferral({int page = 1, int perPage = 10}) =>
      '/auth/v1/refer?page=$page&per_page=$perPage';

  ///============================
  /// **** Rankings ****
  ///============================

  static String getRankings({int page = 1, int perPage = 10}) =>
      '/auth/v1/rankings?page=$page&per_page=$perPage';

  static String getRankingDetails({required int id}) => '/auth/v1/rankings/$id';

  ///============================
  /// **** Packages ****
  ///============================

  static String getPackages({int page = 1, int perPage = 10}) =>
      '/auth/v1/subscription';

  // static String getRankingDetails({required int id}) => '/auth/v1/rankings/$id';
  ///============================
  /// **** Analytics ****
  ///============================

  static String getUserSummary() => '/auth/v1/performance/summary';
  static String getUserDailyTrends() => '/auth/v1/performance/daily-trend';
  static String getUserSubjectPerformance() => '/auth/v1/performance/subjects';
  static String getUserActivityHeatmap() =>
      '/auth/v1/performance/activity-heatmap';

  ///============================
  /// **** Home ****
  ///============================

  static String getHomeData({int page = 1, int perPage = 10}) =>
      '/auth/v1/home';
  static String getHomePerformanceData({int page = 1, int perPage = 10}) =>
      '/auth/v1/home/performance';
  static String getStories({int page = 1, int perPage = 10}) =>
      '/auth/v1/rewards/proof?page=$page&per_page=$perPage';
  static String sendFMCtoken() => '/auth/v1/device-tokens/register';
  static String deleteFMCtoken() => '/auth/v1/device-tokens/unregister';

  // static String getRankingDetails({required int id}) => '/auth/v1/rankings/$id';
}
