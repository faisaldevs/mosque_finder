import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/router/config/route_names.dart';
import 'package:mosque_finder_app/feature/mosques/screens/prayer_times_screen.dart';

class MosqueRouter {
  static List<GoRoute> get routes => [
    GoRoute(
      path: RouteNames.prayerTimes,
      name: RouteNames.prayerTimes.name,
      builder: (_, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final lat = extra?['lat'] as double? ?? 0.0;
        final lng = extra?['lng'] as double? ?? 0.0;
        return PrayerTimesScreen(lat: lat, lng: lng);
      },
    ),
  ];
}
