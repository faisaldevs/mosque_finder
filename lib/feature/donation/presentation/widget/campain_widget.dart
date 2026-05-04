// ═════════════════════════════════════════════════════════════════════════════
// _CampaignCard
// ═════════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/donation/model/donation_model.dart';

class CampaignCard extends StatefulWidget {
  final Campaign campaign;
  final void Function(Campaign campaign, double amount) onDonate;

  const CampaignCard({
    super.key,
    required this.campaign,
    required this.onDonate,
  });

  @override
  State<CampaignCard> createState() => _CampaignCardState();
}

class _CampaignCardState extends State<CampaignCard> {
  int? _selectedPresetIndex;
  bool _showCustom = false;
  double _customAmount = 0;
  final TextEditingController _customCtrl = TextEditingController();

  Campaign get c => widget.campaign;

  double get _effectiveAmount {
    if (_showCustom) return _customAmount;
    if (_selectedPresetIndex != null) {
      return kPresets[_selectedPresetIndex!].toDouble();
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
          children: List.generate(kPresets.length, (i) {
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
                    right: i < kPresets.length - 1 ? 8 : 0,
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
                      '\$${kPresets[i]}',
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
