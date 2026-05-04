// import 'package:bcs_booster_app/feature/analytics/data/repository/user_activity_heatmap_rx.dart';
// import 'package:bcs_booster_app/feature/analytics/data/repository/user_daily_trends_rx.dart';
// import 'package:bcs_booster_app/feature/analytics/data/repository/user_subject_performance_rx.dart';
// import 'package:bcs_booster_app/feature/analytics/data/repository/user_summary_rx.dart';
// import 'package:bcs_booster_app/feature/analytics/model/user_activity_heatmap_response_model.dart';
// import 'package:bcs_booster_app/feature/analytics/model/user_daily_trends_response_model.dart';
// import 'package:bcs_booster_app/feature/analytics/model/user_subject_performance_response_model.dart';
// import 'package:bcs_booster_app/feature/analytics/model/user_summary_response_model.dart';
// import 'package:bcs_booster_app/feature/auth/data/repository/forgot_pass_otp_rx.dart';
// import 'package:bcs_booster_app/feature/auth/data/repository/forgot_pass_otp_verify_rx.dart';
// import 'package:bcs_booster_app/feature/auth/data/repository/forgot_password_rx.dart';
// import 'package:bcs_booster_app/feature/auth/data/repository/login_rx.dart';
// import 'package:bcs_booster_app/feature/auth/data/repository/mobile_otp_verify_rx.dart';
// import 'package:bcs_booster_app/feature/auth/data/repository/mobile_verify_rx.dart';
// import 'package:bcs_booster_app/feature/auth/data/repository/referral_code_rx.dart';
// import 'package:bcs_booster_app/feature/auth/data/repository/signup_rx.dart';
// import 'package:bcs_booster_app/feature/auth/model/common_response_model.dart';
// import 'package:bcs_booster_app/feature/auth/model/login_response_model.dart';
// import 'package:bcs_booster_app/feature/exam/data/repo/complete_exam_prctice_rx.dart';
// import 'package:bcs_booster_app/feature/exam/data/repo/complete_exam_result_rx.dart';
// import 'package:bcs_booster_app/feature/exam/data/repo/exam_details_rx.dart';
// import 'package:bcs_booster_app/feature/exam/data/repo/exam_eligibility_check_rx.dart';
// import 'package:bcs_booster_app/feature/exam/data/repo/get_exam_ques_rx.dart';
// import 'package:bcs_booster_app/feature/exam/data/repo/interested_exam_rx.dart';
// import 'package:bcs_booster_app/feature/exam/model/common_ques_model.dart';
// import 'package:bcs_booster_app/feature/exam/model/common_review_ques_model.dart';
// import 'package:bcs_booster_app/feature/exam/model/complete_exam_result_res_model.dart';
// import 'package:bcs_booster_app/feature/exam/model/exam_eligibility_check_response_model.dart';
// import 'package:bcs_booster_app/feature/exam/model/get_exam_details_res_model.dart';
// import 'package:bcs_booster_app/feature/exam/model/interested_exam_response_model.dart';
// import 'package:bcs_booster_app/feature/exam/model/quick_exam_result_view_model.dart';
// import 'package:bcs_booster_app/feature/explore/data/repository/check_quick_exam_eligibility_rx.dart';
// import 'package:bcs_booster_app/feature/explore/data/repository/get_improve_list_rx.dart';
// import 'package:bcs_booster_app/feature/explore/data/repository/get_quick_exam_history_rx.dart';
// import 'package:bcs_booster_app/feature/explore/data/repository/get_quick_exam_info_rx.dart';
// import 'package:bcs_booster_app/feature/explore/data/repository/submit_quick_exam_rx.dart';
// import 'package:bcs_booster_app/feature/explore/model/check_quick_exam_eligibility_response_model.dart';
// import 'package:bcs_booster_app/feature/explore/model/get_improve_list_response_model.dart';
// import 'package:bcs_booster_app/feature/explore/model/get_quick_exam_history_response_model.dart';
// import 'package:bcs_booster_app/feature/explore/model/get_quick_exam_info_response_model.dart';
// import 'package:bcs_booster_app/feature/leaderbord/data/repository/campaign_details_rx.dart';
// import 'package:bcs_booster_app/feature/leaderbord/data/repository/current_campaign_rx.dart';
// import 'package:bcs_booster_app/feature/leaderbord/model/campaign_details_response_model.dart';
// import 'package:bcs_booster_app/feature/leaderbord/model/current_campaign_response_model.dart';
// import 'package:bcs_booster_app/feature/profile/data/repository/get_profile_rx.dart';
// import 'package:bcs_booster_app/feature/profile/data/repository/update_pass_rx.dart';
// import 'package:bcs_booster_app/feature/profile/data/repository/upload_profile_rx.dart';
// import 'package:bcs_booster_app/feature/profile/model/get_profile_response_model.dart';
// import 'package:bcs_booster_app/feature/wallet/data/repository/my_wallets_rx.dart';
// import 'package:bcs_booster_app/feature/wallet/model/my_wallets_response_model.dart';
// import 'package:rxdart/rxdart.dart';

