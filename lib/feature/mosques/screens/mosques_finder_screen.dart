import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mosque_finder_app/feature/mosques/widgets/app_drawer.dart';

import '../../models/mosque.dart';
import '../services/location_service.dart';
import '../services/overpass_service.dart';
import '../services/prayer_service.dart';
import 'detail_screen.dart';

class MosquesFinderScreen extends StatefulWidget {
  const MosquesFinderScreen({super.key});

  @override
  State<MosquesFinderScreen> createState() => _MosquesFinderScreenState();
}

class _MosquesFinderScreenState extends State<MosquesFinderScreen>
    with TickerProviderStateMixin {
  Position? _userPosition;
  List<Mosque> _mosques = [];
  bool _loading = true;
  String? _error;
  Mosque? _selectedMosque;
  final MapController _mapController = MapController();
  final bool _mapReady = false;
  LatLng initialCenter = const LatLng(23.8103, 90.4125); // Default: Dhaka
  int _bottomNavIndex = 0; // 0=map, 1=list

  // Prayer times banner state
  String _nextPrayerLabel = '';
  String _nextPrayerTime = '';
  // Drawer state
  int _searchRadius = 3;
  final int _savedCount = 0;
  final String _userCity = 'Dhaka, Bangladesh';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final pos = await LocationService.getCurrentPosition();
    if (pos == null) {
      setState(() {
        _error =
            'Location permission denied.\nPlease enable location in settings.';
        _loading = false;
      });
      return;
    }

    // setState(() { _userPosition = pos; });

    setState(() {
      _userPosition = pos;
      initialCenter = LatLng(pos.latitude, pos.longitude);
    });

    // Load prayer times for user location
    final times = PrayerTimesService.getPrayerTimes(
      pos.latitude,
      pos.longitude,
    );

    final next = PrayerTimesService.getNextPrayer(times);

    setState(() {
      _nextPrayerLabel = PrayerTimesService.prayerName(next);
      _nextPrayerTime = PrayerTimesService.formatTime(
        times.timeForPrayer(next),
      );
    });

    // Fetch mosques
    final mosques = await OverpassService.fetchNearbyMosques(
      lat: pos.latitude,
      lng: pos.longitude,
      radiusMeters: 5000,
    );

    // Calculate distances and sort
    for (final m in mosques) {
      m.distanceMeters = LocationService.distanceBetween(
        pos.latitude,
        pos.longitude,
        m.lat,
        m.lng,
      );
    }
    mosques.sort(
      (a, b) =>
          (a.distanceMeters ?? 9999999).compareTo(b.distanceMeters ?? 9999999),
    );

    setState(() {
      _mosques = mosques;
      _loading = false;
    });

    // Fly to user location
    // if (mounted) {
    //   _mapController.move(LatLng(pos.latitude, pos.longitude), 14.0);
    // }
    if (mounted && _mapReady) {
      _mapController.move(LatLng(pos.latitude, pos.longitude), 14.0);
    }
  }

  // void _onMosqueTap(Mosque mosque) {
  //   setState(() => _selectedMosque = mosque);
  //   _mapController.move(LatLng(mosque.lat, mosque.lng), 16.0);
  //   _showMosqueSheet(mosque);
  // }
  void _onMosqueTap(Mosque mosque) {
    setState(() => _selectedMosque = mosque);
    if (_mapReady) {
      _mapController.move(LatLng(mosque.lat, mosque.lng), 16.0);
    }
    _showMosqueSheet(mosque);
  }

  void _showMosqueSheet(Mosque mosque) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _MosqueBottomSheet(
        mosque: mosque,
        userLat: _userPosition?.latitude ?? 0,
        userLng: _userPosition?.longitude ?? 0,
        onViewDetail: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(
                mosque: mosque,
                userLat: _userPosition?.latitude ?? 0,
                userLng: _userPosition?.longitude ?? 0,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          if (_loading)
            const Center(
              child: CircularProgressIndicator(color: Color(0xFF1B5E20)),
            )
          else if (_error != null)
            _buildError()
          else
            _bottomNavIndex == 0 ? _buildMapView() : _buildListView(),

          // Top header
          _buildHeader(),

          // Bottom nav
          // Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),

      // drawer: DrawerScreen(),
      key: _scaffoldKey,
      // backgroundColor: const Color(0xFFF5F5F5),
      drawer: AppDrawer(
        userLat: _userPosition?.latitude,
        userLng: _userPosition?.longitude,
        userCity: _userCity,
        savedCount: _savedCount,
        nextPrayerLabel: _nextPrayerLabel,
        nextPrayerTime: _nextPrayerTime,
        searchRadius: _searchRadius,
        onRadiusChanged: (val) {
          setState(() => _searchRadius = val);
          _init(); // re-fetch with new radius
        },
      ),

      floatingActionButton: _bottomNavIndex == 0 && !_loading && _error == null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 72),
              child: FloatingActionButton.small(
                backgroundColor: const Color(0xFF1B5E20),
                onPressed: _init,
                child: const Icon(Icons.my_location, color: Colors.white),
              ),
            )
          : null,
    );
  }

  String getPlaceEmoji(Mosque place) {
    return place.isEidgah ? '🌿' : '🕌';
  }

  Color getPlaceColor(Mosque place) {
    return place.isEidgah
        ? const Color(0xFF2E7D32) // green for Eidgah
        : const Color(0xFF1B5E20); // mosque green
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () => Scaffold.of(
                          context,
                        ).openDrawer(), //  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                        child: Icon(Icons.menu, color: const Color(0xFF1B5E20)),
                      );
                    },
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Row(
                      children: [
                        const Text('🕌', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Mosques Nearby',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                        ),
                        if (!_loading && _mosques.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_mosques.length} found',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF1B5E20),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Prayer time banner
            if (_nextPrayerLabel.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B5E20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.white70,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Next prayer: $_nextPrayerLabel',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    // const Spacer(),
                    const SizedBox(width: 12),
                    Text(
                      _nextPrayerTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMapView() {
    final userLatLng = _userPosition != null
        ? LatLng(_userPosition!.latitude, _userPosition!.longitude)
        : const LatLng(23.8103, 90.4125); // Default: Dhaka

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: userLatLng,
        initialZoom: 14.0,
        onTap: (_, __) => setState(() => _selectedMosque = null),
      ),
      children: [
        // OpenStreetMap tile layer — completely free, no API key
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.mosque_finder',
          maxZoom: 19,
        ),
        // Mosque markers
        MarkerLayer(
          markers: _mosques.map((mosque) {
            final isSelected = _selectedMosque?.id == mosque.id;
            return Marker(
              point: LatLng(mosque.lat, mosque.lng),
              width: isSelected ? 48 : 36,
              height: isSelected ? 48 : 36,
              child: GestureDetector(
                onTap: () => _onMosqueTap(mosque),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1B5E20) : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1B5E20),
                      width: isSelected ? 3 : 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: isSelected ? 8 : 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    // child: Text(
                    //   '🕌',
                    //   style: TextStyle(fontSize: isSelected ? 22 : 16),
                    // ),
                    child: Text(
                      getPlaceEmoji(mosque),
                      style: TextStyle(fontSize: isSelected ? 22 : 16),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        // User location marker
        if (_userPosition != null)
          MarkerLayer(
            markers: [
              Marker(
                point: userLatLng,
                width: 20,
                height: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1565C0),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1565C0).withValues(alpha: 0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildListView() {
    if (_mosques.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🕌', style: TextStyle(fontSize: 48)),
            SizedBox(height: 12),
            Text(
              'No mosques found nearby',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              'Try increasing the search radius',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 140,
        bottom: 80,
        left: 16,
        right: 16,
      ),
      itemCount: _mosques.length,
      itemBuilder: (_, i) => _MosqueListTile(
        mosque: _mosques[i],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(
              mosque: _mosques[i],
              userLat: _userPosition?.latitude ?? 0,
              userLng: _userPosition?.longitude ?? 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _init,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5E20),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _NavItem(
              icon: Icons.map_outlined,
              activeIcon: Icons.map,
              label: 'Map',
              selected: _bottomNavIndex == 0,
              onTap: () => setState(() => _bottomNavIndex = 0),
            ),
            _NavItem(
              icon: Icons.format_list_bulleted,
              activeIcon: Icons.format_list_bulleted,
              label: 'List',
              selected: _bottomNavIndex == 1,
              onTap: () => setState(() => _bottomNavIndex = 1),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Reusable widgets ────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon, activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? activeIcon : icon,
                color: selected ? const Color(0xFF1B5E20) : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: selected ? const Color(0xFF1B5E20) : Colors.grey,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MosqueListTile extends StatelessWidget {
  final Mosque mosque;
  final VoidCallback onTap;
  const _MosqueListTile({required this.mosque, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('🕌', style: TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mosque.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (mosque.address != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      mosque.address!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  mosque.distanceText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                const SizedBox(height: 2),
                const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MosqueBottomSheet extends StatelessWidget {
  final Mosque mosque;
  final double userLat, userLng;
  final VoidCallback onViewDetail;
  const _MosqueBottomSheet({
    required this.mosque,
    required this.userLat,
    required this.userLng,
    required this.onViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text('🕌', style: TextStyle(fontSize: 26)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mosque.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (mosque.address != null)
                      Text(
                        mosque.address!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    Text(
                      mosque.distanceText,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1B5E20),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onViewDetail,
              icon: const Icon(Icons.info_outline, size: 18),
              label: const Text('View Details & Prayer Times'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5E20),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
