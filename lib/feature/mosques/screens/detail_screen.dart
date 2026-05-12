import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/mosque.dart';
import '../services/prayer_service.dart';

class DetailScreen extends StatelessWidget {
  final Mosque mosque;
  final double userLat, userLng;

  const DetailScreen({
    super.key,
    required this.mosque,
    required this.userLat,
    required this.userLng,
  });

  Future<void> _openDirections() async {
    // Opens in whatever maps app user has (Google Maps, OSMAnd, etc.)
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=$userLat,$userLng'
      '&destination=${mosque.lat},${mosque.lng}'
      '&travelmode=walking',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openOsmDirections() async {
    // OpenStreetMap directions fallback
    final url = Uri.parse(
      'https://www.openstreetmap.org/directions'
      '?from=$userLat,$userLng'
      '&to=${mosque.lat},${mosque.lng}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prayerTimes = PrayerTimesService.getPrayerTimes(
      mosque.lat,
      mosque.lng,
    );
    final prayers = PrayerTimesService.getPrayerList(prayerTimes);
    final nextPrayer = PrayerTimesService.getNextPrayer(prayerTimes);
    final nextPrayerName = PrayerTimesService.prayerName(nextPrayer);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // Map app bar
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF1B5E20),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(mosque.lat, mosque.lng),
                  initialZoom: 16.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.none,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.mosque_finder',
                  ),

                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(mosque.lat, mosque.lng),
                        width: 48,
                        height: 48,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B5E20),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text('🕌', style: TextStyle(fontSize: 24)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + distance card
                _card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mosque.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (mosque.address != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      mosque.address!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.directions_walk,
                                    size: 14,
                                    color: Color(0xFF1B5E20),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    mosque.distanceText,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF1B5E20),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.directions,
                          label: 'Directions',
                          primary: true,
                          onTap: _openDirections,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.map_outlined,
                          label: 'OSM Map',
                          onTap: _openOsmDirections,
                        ),
                      ),
                      if (mosque.phone != null) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.call_outlined,
                            label: 'Call',
                            onTap: () =>
                                launchUrl(Uri.parse('tel:${mosque.phone}')),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Prayer times section
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('🕐', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          const Text(
                            'Prayer Times Today',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1B5E20),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Next: $nextPrayerName',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ...prayers.map((p) {
                        final isNext = p['name'] == nextPrayerName;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isNext
                                ? const Color(0xFFE8F5E9)
                                : const Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.circular(10),
                            border: isNext
                                ? Border.all(
                                    color: const Color(
                                      0xFF1B5E20,
                                    ).withValues(alpha: 0.4),
                                  )
                                : null,
                          ),
                          child: Row(
                            children: [
                              if (isNext)
                                const Icon(
                                  Icons.arrow_right,
                                  size: 18,
                                  color: Color(0xFF1B5E20),
                                ),
                              Text(
                                p['name']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isNext
                                      ? FontWeight.w700
                                      : FontWeight.normal,
                                  color: isNext
                                      ? const Color(0xFF1B5E20)
                                      : const Color(0xFF333333),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                p['time']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isNext
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isNext
                                      ? const Color(0xFF1B5E20)
                                      : const Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 4),
                      const Text(
                        '* Calculated using Hanafi method (Karachi)',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                // Attribution card
                _card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Sources',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        icon: Icons.public,
                        text: 'Map data © OpenStreetMap contributors',
                      ),
                      _InfoRow(
                        icon: Icons.layers_outlined,
                        text: 'Tiles by OpenStreetMap (free, no API key)',
                      ),
                      _InfoRow(
                        icon: Icons.schedule,
                        text: 'Prayer times: Adhan library (offline)',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool primary;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    this.primary = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: primary ? const Color(0xFF1B5E20) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primary ? const Color(0xFF1B5E20) : const Color(0xFFE0E0E0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primary ? Colors.white : const Color(0xFF1B5E20),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: primary ? Colors.white : const Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