// ///============================
// ///**** Authentication ****
// ///============================

// LoginRx loginRxObj = LoginRx(
//   empty: LoginResponseModel(),
//   dataFetcher: BehaviorSubject<LoginResponseModel>(),
// );
// MobileVerifyRx mobileVerifyRxObj = MobileVerifyRx(
//   empty: CommonResponseModel(),
//   dataFetcher: BehaviorSubject<CommonResponseModel>(),
// );
// MobileOtpVerifyRx mobileOtpVerifyRxObj = MobileOtpVerifyRx(
//   empty: CommonResponseModel(),
//   dataFetcher: BehaviorSubject<CommonResponseModel>(),
// );
// SignupRx signupRxObj = SignupRx(
//   empty: CommonResponseModel(),
//   dataFetcher: BehaviorSubject<CommonResponseModel>(),
// );
// ReferralCodeRx referralCodeRxObj = ReferralCodeRx(
//   empty: CommonResponseModel(),
//   dataFetcher: BehaviorSubject<CommonResponseModel>(),
// );

// ForgotPassOtpRx forgotPassOtpRxObj = ForgotPassOtpRx(
//   empty: CommonResponseModel(),
//   dataFetcher: BehaviorSubject<CommonResponseModel>(),
// );
// ForgotPassOtpVerifyRx forgotPassOtpVerifyRxObj = ForgotPassOtpVerifyRx(
//   empty: CommonResponseModel(),
//   dataFetcher: BehaviorSubject<CommonResponseModel>(),
// );
// ForgotPasswordRx forgotPassRxObj = ForgotPasswordRx(
//   empty: CommonResponseModel(),
//   dataFetcher: BehaviorSubject<CommonResponseModel>(),
// );

// ///============================
// ///**** Explore ****
// ///============================

// // GetSubjectListRx getSubjectListRxObj = GetSubjectListRx(
// //   empty: SubjectListResponseModel(),
// //   dataFetcher: BehaviorSubject<SubjectListResponseModel>(),
// // );

// GetQuickExamInfoRx getQuickExamInfoRxObj = GetQuickExamInfoRx(
//   empty: GetQuickExamInfoResponseModel(),
//   dataFetcher: BehaviorSubject<GetQuickExamInfoResponseModel>(),
// );
// GetExamQuesRx getExamQuesRxObj = GetExamQuesRx(
//   empty: CommonQuestionsModel(),
//   dataFetcher: BehaviorSubject<CommonQuestionsModel>(),
// );
// GetQuickExamHistoryRx getQuickExamHistoryRxObj = GetQuickExamHistoryRx(
//   empty: GetQuickExamHistoryResponseModel(),
//   dataFetcher: BehaviorSubject<GetQuickExamHistoryResponseModel>(),
// );
// GetImproveListRx getImproveListRxObj = GetImproveListRx(
//   empty: GetImproveListResponseModel(),
//   dataFetcher: BehaviorSubject<GetImproveListResponseModel>(),
// );
// SubmitQuickExamRx submitQuickExamRxObj = SubmitQuickExamRx(
//   empty: QuickExamResultViewModel(),
//   dataFetcher: BehaviorSubject<QuickExamResultViewModel>(),
// );
// CheckQuickExamEligibilityRx checkQuickExamEligibilityRxObj =
//     CheckQuickExamEligibilityRx(
//   empty: CheckQuickExamEligibilityResponseModel(),
//   dataFetcher: BehaviorSubject<CheckQuickExamEligibilityResponseModel>(),
// );

