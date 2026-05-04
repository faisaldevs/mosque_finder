import 'package:flutter/material.dart';

import '../screens/prayer_times_screen.dart';
import '../screens/saved_mosques_screen.dart';

class AppDrawer extends StatefulWidget {
  final double? userLat;
  final double? userLng;
  final String userCity;
  final int savedCount;
  final String nextPrayerLabel;
  final String nextPrayerTime;
  final int searchRadius;
  final ValueChanged<int> onRadiusChanged;

  const AppDrawer({
    super.key,
    this.userLat,
    this.userLng,
    required this.userCity,
    required this.savedCount,
    required this.nextPrayerLabel,
    required this.nextPrayerTime,
    required this.searchRadius,
    required this.onRadiusChanged,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late int _radius;

  @override
  void initState() {
    super.initState();
    _radius = widget.searchRadius;
  }

  void _navigate(Widget screen) {
    Navigator.pop(context); // close drawer
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final hasLocation = widget.userLat != null && widget.userLng != null;

    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // ── Header ────────────────────────────────────────
          _DrawerHeader(
            city: widget.userCity,
            nextPrayerLabel: widget.nextPrayerLabel,
            nextPrayerTime: widget.nextPrayerTime,
            onPrayerTap: hasLocation
                ? () => _navigate(
                    PrayerTimesScreen(
                      lat: widget.userLat!,
                      lng: widget.userLng!,
                    ),
                  )
                : null,
          ),

          // ── Menu items ────────────────────────────────────
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _SectionLabel('Explore'),

                _DrawerItem(
                  icon: Icons.map_outlined,
                  label: 'Nearby mosques',
                  onTap: () => Navigator.pop(context),
                ),

                _DrawerItem(
                  icon: Icons.access_time_rounded,
                  label: 'Prayer times',
                  onTap: hasLocation
                      ? () => _navigate(
                          PrayerTimesScreen(
                            lat: widget.userLat!,
                            lng: widget.userLng!,
                          ),
                        )
                      : null,
                ),

                const Divider(height: 1, thickness: 0.5),
                _SectionLabel('My Places'),

                _DrawerItem(
                  icon: Icons.bookmark_outline,
                  label: 'Saved mosques',
                  badge: widget.savedCount > 0 ? '${widget.savedCount}' : null,
                  onTap: () => _navigate(
                    SavedMosquesScreen(
                      userLat: widget.userLat ?? 0,
                      userLng: widget.userLng ?? 0,
                    ),
                  ),
                ),

                const Divider(height: 1, thickness: 0.5),
                _SectionLabel('Settings'),

                // Search radius tile with inline slider
                _RadiusTile(
                  radius: _radius,
                  onChanged: (val) {
                    setState(() => _radius = val);
                    widget.onRadiusChanged(val);
                  },
                ),

                _DrawerItem(
                  icon: Icons.calculate_outlined,
                  label: 'Calculation method',
                  trailing: const Text(
                    'Karachi',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Calculation method: Hanafi / Karachi (standard for BD)',
                        ),
                      ),
                    );
                  },
                ),

                const Divider(height: 1, thickness: 0.5),

                _DrawerItem(
                  icon: Icons.info_outline,
                  label: 'About',
                  onTap: () {
                    Navigator.pop(context);
                    showAboutDialog(
                      context: context,
                      applicationName: 'Mosque Finder',
                      applicationVersion: '1.0.0',
                      applicationLegalese:
                          'Map data © OpenStreetMap contributors\nPrayer times via Adhan library\n100% free, no API key required.',
                    );
                  },
                ),
              ],
            ),
          ),

          // ── Footer ────────────────────────────────────────
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Mosque Finder v1.0 · OpenStreetMap',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  final String city;
  final String nextPrayerLabel;
  final String nextPrayerTime;
  final VoidCallback? onPrayerTap;

  const _DrawerHeader({
    required this.city,
    required this.nextPrayerLabel,
    required this.nextPrayerTime,
    this.onPrayerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1B5E20),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App icon circle
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Text('🕌', style: TextStyle(fontSize: 26)),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Mosque Finder',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.location_on, size: 13, color: Colors.white60),
              const SizedBox(width: 3),
              Text(
                city,
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
          // Next prayer banner
          if (nextPrayerLabel.isNotEmpty) ...[
            const SizedBox(height: 14),
            GestureDetector(
              onTap: onPrayerTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Next prayer',
                          style: TextStyle(color: Colors.white60, fontSize: 11),
                        ),
                        Text(
                          nextPrayerLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      nextPrayerTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (onPrayerTap != null) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Colors.white60,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    this.badge,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Icon(
        icon,
        size: 22,
        color: onTap != null ? const Color(0xFF3B6D11) : Colors.grey,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: onTap != null ? const Color(0xFF1a1a1a) : Colors.grey,
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF1B5E20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : trailing,
      onTap: onTap,
    );
  }
}

class _RadiusTile extends StatelessWidget {
  final int radius;
  final ValueChanged<int> onChanged;

  const _RadiusTile({required this.radius, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Row(
            children: [
              const Icon(Icons.radar, size: 22, color: Color(0xFF3B6D11)),
              const SizedBox(width: 16),
              const Text('Search radius', style: TextStyle(fontSize: 14)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$radius km',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Slider(
          value: radius.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: const Color(0xFF1B5E20),
          inactiveColor: const Color(0xFFE8F5E9),
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }
}
