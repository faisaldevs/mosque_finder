import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/router/config/route_names.dart';
import 'package:mosque_finder_app/feature/profile/view/about_us_screen.dart';
import 'package:mosque_finder_app/feature/profile/view/calc_method_screen.dart';
import 'package:mosque_finder_app/feature/profile/view/change_password.dart';
import 'package:mosque_finder_app/feature/profile/view/profile_screen.dart';
import 'package:mosque_finder_app/feature/profile/view/reminder_screen.dart';
import 'package:mosque_finder_app/feature/profile/view/search_radius_screen.dart';
import 'package:mosque_finder_app/feature/profile/view/user_info_profile_screen.dart';

class ProfileRouter {
  static List<GoRoute> get routes => [
    GoRoute(
      path: RouteNames.profile,
      name: RouteNames.profile.name,
      builder: (_, state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: RouteNames.userProfile,
      name: RouteNames.userProfile.name,
      builder: (_, state) {
        return const PersonalInfoPage();
      },
    ),
    GoRoute(
      path: RouteNames.editProfile,
      name: RouteNames.editProfile.name,
      builder: (_, state) {
        return const PersonalInfoPage(); // Same as userProfile
      },
    ),
    GoRoute(
      path: RouteNames.updatePass,
      name: RouteNames.updatePass.name,
      builder: (_, state) {
        return const ChangePasswordPage();
      },
    ),
    GoRoute(
      path: RouteNames.calcMethod, // Add route name
      name: RouteNames.calcMethod.name,
      builder: (_, state) {
        return const CalcMethodPage();
      },
    ),
    GoRoute(
      path: RouteNames.searchRadius, // Add route name
      name: RouteNames.searchRadius.name,
      builder: (_, state) {
        return const SearchRadiusPage();
      },
    ),
    GoRoute(
      path: RouteNames.azanReminders, // Add route name
      name: RouteNames.azanReminders.name,
      builder: (_, state) {
        return const AzanRemindersPage();
      },
    ),
    GoRoute(
      path: RouteNames.aboutUs, // Add route name
      name: RouteNames.aboutUs.name,
      builder: (_, state) {
        return const AboutPage();
      },
    ),
  ];
}
