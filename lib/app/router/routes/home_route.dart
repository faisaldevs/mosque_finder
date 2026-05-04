import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/router/config/route_names.dart';
import 'package:mosque_finder_app/feature/consultant/presentation/view/consult_screen.dart';
import 'package:mosque_finder_app/feature/donation/presentation/view/donation_screen.dart';
import 'package:mosque_finder_app/feature/event/presentation/view/event_screen.dart';
import 'package:mosque_finder_app/feature/notification/presentation/notification_screen.dart';

class HomeRouter {
  static List<GoRoute> get routes => [
    GoRoute(
      path: RouteNames.consult,
      name: RouteNames.consult.name,
      builder: (_, state) {
        return ConsultScreen();
      },
    ),
    GoRoute(
      path: RouteNames.events,
      name: RouteNames.events.name,
      builder: (_, state) {
        return EventsScreen();
      },
    ),
    GoRoute(
      path: RouteNames.donate,
      name: RouteNames.donate.name,
      builder: (_, state) {
        return DonateScreen();
      },
    ),
    GoRoute(
      path: RouteNames.notifications,
      name: RouteNames.notifications.name,
      builder: (_, state) {
        return NotificationScreen();
      },
    ),
  ];
}