// // PracticeWrongQuesRx practiceWrongQuesRxObj = PracticeWrongQuesRx(
// //   empty: CommonQuestionsModel(),
// //   dataFetcher: BehaviorSubject<CommonQuestionsModel>(),
// // );

// ///============================
// ///**** Exam List ****
// ///============================

// // GetAllExamRx getAllExamRxObj = GetAllExamRx(
// //   empty: GetAllExamResponseModel(),
// //   dataFetcher: BehaviorSubject<GetAllExamResponseModel>(),
// // );
// ExamDetailsRx getExamDetailsRxObj = ExamDetailsRx(
//   empty: GetExamDetailsResponseModel(),
//   dataFetcher: BehaviorSubject<GetExamDetailsResponseModel>(),
// );
// ExamEligibilityCheckRx examEligibilityCheckRxObj = ExamEligibilityCheckRx(
//   empty: ExamEligibilityCheckResponseModel(),
//   dataFetcher: BehaviorSubject<ExamEligibilityCheckResponseModel>(),
// );

// InterestedExamRx interestedExamRxObj = InterestedExamRx(
//   empty: InterestedExamResponseModel(),
//   dataFetcher: BehaviorSubject<InterestedExamResponseModel>(),
// );
// CompleteExamResultRx completeExamResultRxObj = CompleteExamResultRx(
//   empty: CompleteExamResultResModel(),
//   dataFetcher: BehaviorSubject<CompleteExamResultResModel>(),
// );

// ///============================
// ///**** Leaderboard ****
// ///============================

// CurrentCampaignRx currentCampaignRxObj = CurrentCampaignRx(
//   empty: CurrentCampaignResponseModel(),
//   dataFetcher: BehaviorSubject<CurrentCampaignResponseModel>(),
// );
// CampaignDetailsRx campaignDetailsRxObj = CampaignDetailsRx(
//   empty: CampaignDetailsResponseModel(),
//   dataFetcher: BehaviorSubject<CampaignDetailsResponseModel>(),
// );

// CompleteExamPrcticeRx getCompleteExamPrcticeRxObj = CompleteExamPrcticeRx(
//   empty: CommonReviewQuestionsModel(),
//   dataFetcher: BehaviorSubject<CommonReviewQuestionsModel>(),
// );

// ///============================
// ///**** Profile ****
// ///============================

// GetProfileRx getProfileRxObj = GetProfileRx(
//   empty: GetProfileResponseModel(),
//   dataFetcher: BehaviorSubject<GetProfileResponseModel>(),
// );

// UploadProfileRx uploadProfileRxObj = UploadProfileRx(
//   empty: GetProfileResponseModel(),
//   dataFetcher: BehaviorSubject<GetProfileResponseModel>(),
// );
// UploadPasswordRx uploadPasswordRxObj = UploadPasswordRx(
//   empty: CommonResponseModel(),
//   dataFetcher: BehaviorSubject<CommonResponseModel>(),
// );

// ///============================
// ///**** Wallet ****
// ///============================

// MyWalletsRx myWalletsRxObj = MyWalletsRx(
//   empty: MyWalletsResponseModel(),
//   dataFetcher: BehaviorSubject<MyWalletsResponseModel>(),
// );

// ///============================
// ///**** Analytics ****
// ///============================

// UserSummaryRx userSummaryRxObj = UserSummaryRx(
//   empty: UserSummaryResponseModel(),
//   dataFetcher: BehaviorSubject<UserSummaryResponseModel>(),
// );

// UserDailyTrendsRx userDailyTrendsRxObj = UserDailyTrendsRx(
//   empty: UserDailyTrendsResponseModel(),
//   dataFetcher: BehaviorSubject<UserDailyTrendsResponseModel>(),
// );

// UserSubjectPerformanceRx userSubjectPerformanceRxObj = UserSubjectPerformanceRx(
//   empty: UserSubjectPerformanceResponseModel(),
//   dataFetcher: BehaviorSubject<UserSubjectPerformanceResponseModel>(),
// );

// UserActivityHeatmapRx userActivityHeatmapRxObj = UserActivityHeatmapRx(
//   empty: UserActivityHeatmapResponseModel(),
//   dataFetcher: BehaviorSubject<UserActivityHeatmapResponseModel>(),
// );
