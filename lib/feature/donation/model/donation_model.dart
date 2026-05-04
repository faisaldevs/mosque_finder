// ─── Campaign Model ───────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

class Campaign {
  final String id;
  final String title;
  final String organization;
  final String emoji;
  final String category;
  final int donorCount;
  final int daysLeft;
  final Color accentColor;
  final bool featured;

  const Campaign({
    required this.id,
    required this.title,
    required this.organization,
    required this.emoji,
    required this.category,
    required this.donorCount,
    required this.daysLeft,
    required this.accentColor,
    this.featured = false,
  });
}

// ─── Sample Campaigns ─────────────────────────────────────────────────────────
final List<Campaign> sampleCampaigns = [
  Campaign(
    id: '1',
    title: 'Build New Masjid',
    organization: 'Islamic Center',
    emoji: '🕌',
    category: 'Masjid',
    donorCount: 234,
    daysLeft: 45,
    accentColor: AppColors.kRed,
    featured: true,
  ),
  Campaign(
    id: '2',
    title: 'Orphan Support Program',
    organization: 'Muslim Charity',
    emoji: '👶',
    category: 'Orphans',
    donorCount: 156,
    daysLeft: 30,
    accentColor: AppColors.kRed,
  ),
  Campaign(
    id: '3',
    title: 'Quran Distribution Drive',
    organization: 'Al-Furqan Foundation',
    emoji: '📖',
    category: 'Education',
    donorCount: 89,
    daysLeft: 20,
    accentColor: AppColors.kBlue,
  ),
  Campaign(
    id: '4',
    title: 'Iftar for the Needy',
    organization: 'Dhaka Relief',
    emoji: '🍽️',
    category: 'Food',
    donorCount: 412,
    daysLeft: 10,
    accentColor: AppColors.kTeal,
    featured: true,
  ),
  Campaign(
    id: '5',
    title: 'Zakat Al-Fitr Fund',
    organization: 'National Zakat Board',
    emoji: '🌙',
    category: 'Zakat',
    donorCount: 1203,
    daysLeft: 5,
    accentColor: AppColors.kPurple,
  ),
  Campaign(
    id: '6',
    title: 'Water Well Project — Africa',
    organization: 'Islamic Aid',
    emoji: '💧',
    category: 'Water',
    donorCount: 320,
    daysLeft: 60,
    accentColor: AppColors.kBlueLight,
  ),
];

// ─── Constants ────────────────────────────────────────────────────────────────
const List<int> kPresets = [10, 25, 50, 100];
const List<String> kCategories = [
  'All',
  'Masjid',
  'Orphans',
  'Education',
  'Food',
  'Zakat',
  'Water',
];
