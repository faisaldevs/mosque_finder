import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

import 'category_model.dart';
import 'event_model.dart';

// Category data
const List<Category> categories = [
  Category('all', 'All Events', '🗓️', AppColors.kPrimary),
  Category('ramadan', 'Ramadan', '🌙', AppColors.kPrimary),
  Category('eid', 'Eid', '🎉', AppColors.kPink),
  Category('jumuah', "Jumu'ah", '🕌', AppColors.kTeal),
  Category('lecture', 'Lectures', '📚', AppColors.kBlue),
  Category('charity', 'Charity', '❤️', AppColors.kRed),
  Category('youth', 'Youth', '⚽', AppColors.kOrange),
  Category('sisters', 'Sisters', '🌸', AppColors.kDeepPurple),
];

// Hijri calendar grid data
const String hijriMonthName = "Dhul-Qi'dah 1447";
const int hijriTotalDays = 30;
const int hijriStartWeekday = 6; // 0=Mon … 6=Sun → starts Saturday = index 5
const Set<int> eventDays = {5, 9, 10, 13, 15, 16, 17, 20, 22};

// Mock events data
List<Event> buildEvents() => [
  Event(
    id: '1',
    title: 'Ramadan Iftar Gathering',
    categoryId: 'ramadan',
    hijriDate: '8 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 5, 2026',
    time: '6:30 PM',
    location: 'Central Masjid',
    attending: 150,
    description:
        'Join us for a community Iftar gathering. All are welcome. Light refreshments will be provided after Maghrib prayer.',
    color: AppColors.kPrimary,
    featured: true,
  ),
  Event(
    id: '2',
    title: "Jumu'ah Khutbah — Unity in Islam",
    categoryId: 'jumuah',
    hijriDate: '9 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 9, 2026',
    time: '1:00 PM',
    location: 'Baitul Mukarram',
    attending: 800,
    description:
        'Weekly Friday prayer and khutbah. Topic: Unity and brotherhood in the Muslim Ummah.',
    color: AppColors.kTeal,
  ),
  Event(
    id: '3',
    title: 'Taraweeh Special Program',
    categoryId: 'ramadan',
    hijriDate: '13 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 10, 2026',
    time: '8:00 PM',
    location: 'Al-Noor Mosque',
    attending: 200,
    description:
        'Special Taraweeh prayers with recitation of the full Quran. Guest Imam from Egypt.',
    color: AppColors.kPrimary,
  ),
  Event(
    id: '4',
    title: 'Islamic Finance Workshop',
    categoryId: 'lecture',
    hijriDate: '15 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 15, 2026',
    time: '10:00 AM',
    location: 'Dhaka Islamic Center',
    attending: 75,
    description:
        'A comprehensive workshop on halal investment, Zakat calculation, and interest-free banking.',
    color: AppColors.kBlue,
    featured: true,
  ),
  Event(
    id: '5',
    title: 'Eid-ul-Fitr Celebration',
    categoryId: 'eid',
    hijriDate: '1 Shawwal 1447',
    gregorianDate: 'June 4, 2026',
    time: '7:00 AM',
    location: 'Community Center',
    attending: 500,
    description:
        'Grand Eid celebration with prayers, community feast, and activities for children. Takbeerat begin at 6:30 AM.',
    color: AppColors.kPink,
    featured: true,
  ),
  Event(
    id: '6',
    title: 'Sisters Quran Circle',
    categoryId: 'sisters',
    hijriDate: '16 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 16, 2026',
    time: '3:00 PM',
    location: 'Islamic Women\'s Centre',
    attending: 40,
    description:
        'Weekly sisters-only Quran recitation and tafseer circle. Open to all levels.',
    color: const Color(0xFF880E4F),
  ),
  Event(
    id: '7',
    title: 'Youth Football Tournament',
    categoryId: 'youth',
    hijriDate: '17 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 17, 2026',
    time: '9:00 AM',
    location: 'Dhaka Sports Complex',
    attending: 120,
    description:
        'Annual Islamic Youth Network football tournament. Register your team today!',
    color: AppColors.kOrange,
  ),
  Event(
    id: '8',
    title: 'Charity Food Drive',
    categoryId: 'charity',
    hijriDate: '20 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 20, 2026',
    time: '9:00 AM – 5:00 PM',
    location: 'Multiple Locations',
    attending: 90,
    description:
        'Community charity food drive. Drop off non-perishable food items at any participating mosque.',
    color: const Color(0xFFD32F2F),
  ),
  Event(
    id: '9',
    title: "Fiqh of Prayer — Lecture Series",
    categoryId: 'lecture',
    hijriDate: '22 Dhul-Qi\'dah 1447',
    gregorianDate: 'May 22, 2026',
    time: '7:00 PM',
    location: 'Online + Al-Noor Mosque',
    attending: 300,
    description:
        'Part 3 of the Fiqh of Prayer series. Covering the conditions, pillars, and sunnahs of Salah.',
    color: AppColors.kBlue,
  ),
  Event(
    id: '10',
    title: 'Eid-ul-Adha Grand Celebration',
    categoryId: 'eid',
    hijriDate: '10 Dhul-Hijjah 1447',
    gregorianDate: 'Aug 10, 2026',
    time: '6:45 AM',
    location: 'National Stadium Ground',
    attending: 2000,
    description:
        'Grand Eid-ul-Adha prayers followed by community sacrifice (Qurbani) and feast.',
    color: AppColors.kPink,
    featured: true,
  ),
];
