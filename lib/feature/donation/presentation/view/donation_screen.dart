import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

// ─── Campaign Model ───────────────────────────────────────────────────────────
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
const List<int> _kPresets = [10, 25, 50, 100];
const List<String> _kCategories = [
  'All',
  'Masjid',
  'Orphans',
  'Education',
  'Food',
  'Zakat',
  'Water',
];

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
      builder: (_) => _SuccessSheet(campaign: campaign, amount: amount),
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
                  _CampaignCard(campaign: _filtered[i], onDonate: _onDonate),
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
              children: _kCategories.map((cat) {
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

// ═════════════════════════════════════════════════════════════════════════════
// _CampaignCard
// ═════════════════════════════════════════════════════════════════════════════
class _CampaignCard extends StatefulWidget {
  final Campaign campaign;
  final void Function(Campaign campaign, double amount) onDonate;

  const _CampaignCard({required this.campaign, required this.onDonate});

  @override
  State<_CampaignCard> createState() => _CampaignCardState();
}

class _CampaignCardState extends State<_CampaignCard> {
  int? _selectedPresetIndex;
  bool _showCustom = false;
  double _customAmount = 0;
  final TextEditingController _customCtrl = TextEditingController();

  Campaign get c => widget.campaign;

  double get _effectiveAmount {
    if (_showCustom) return _customAmount;
    if (_selectedPresetIndex != null) {
      return _kPresets[_selectedPresetIndex!].toDouble();
    }
    return 0;
  }

  bool get _canDonate => _effectiveAmount > 0;

  @override
  void dispose() {
    _customCtrl.dispose();
    super.dispose();
  }

  void _handleDonate() {
    if (!_canDonate) return;
    final amount = _effectiveAmount;
    setState(() {
      _selectedPresetIndex = null;
      _showCustom = false;
      _customAmount = 0;
      _customCtrl.clear();
    });
    widget.onDonate(c, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: c.featured
              ? c.accentColor.withValues(alpha: 0.5)
              : AppColors.kBorder,
          width: c.featured ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top accent bar
          Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [c.accentColor, c.accentColor.withValues(alpha: 0.35)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardHeader(),
                const SizedBox(height: 12),
                _buildMetaRow(),
                const SizedBox(height: 14),
                const Divider(height: 1, color: AppColors.kBorder),
                const SizedBox(height: 14),
                _buildAmountSection(),
                const SizedBox(height: 14),
                _buildDonateButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Card header ─────────────────────────────────────────────────────────────
  Widget _buildCardHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: c.accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: c.accentColor.withValues(alpha: 0.28)),
          ),
          child: Center(
            child: Text(c.emoji, style: const TextStyle(fontSize: 28)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (c.featured)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.star_rounded, color: c.accentColor, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        'Featured',
                        style: TextStyle(
                          color: c.accentColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              Text(
                c.title,
                style: const TextStyle(
                  color: AppColors.kText,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                c.organization,
                style: const TextStyle(
                  color: AppColors.kSubText,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Days left badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: c.daysLeft <= 10
                ? AppColors.kRed.withValues(alpha: 0.15)
                : AppColors.kBorder.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: c.daysLeft <= 10
                  ? AppColors.kRed.withValues(alpha: 0.4)
                  : AppColors.kBorder,
            ),
          ),
          child: Text(
            '${c.daysLeft}d left',
            style: TextStyle(
              color: c.daysLeft <= 10 ? AppColors.kError : AppColors.kSubText,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ── Meta row ────────────────────────────────────────────────────────────────
  Widget _buildMetaRow() {
    return Row(
      children: [
        const Icon(Icons.group_rounded, color: AppColors.kSubText, size: 14),
        const SizedBox(width: 5),
        Text(
          '${c.donorCount} donors',
          style: const TextStyle(color: AppColors.kSubText, fontSize: 12.5),
        ),
        const SizedBox(width: 16),
        const Icon(
          Icons.access_time_rounded,
          color: AppColors.kSubText,
          size: 13,
        ),
        const SizedBox(width: 5),
        Text(
          '${c.daysLeft} days left',
          style: const TextStyle(color: AppColors.kSubText, fontSize: 12.5),
        ),
      ],
    );
  }

  // ── Amount selection ────────────────────────────────────────────────────────
  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Amount',
          style: TextStyle(
            color: AppColors.kSubText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        // Preset chips
        Row(
          children: List.generate(_kPresets.length, (i) {
            final selected = !_showCustom && _selectedPresetIndex == i;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() {
                  _selectedPresetIndex = selected ? null : i;
                  _showCustom = false;
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: EdgeInsets.only(
                    right: i < _kPresets.length - 1 ? 8 : 0,
                  ),
                  height: 42,
                  decoration: BoxDecoration(
                    color: selected
                        ? c.accentColor.withValues(alpha: 0.15)
                        : AppColors.kBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected ? c.accentColor : AppColors.kBorder,
                      width: selected ? 1.5 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '\$${_kPresets[i]}',
                      style: TextStyle(
                        color: selected ? c.accentColor : AppColors.kText,
                        fontSize: 14,
                        fontWeight: selected
                            ? FontWeight.w800
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        // Custom amount toggle
        GestureDetector(
          onTap: () => setState(() {
            _showCustom = !_showCustom;
            if (_showCustom) _selectedPresetIndex = null;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: _showCustom
                  ? c.accentColor.withValues(alpha: 0.08)
                  : AppColors.kBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _showCustom ? c.accentColor : AppColors.kBorder,
                width: _showCustom ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.edit_rounded,
                  color: _showCustom ? c.accentColor : AppColors.kSubText,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Custom amount',
                  style: TextStyle(
                    color: _showCustom ? c.accentColor : AppColors.kSubText,
                    fontSize: 13,
                    fontWeight: _showCustom ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const Spacer(),
                if (_showCustom && _customAmount > 0) ...[
                  Text(
                    '\$${_customAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: c.accentColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                Icon(
                  _showCustom
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColors.kSubText,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        // Custom input field (animated)
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: _showCustom
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.kBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _customAmount > 0
                                ? c.accentColor
                                : AppColors.kBorder,
                            width: _customAmount > 0 ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Text(
                                '\$',
                                style: TextStyle(
                                  color: c.accentColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _customCtrl,
                                autofocus: true,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}'),
                                  ),
                                ],
                                style: const TextStyle(
                                  color: AppColors.kText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '0.00',
                                  hintStyle: TextStyle(
                                    color: AppColors.kSubText,
                                    fontSize: 22,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                onChanged: (v) => setState(
                                  () => _customAmount = double.tryParse(v) ?? 0,
                                ),
                              ),
                            ),
                            if (_customAmount > 0)
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    _customCtrl.clear();
                                    setState(() => _customAmount = 0);
                                  },
                                  child: const Icon(
                                    Icons.cancel_rounded,
                                    color: AppColors.kSubText,
                                    size: 20,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Quick suggestions
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Text(
                              'Quick: ',
                              style: TextStyle(
                                color: AppColors.kSubText,
                                fontSize: 12,
                              ),
                            ),
                            ...[5, 15, 20, 75, 200].map((amt) {
                              return GestureDetector(
                                onTap: () {
                                  _customCtrl.text = '$amt';
                                  setState(
                                    () => _customAmount = amt.toDouble(),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.kCard,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.kBorder,
                                    ),
                                  ),
                                  child: Text(
                                    '\$$amt',
                                    style: const TextStyle(
                                      color: AppColors.kText,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  // ── Donate button ───────────────────────────────────────────────────────────
  Widget _buildDonateButton() {
    final label = _canDonate
        ? 'Donate \$${_effectiveAmount % 1 == 0 ? _effectiveAmount.toStringAsFixed(0) : _effectiveAmount.toStringAsFixed(2)} Now'
        : 'Select an amount';

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _canDonate ? _handleDonate : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _canDonate ? c.accentColor : AppColors.kBorder,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.kBorder,
          disabledForegroundColor: AppColors.kSubText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_rounded, size: 17),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// _SuccessSheet
// ═════════════════════════════════════════════════════════════════════════════
class _SuccessSheet extends StatelessWidget {
  final Campaign campaign;
  final double amount;

  const _SuccessSheet({required this.campaign, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.kBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // Checkmark circle
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kGreenLight.withValues(alpha: 0.12),
              border: Border.all(
                color: AppColors.kGreenLight.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.kGreenLight,
              size: 42,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'JazakAllahu Khayran! 🤲',
            style: TextStyle(
              color: AppColors.kText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your donation of \$${amount.toStringAsFixed(2)} to\n"${campaign.title}" has been received.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.kSubText,
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 20),
          // Campaign summary
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.kBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(campaign.emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: const TextStyle(
                          color: AppColors.kText,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        campaign.organization,
                        style: const TextStyle(
                          color: AppColors.kSubText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
