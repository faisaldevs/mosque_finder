import 'package:mosque_finder_app/app/di/di.dart';
import 'package:mosque_finder_app/app/router/config/navigation_service.dart';
import 'package:mosque_finder_app/app/router/config/route_names.dart';

final nav = locator<NavigationService>();

extension NavHelpers on NavigationService {
  //======================
  // Common Routes
  //======================

  void goBack() => pop();
  void toLoading() => go(RouteNames.initialLoading);

  //======================
  // Auth Routes
  //======================

  void toLogin() => goNamed(RouteNames.login.name);
  void toSignup() => pushNamed(RouteNames.signup.name);
  // void toSignupOtp() => pushNamed(RouteNames.signupOtp.name);
  // void toSignupNumber({required bool isForgotPass}) => pushNamedWithExtra(
  //   RouteNames.signupNumer.name,
  //   extra: {"isForgotPass": isForgotPass},
  // );
  // void toForgotPassNumberScreen() =>
  //     pushNamed(RouteNames.forgotPassNumber.name);
  // void toForgotPassOtp({required String phone}) => pushNamedWithExtra(
  //   RouteNames.forgotPassOtp.name,
  //   extra: {"phone": phone},
  // );

  void toForgotPassScreen() => pushNamed(RouteNames.forgotPass.name);
  // void toForgotPass({required String phone, required String otp}) =>
  //     pushNamedWithExtra(
  //       RouteNames.forgotPass.name,
  //       extra: {"phone": phone, "otp": otp},
  //     );

  // void toForgotPassSuccess() => pushNamed(RouteNames.forgotPassSuccess.name);
  void toNavigation() => push(RouteNames.feed);
  // void toNavigation() => go(RouteNames.home);

  // //======================
  // // Home Routes
  // //======================

  void toConsultScreen() => push(RouteNames.consult);
  void toEventScreen() => push(RouteNames.events);
  void toDonationScreen() => push(RouteNames.donate);
  void toNotificationScreen() => push(RouteNames.notifications);

  // void toQuickExamHistoryScreen() => push(RouteNames.quickExamHistory);
  // void toQuickExamScreen() => push(RouteNames.quickExam);

  // void toCheckYourCoinScreen({
  //   required int coinRequired,
  //   required int availableCoin,
  //   required bool isEligible,
  //   required String title,
  //   int? examId,
  // }) => pushNamedWithExtra(
  //   RouteNames.checkYourCoin.name,
  //   extra: {
  //     "coinRequired": coinRequired,
  //     "availableCoin": availableCoin,
  //     "isEligible": isEligible,
  //     "title": title,
  //     "examId": examId,
  //   },
  // );

  // void toExamDetailsScreen() => push(RouteNames.examDetails);
  // void toImprovementScreen() => push(RouteNames.improvement);
  // void toSecondChanceScreen() => push(RouteNames.secondChance);
  // void toMyWalletScreen() => push(RouteNames.myWallet);
  // void toReferEarnScreen() => push(RouteNames.referEarn);
  // void toExamPaperScreen({
  //   required dynamic examID,
  //   required CommonQuestionsModel questions,
  // }) => pushNamedWithExtra(
  //   RouteNames.examPaper.name,
  //   extra: {"examID": examID, "questions": questions},
  // );

  // void toReviewExam({
  //   required dynamic examID,
  //   required String? title,
  //   required CommonReviewQuestionsModel questions,
  //   required bool usePagination,
  //   required int subjectId,
  // }) => pushNamedWithExtra(
  //   RouteNames.examReview.name,
  //   extra: {
  //     "examID": examID,
  //     "questions": questions,
  //     "title": title,
  //     "usePagination": usePagination,
  //     "subjectId": subjectId,
  //   },
  // );
  // void toExamResultViewScreen({QuickExamResultViewModel? result}) =>
  //     goNamedWithExtra(RouteNames.examResult.name, extra: {"result": result});
  // void toNotificationScreen() => push(RouteNames.notification);

  //======================
  // Profile Routes
  //======================

  void toUserProfileScreen() => push(RouteNames.userProfile);
  void toEditProfileScreen() => push(RouteNames.editProfile);
  void toUpdatePassScreen() => push(RouteNames.updatePass);
  void toCalcMethodScreen() => push(RouteNames.calcMethod);
  void toSearchRadiusScreen() => push(RouteNames.searchRadius);
  void toAzanRemindersScreen() => push(RouteNames.azanReminders);
  void toAboutScreen() => push(RouteNames.aboutUs);
  void toSettingScreen() => push(RouteNames.settings);

  // //======================
  // // Leaderboard Routes
  // //======================
  // void toLeaderboardCampaginDetailsScreen({required int campaignId}) =>
  //     // push(RouteNames.leaderbordCampaignDetails);
  //     pushNamedWithExtra(
  //       RouteNames.leaderbordCampaignDetails.name,
  //       extra: {"campaignId": campaignId},
  //     );

  // void toCurrentCampainUserPointWidget({required int campaignId}) =>
  //     pushNamedWithExtra(
  //       RouteNames.currentCampainUserPoint.name,
  //       extra: {"campaignId": campaignId},
  //     );

  // //======================
  // // other Routes
  // //======================
  // void toAwardListScreen() => push(RouteNames.awardList);
  // void toStudyMaterialScreen() => push(RouteNames.studyMaterial);
  // void toExamResultScreen() => push(RouteNames.examResultList);
  // void toCompleteExamResultScreen() => push(RouteNames.completeExamResult);
  // void toPackageScreen() => push(RouteNames.packageScreen);
  // void toStoryScreen() => push(RouteNames.storyScreen);
}
