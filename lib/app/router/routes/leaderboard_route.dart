// import 'package:bcs_booster_app/app/router/config/route_names.dart';
// import 'package:bcs_booster_app/feature/leaderbord/presentation/view/current_campain_user_point_widget.dart';
// import 'package:bcs_booster_app/feature/leaderbord/presentation/widgets/current_campaign_details_widget.dart';
// import 'package:go_router/go_router.dart';

// class LeaderboardRoute {
//   static List<GoRoute> get routes => [
//         GoRoute(
//           path: RouteNames.leaderbordCampaignDetails,
//           name: RouteNames.leaderbordCampaignDetails.name,
//           builder: (_, state) {
//             final data = state.extra as Map;
//             return CurrentCampaignDetailsWidget(
//               campaignId: data["campaignId"],
//             );
//           },
//         ),
//         GoRoute(
//           path: RouteNames.currentCampainUserPoint,
//           name: RouteNames.currentCampainUserPoint.name,
//           builder: (_, state) {
//             final data = state.extra as Map;

//             return CurrentCampainUserPointWidget(
//               campaignId: data["campaignId"],
//             );
//           },
//         ),
//       ];
// }
