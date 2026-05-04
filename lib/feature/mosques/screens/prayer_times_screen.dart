import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import '../services/prayer_service.dart';

class PrayerTimesScreen extends StatelessWidget {
  final double lat;
  final double lng;
  const PrayerTimesScreen({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    final times = PrayerTimesService.getPrayerTimes(lat, lng);
    final prayers = PrayerTimesService.getPrayerList(times);
    final nextPrayer = PrayerTimesService.getNextPrayer(times);
    final nextName = PrayerTimesService.prayerName(nextPrayer);

    final icons = ['🌅', '☀️', '🌤️', '🌇', '🌆', '🌙'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Date header
          Container(
            width: double.infinity,
            color: const Color(0xFF1B5E20),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _todayFormatted(),
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  'Next: $nextName',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: prayers.length,
              itemBuilder: (_, i) {
                final p = prayers[i];
                final isNext = p['name'] == nextName;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isNext ? const Color(0xFF1B5E20) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black .withValues(alpha:  0.05), blurRadius: 6)],
                  ),
                  child: Row(
                    children: [
                      Text(icons[i], style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 16),
                      Text(
                        p['name']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isNext ? FontWeight.w600 : FontWeight.normal,
                          color: isNext ? Colors.white : const Color(0xFF333333),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        p['time']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isNext ? Colors.white : const Color(0xFF1B5E20),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Calculated using Hanafi / Karachi method',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }

  String _todayFormatted() {
    final now = DateTime.now();
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    const days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }
}
