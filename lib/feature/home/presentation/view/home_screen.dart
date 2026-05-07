import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:mosque_finder_app/app/router/config/route_names.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/home/presentation/widgets/banner_widget.dart';
import 'package:mosque_finder_app/feature/home/presentation/widgets/other_services.dart';
import 'package:mosque_finder_app/feature/mosques/services/location_service.dart';
import 'package:mosque_finder_app/feature/mosques/services/prayer_service.dart';

// ═════════════════════════════════════════════════════════════════════════════
// HOME SCREEN
// ═════════════════════════════════════════════════════════════════════════════

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PrayerTimes _prayerTimes;
  late List<Map<String, String>> _prayers;
  late String _nextPrayerName;
  bool _isLoading = true;
  String? _errorMessage;
  double? _latitude;
  double? _longitude;
  // Quick actions data
  static const _actions = [
    _ActionItem(
      icon: Icons.location_on_rounded,
      label: 'Mosques',
      color: Color(0xFF39A79F),
    ),
    _ActionItem(
      icon: Icons.menu_book_rounded,
      label: 'Education',
      color: Color(0xFF5B8DD9),
    ),
    _ActionItem(
      icon: Icons.favorite_rounded,
      label: 'Donate',
      color: Color(0xFFD47E8B),
    ),
    _ActionItem(
      icon: Icons.shopping_bag_rounded,
      label: 'Market',
      color: Color(0xFF8B78CC),
    ),
    _ActionItem(
      icon: Icons.event_rounded,
      label: 'Events',
      color: Color(0xFFE8975A),
    ),
    _ActionItem(
      icon: Icons.chat_bubble_rounded,
      label: 'Consult',
      color: Color(0xFF52BDB5),
    ),
    _ActionItem(
      icon: Icons.group_rounded,
      label: 'Friends',
      color: Color(0xFF7BA88A),
    ),
    _ActionItem(
      icon: Icons.flight_rounded,
      label: 'Hajj',
      color: Color(0xFF39A79F),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchPrayerData();
  }

  Future<void> _fetchPrayerData() async {
    try {
      final position = await LocationService.getCurrentPosition();
      if (position != null && mounted) {
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
          _prayerTimes = PrayerTimesService.getPrayerTimes(
            position.latitude,
            position.longitude,
          );
          _prayers = PrayerTimesService.getPrayerList(_prayerTimes);
          _nextPrayerName = PrayerTimesService.prayerName(
            PrayerTimesService.getNextPrayer(_prayerTimes),
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Unable to fetch prayer times';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildPrayerCard(),
            const SizedBox(height: 28),
            _buildQuickActions(),
            const SizedBox(height: 24),
            RamadanBannerCard(),
            const SizedBox(height: 28),
            BookServicesCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      // bottomNavigationBar: _buildNavBar(),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return ClipRect(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 10,
              20,
              28,
            ),
            color: AppColors.kPrimary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'As-Salamu Alaykum',
                            style: TextStyle(
                              color: AppColors.kTextWhite,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Monday, April 28, 2026 · 29 Shawwal 1447',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.78),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Notification bell
                    InkWell(
                      onTap: () {
                        nav.toNotificationScreen();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: AppColors.kWhite,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Decorative circles (consistent with auth screens)
          Positioned.fill(
            child: IgnorePointer(
              child: Stack(
                children: [
                  Positioned(top: -35, right: -35, child: _decorCircle(160)),
                  Positioned(top: 18, right: 55, child: _decorCircle(95)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decorCircle(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );

  // ── Prayer Times Card ──────────────────────────────────────────────────────

  Widget _buildPrayerCard() {
    if (_isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            // color: AppColors.kGreenLight,
            // borderRadius: BorderRadius.circular(16),
            // border: Border.all(color: AppColors.kBorder),
          ),
          height: 200,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.kCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorder),
          ),
          padding: const EdgeInsets.all(20),
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (_latitude != null && _longitude != null) {
          context.push(
            RouteNames.prayerTimes,
            extra: {'lat': _latitude, 'lng': _longitude},
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.kTextWhite.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
            // border: Border.all(color: AppColors.kBorder),
            boxShadow: [
              BoxShadow(
                color: AppColors.kTextBlack.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: AppColors.kTextBlack.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(-0, -6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Text(
                  'Prayer Times',
                  style: TextStyle(
                    color: AppColors.kPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Current prayer highlight
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.kPrimary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.kPrimary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.kGreenLight,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$_nextPrayerName (Next)',
                      style: const TextStyle(
                        color: AppColors.kText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _getNextPrayerTime(),
                      style: const TextStyle(
                        color: AppColors.kGreenLight,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Next prayers row
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Row(
                  children: [
                    _nextPrayer(
                      _getNextTwoPrayers()[0]['name']!,
                      _getNextTwoPrayers()[0]['time']!,
                    ),
                    const SizedBox(width: 6),
                    Container(width: 1, height: 14, color: AppColors.kBorder),
                    const SizedBox(width: 6),
                    _nextPrayer(
                      _getNextTwoPrayers()[1]['name']!,
                      _getNextTwoPrayers()[1]['time']!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getNextPrayerTime() {
    final next = PrayerTimesService.getNextPrayer(_prayerTimes);
    switch (next) {
      case Prayer.fajr:
        return PrayerTimesService.formatTime(_prayerTimes.fajr);
      case Prayer.sunrise:
        return PrayerTimesService.formatTime(_prayerTimes.sunrise);
      case Prayer.dhuhr:
        return PrayerTimesService.formatTime(_prayerTimes.dhuhr);
      case Prayer.asr:
        return PrayerTimesService.formatTime(_prayerTimes.asr);
      case Prayer.maghrib:
        return PrayerTimesService.formatTime(_prayerTimes.maghrib);
      case Prayer.isha:
        return PrayerTimesService.formatTime(_prayerTimes.isha);
      default:
        return '--:--';
    }
  }

  List<Map<String, String>> _getNextTwoPrayers() {
    final nextIndex = _prayers.indexWhere((p) => p['name'] == _nextPrayerName);
    if (nextIndex == -1) {
      return [
        {'name': '--', 'time': '--:--'},
        {'name': '--', 'time': '--:--'},
      ];
    }

    final next = _prayers[nextIndex];
    final nextNext = nextIndex + 1 < _prayers.length
        ? _prayers[nextIndex + 1]
        : {'name': 'Fajr (Tomorrow)', 'time': '--:--'};

    return [next, nextNext];
  }

  Widget _nextPrayer(String name, String time) => Row(
    children: [
      Text(
        name,
        style: const TextStyle(color: AppColors.kSubText, fontSize: 13),
      ),
      const SizedBox(width: 6),
      Text(
        time,
        style: const TextStyle(
          color: AppColors.kPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );

  // ── Quick Actions ──────────────────────────────────────────────────────────

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Quick Actions',
            style: TextStyle(
              color: AppColors.kText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _actions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (_, i) => _buildActionTile(_actions[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile(_ActionItem item) {
    return GestureDetector(
      onTap: () {
        if (item.label == 'Consult') {
          nav.toConsultScreen();
        } else if (item.label == 'Events') {
          nav.toEventScreen();
        } else if (item.label == 'Donate') {
          nav.toDonationScreen();
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${item.label} tapped!')));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: item.color.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(item.icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 7),
          Text(
            item.label,
            style: const TextStyle(
              color: AppColors.kText,
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Data models ──────────────────────────────────────────────────────────────

class _ActionItem {
  final IconData icon;
  final String label;
  final Color color;
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
  });
}
