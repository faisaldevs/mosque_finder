import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/donation/model/donation_model.dart';
import 'package:mosque_finder_app/feature/donation/presentation/widget/campain_widget.dart';
import 'package:mosque_finder_app/feature/donation/presentation/widget/success_sheet.dart';

// ═════════════════════════════════════════════════════════════════════════════
// DonateScreen
// ═════════════════════════════════════════════════════════════════════════════
class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  double _totalDonated = 1245;
  String _selectedCategory = 'All';

  List<Campaign> get _filtered => _selectedCategory == 'All'
      ? sampleCampaigns
      : sampleCampaigns.where((c) => c.category == _selectedCategory).toList();

  void _onDonate(Campaign campaign, double amount) {
    setState(() => _totalDonated += amount);
    _showSuccessSheet(campaign, amount);
  }

  void _showSuccessSheet(Campaign campaign, double amount) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.kCard,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SuccessSheet(campaign: campaign, amount: amount),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildTotalCard()),
          SliverToBoxAdapter(child: _buildCategoryChips()),
          SliverToBoxAdapter(child: _buildSectionLabel()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) =>
                  CampaignCard(campaign: _filtered[i], onDonate: _onDonate),
              childCount: _filtered.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).padding.top + 16,
            20,
            24,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC62828), AppColors.kPink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.28),
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Donations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Give charity and earn endless rewards',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        // Decorative circles
        Positioned(top: -38, right: -38, child: _decorativeCircle(165)),
        Positioned(top: 16, right: 52, child: _decorativeCircle(100)),
      ],
    );
  }

  Widget _decorativeCircle(double size) => SizedBox(
    width: size,
    height: size,
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
          width: 1.5,
        ),
      ),
    ),
  );

  // ── Total donations card ────────────────────────────────────────────────────
  Widget _buildTotalCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your total donations',
                  style: TextStyle(color: AppColors.kSubText, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${_totalDonated.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppColors.kGreenLight,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(
                      Icons.trending_up_rounded,
                      color: AppColors.kGreenLight,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Sadaqah Jariyah — ongoing reward',
                      style: TextStyle(
                        color: AppColors.kSubText,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.kGreenLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.kGreenLight.withValues(alpha: 0.3),
              ),
            ),
            child: const Column(
              children: [
                Text('🌟', style: TextStyle(fontSize: 22)),
                SizedBox(height: 4),
                Text(
                  'Top\nDonor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.kGreenLight,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Category chips ──────────────────────────────────────────────────────────
  Widget _buildCategoryChips() {
    return Container(
      color: AppColors.kCard,
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          const Divider(height: 1, color: AppColors.kBorder),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: kCategories.map((cat) {
                final selected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFC62828)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFFC62828)
                            : AppColors.kBorder,
                      ),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.kSubText,
                        fontSize: 13,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: AppColors.kBorder),
        ],
      ),
    );
  }

  // ── Section label ───────────────────────────────────────────────────────────
  Widget _buildSectionLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          const Text(
            'Active Campaigns',
            style: TextStyle(
              color: AppColors.kText,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Text(
            '${_filtered.length} campaigns',
            style: const TextStyle(color: AppColors.kSubText, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
