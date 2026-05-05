import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

// ─── Data model ───────────────────────────────────────────────────────────────
class _Consultant {
  final String name, emoji, specialty, category, experience, rate;
  final double rating;
  final int reviews;
  final List<String> languages;
  final bool available;
  const _Consultant({
    required this.name,
    required this.emoji,
    required this.specialty,
    required this.category,
    required this.experience,
    required this.rate,
    required this.rating,
    required this.reviews,
    required this.languages,
    this.available = true,
  });
}

const _consultants = [
  _Consultant(
    name: 'Sheikh Dr. Ahmad Rahman',
    emoji: '🧔',
    specialty: 'Islamic Jurisprudence (Fiqh)',
    category: 'Fiqh',
    experience: '15+ years',
    rate: '\$50/hour',
    rating: 4.9,
    reviews: 234,
    languages: ['English', 'Arabic'],
    available: true,
  ),
  _Consultant(
    name: 'Dr. Fatima Hassan',
    emoji: '🧕',
    specialty: 'Marriage & Family Counseling',
    category: 'Counseling',
    experience: '12 years',
    rate: '\$45/hour',
    rating: 4.8,
    reviews: 189,
    languages: ['English', 'Urdu'],
    available: true,
  ),
  _Consultant(
    name: 'Mufti Ibrahim Ali',
    emoji: '👳',
    specialty: 'Islamic Finance & Banking',
    category: 'Finance',
    experience: '10 years',
    rate: '\$60/hour',
    rating: 4.7,
    reviews: 312,
    languages: ['English', 'Arabic', 'Urdu'],
    available: false,
  ),
  _Consultant(
    name: 'Ustadha Khadija Malik',
    emoji: '🧕',
    specialty: 'Quran & Tajweed Studies',
    category: 'Fiqh',
    experience: '8 years',
    rate: '\$35/hour',
    rating: 4.9,
    reviews: 156,
    languages: ['English', 'Arabic'],
    available: true,
  ),
  _Consultant(
    name: 'Dr. Yusuf Al-Qaradawi',
    emoji: '🧔',
    specialty: 'Mental Health & Islamic Therapy',
    category: 'Counseling',
    experience: '14 years',
    rate: '\$55/hour',
    rating: 4.6,
    reviews: 98,
    languages: ['English', 'French', 'Arabic'],
    available: true,
  ),
  _Consultant(
    name: 'Sheikh Omar Abdullah',
    emoji: '👨',
    specialty: 'Halal Investment & Zakat',
    category: 'Finance',
    experience: '9 years',
    rate: '\$40/hour',
    rating: 4.8,
    reviews: 201,
    languages: ['English', 'Malay'],
    available: false,
  ),
];

// ═════════════════════════════════════════════════════════════════════════════
// CONSULT SCREEN
// ═════════════════════════════════════════════════════════════════════════════

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});
  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  String _selected = 'All Consultants';
  final _categories = ['All Consultants', 'Fiqh', 'Counseling', 'Finance'];

  List<_Consultant> get _filtered => _selected == 'All Consultants'
      ? _consultants
      : _consultants.where((c) => c.category == _selected).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: Column(
        children: [
          _buildHeader(),
          _buildCategoryChips(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: _filtered.length,
              itemBuilder: (_, i) => _ConsultantCard(
                consultant: _filtered[i],
                onTap: () => _openDetail(context, _filtered[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return ClipRect(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF00695C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => nav.goBack(),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Container(
                        //   width: 36,
                        //   height: 36,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withValues(alpha: 0.15),
                        //     shape: BoxShape.circle,
                        //     border: Border.all(
                        //       color: Colors.white.withValues(alpha: 0.25),
                        //       width: 1,
                        //     ),
                        //   ),
                        //   child: const Icon(
                        //     Icons.chat_bubble_outline_rounded,
                        //     color: Colors.white,
                        //     size: 18,
                        //   ),
                        // ),
                        // const SizedBox(width: 12),
                        const Text(
                          'Islamic Consultancy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Get guidance from qualified scholars',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Decorative circles — same language as all other screens
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(top: -35, right: -35, child: _circle(160)),
                Positioned(top: 18, right: 55, child: _circle(95)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double s) => Container(
    width: s,
    height: s,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );

  // ── Category chips ─────────────────────────────────────────────────────────
  Widget _buildCategoryChips() {
    return Container(
      color: AppColors.kCard,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: _categories.map((cat) {
                final sel = cat == _selected;
                return GestureDetector(
                  onTap: () => setState(() => _selected = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: sel ? AppColors.kPrimary : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: sel ? AppColors.kPrimary : AppColors.kBorder,
                        width: sel ? 1.5 : 1,
                      ),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: sel ? Colors.white : AppColors.kSubText,
                        fontSize: 13.5,
                        fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
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

  void _openDetail(BuildContext context, _Consultant c) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _ConsultantDetailPage(consultant: c)),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// CONSULTANT CARD
// ═════════════════════════════════════════════════════════════════════════════

class _ConsultantCard extends StatelessWidget {
  final _Consultant consultant;
  final VoidCallback onTap;
  const _ConsultantCard({required this.consultant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = consultant;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top row: avatar + info + badge ──
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kPrimary.withValues(alpha: 0.12),
                          border: Border.all(
                            color: AppColors.kPrimary.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            c.emoji,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    c.name,
                                    style: const TextStyle(
                                      color: AppColors.kText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              c.specialty,
                              style: const TextStyle(
                                color: AppColors.kSubText,
                                fontSize: 12.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFFFB300),
                                  size: 15,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  c.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: AppColors.kText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(${c.reviews})',
                                  style: const TextStyle(
                                    color: AppColors.kSubText,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                // Available badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: c.available
                                        ? AppColors.kGreenLight.withValues(
                                            alpha: 0.12,
                                          )
                                        : AppColors.kSubText.withValues(
                                            alpha: 0.1,
                                          ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: c.available
                                          ? AppColors.kGreenLight.withValues(
                                              alpha: 0.4,
                                            )
                                          : AppColors.kBorder,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: c.available
                                              ? AppColors.kGreenLight
                                              : AppColors.kSubText,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        c.available
                                            ? 'Available Now'
                                            : 'Unavailable',
                                        style: TextStyle(
                                          color: c.available
                                              ? AppColors.kGreenLight
                                              : AppColors.kSubText,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  const Divider(height: 1, color: AppColors.kBorder),
                  const SizedBox(height: 12),

                  // ── Stats row ──────────────────────────────────────────────────
                  Row(
                    children: [
                      _statCol('Experience', c.experience),
                      const SizedBox(width: 32),
                      _statCol('Rate', c.rate, isGreen: true),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ── Languages ──────────────────────────────────────────────────
                  const Text(
                    'Languages',
                    style: TextStyle(color: AppColors.kSubText, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    children: c.languages
                        .map(
                          (lang) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.kBg,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.kBorder),
                            ),
                            child: Text(
                              lang,
                              style: const TextStyle(
                                color: AppColors.kText,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            // ── Action buttons ────────────────────────────────────────────────
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.kBorder)),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: _outlineBtn(
                        Icons.phone_outlined,
                        'Call',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _outlineBtn(
                        Icons.videocam_outlined,
                        'Video',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => _BookingPage(consultant: c),
                            ),
                          ),
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            size: 16,
                          ),
                          label: const Text(
                            'Book',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kPrimary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCol(String label, String value, {bool isGreen = false}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(color: AppColors.kSubText, fontSize: 12),
      ),
      const SizedBox(height: 2),
      Text(
        value,
        style: TextStyle(
          color: isGreen ? AppColors.kGreenLight : AppColors.kText,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );

  Widget _outlineBtn(
    IconData icon,
    String label, {
    required VoidCallback onTap,
  }) => SizedBox(
    height: 44,
    child: OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: AppColors.kSubText),
      label: Text(
        label,
        style: const TextStyle(color: AppColors.kText, fontSize: 13),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        side: const BorderSide(color: AppColors.kBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// CONSULTANT DETAIL PAGE
// ═════════════════════════════════════════════════════════════════════════════

class _ConsultantDetailPage extends StatelessWidget {
  final _Consultant consultant;
  const _ConsultantDetailPage({required this.consultant});

  @override
  Widget build(BuildContext context) {
    final c = consultant;
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: Column(
        children: [
          // Header
          ClipRect(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B5E20), Color(0xFF00695C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.15),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.15),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Icon(
                              Icons.bookmark_outline_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            c.emoji,
                            style: const TextStyle(fontSize: 42),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        c.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        c.specialty,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFB300),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${c.rating} (${c.reviews} reviews)',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Stack(
                    children: [
                      Positioned(top: -35, right: -35, child: _circle(160)),
                      Positioned(top: 18, right: 55, child: _circle(95)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _detailStat('⏱️', c.experience, 'Experience'),
                        const SizedBox(width: 8),
                        _detailStat('💰', c.rate, 'Rate'),
                        const SizedBox(width: 8),
                        _detailStat(
                          '🌐',
                          c.languages.length.toString(),
                          'Languages',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // About
                  _section(
                    'About',
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'A highly experienced ${c.specialty.toLowerCase()} specialist with ${c.experience} of practice. '
                        'Known for providing clear, evidence-based Islamic guidance rooted in the Quran and authentic Sunnah. '
                        'Available for consultations via call, video, or in-person sessions.',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Availability
                  _section(
                    'Availability',
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _availRow('Mon – Thu', '9:00 AM – 6:00 PM'),
                          const SizedBox(height: 8),
                          _availRow('Friday', 'After Jumu\'ah – 5:00 PM'),
                          const SizedBox(height: 8),
                          _availRow('Saturday', '10:00 AM – 2:00 PM'),
                          const SizedBox(height: 8),
                          _availRow('Sunday', 'Closed'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Languages
                  _section(
                    'Languages',
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: c.languages
                            .map(
                              (lang) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kPrimary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.kPrimary.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  lang,
                                  style: const TextStyle(
                                    color: AppColors.kText,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom book bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          MediaQuery.of(context).padding.bottom + 12,
        ),
        decoration: const BoxDecoration(
          color: AppColors.kCard,
          border: Border(top: BorderSide(color: AppColors.kBorder)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Rate',
                  style: TextStyle(color: AppColors.kSubText, fontSize: 12),
                ),
                Text(
                  c.rate,
                  style: const TextStyle(
                    color: AppColors.kGreenLight,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _BookingPage(consultant: c),
                    ),
                  ),
                  icon: const Icon(Icons.calendar_month_rounded, size: 18),
                  label: const Text(
                    'Book Consultation',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double s) => Container(
    width: s,
    height: s,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );

  Widget _detailStat(String emoji, String value, String label) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.kText,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.kSubText, fontSize: 11),
          ),
        ],
      ),
    ),
  );

  Widget _section(String title, Widget child) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.kText,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: child,
        ),
      ],
    ),
  );

  Widget _availRow(String day, String hours) => Row(
    children: [
      SizedBox(
        width: 110,
        child: Text(
          day,
          style: const TextStyle(color: AppColors.kSubText, fontSize: 13),
        ),
      ),
      Text(
        hours,
        style: const TextStyle(
          color: AppColors.kText,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// BOOKING PAGE
// ═════════════════════════════════════════════════════════════════════════════

class _BookingPage extends StatefulWidget {
  final _Consultant consultant;
  const _BookingPage({required this.consultant});
  @override
  State<_BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<_BookingPage> {
  int _selectedDay = 0;
  int _selectedSlot = -1;
  String _sessionType = 'Video';

  static const _days = [
    ('Mon', '26'),
    ('Tue', '27'),
    ('Wed', '28'),
    ('Thu', '29'),
    ('Sat', '31'),
    ('Sun', '1'),
  ];

  static const _slots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
  ];

  static const _busySlots = {
    0: [2],
    1: [0, 4],
    2: [1],
    3: [],
    4: [3],
    5: [],
  };

  @override
  Widget build(BuildContext context) {
    final c = widget.consultant;
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: Column(
        children: [
          // Header
          ClipRect(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B5E20), Color(0xFF00695C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.15),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Book Consultation',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                c.name,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.75),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Stack(
                    children: [
                      Positioned(top: -35, right: -35, child: _circle(160)),
                      Positioned(top: 18, right: 55, child: _circle(95)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Session type
                  _bookingSection(
                    'Session Type',
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: ['Call', 'Video', 'In-Person'].map((type) {
                          final sel = type == _sessionType;
                          final icon = type == 'Call'
                              ? Icons.phone_rounded
                              : type == 'Video'
                              ? Icons.videocam_rounded
                              : Icons.person_rounded;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _sessionType = type),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: sel
                                      ? AppColors.kPrimary
                                      : AppColors.kBg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: sel
                                        ? AppColors.kPrimary
                                        : AppColors.kBorder,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icon,
                                      color: sel
                                          ? Colors.white
                                          : AppColors.kSubText,
                                      size: 20,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      type,
                                      style: TextStyle(
                                        color: sel
                                            ? Colors.white
                                            : AppColors.kSubText,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Date picker
                  _bookingSection(
                    'Select Date',
                    Column(
                      children: [
                        const SizedBox(height: 4),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                          child: Row(
                            children: List.generate(_days.length, (i) {
                              final sel = i == _selectedDay;
                              return GestureDetector(
                                onTap: () => setState(() {
                                  _selectedDay = i;
                                  _selectedSlot = -1;
                                }),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 54,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    color: sel
                                        ? AppColors.kPrimary
                                        : AppColors.kBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: sel
                                          ? AppColors.kPrimary
                                          : AppColors.kBorder,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _days[i].$1,
                                        style: TextStyle(
                                          color: sel
                                              ? Colors.white70
                                              : AppColors.kSubText,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _days[i].$2,
                                        style: TextStyle(
                                          color: sel
                                              ? Colors.white
                                              : AppColors.kText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Time slots
                  _bookingSection(
                    'Select Time',
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.6,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: _slots.length,
                        itemBuilder: (_, i) {
                          final busy = (_busySlots[_selectedDay] ?? [])
                              .contains(i);
                          final sel = i == _selectedSlot;
                          return GestureDetector(
                            onTap: busy
                                ? null
                                : () => setState(() => _selectedSlot = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              decoration: BoxDecoration(
                                color: busy
                                    ? AppColors.kBg.withValues(alpha: 0.5)
                                    : sel
                                    ? AppColors.kPrimary
                                    : AppColors.kBg,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: busy
                                      ? AppColors.kBorder.withValues(alpha: 0.4)
                                      : sel
                                      ? AppColors.kPrimary
                                      : AppColors.kBorder,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _slots[i],
                                  style: TextStyle(
                                    color: busy
                                        ? AppColors.kSubText.withValues(
                                            alpha: 0.4,
                                          )
                                        : sel
                                        ? Colors.white
                                        : AppColors.kText,
                                    fontSize: 13,
                                    fontWeight: sel
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    decoration: busy
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Note
                  _bookingSection(
                    'Add a Note (Optional)',
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        maxLines: 3,
                        style: const TextStyle(
                          color: AppColors.kText,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Briefly describe your question or concern...',
                          hintStyle: const TextStyle(
                            color: AppColors.kSubText,
                            fontSize: 13,
                          ),
                          filled: true,
                          fillColor: AppColors.kBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.kBorder,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.kBorder,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.kPrimary,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom confirm bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          MediaQuery.of(context).padding.bottom + 12,
        ),
        decoration: const BoxDecoration(
          color: AppColors.kCard,
          border: Border(top: BorderSide(color: AppColors.kBorder)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedSlot >= 0) ...[
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.kSubText,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${_days[_selectedDay].$1}, May ${_days[_selectedDay].$2} · ${_slots[_selectedSlot]} · $_sessionType',
                    style: const TextStyle(
                      color: AppColors.kSubText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedSlot >= 0
                    ? () => _showConfirm(context)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedSlot >= 0
                      ? AppColors.kPrimary
                      : AppColors.kPrimary.withValues(alpha: 0.4),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white60,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  _selectedSlot >= 0
                      ? 'Confirm Booking · ${c.rate}'
                      : 'Select a time slot',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double s) => Container(
    width: s,
    height: s,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1.5,
      ),
      color: Colors.transparent,
    ),
  );

  Widget _bookingSection(String title, Widget child) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.kText,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: child,
        ),
      ],
    ),
  );

  void _showConfirm(BuildContext context) {
    final c = widget.consultant;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.kCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kPrimary.withValues(alpha: 0.15),
                border: Border.all(
                  color: AppColors.kPrimary.withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.kGreenLight,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Confirm Booking',
              style: TextStyle(
                color: AppColors.kText,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              c.name,
              style: const TextStyle(color: AppColors.kSubText, fontSize: 14),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.kBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: Column(
                children: [
                  _confirmRow(
                    Icons.calendar_today_rounded,
                    '${_days[_selectedDay].$1}, May ${_days[_selectedDay].$2}',
                  ),
                  const SizedBox(height: 8),
                  _confirmRow(Icons.access_time_rounded, _slots[_selectedSlot]),
                  const SizedBox(height: 8),
                  _confirmRow(Icons.videocam_outlined, _sessionType),
                  const SizedBox(height: 8),
                  _confirmRow(Icons.attach_money_rounded, c.rate, green: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        '✅ Booking confirmed! JazakAllahu Khayran.',
                      ),
                      backgroundColor: AppColors.kPrimary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.kSubText, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _confirmRow(IconData icon, String text, {bool green = false}) => Row(
    children: [
      Icon(
        icon,
        color: green ? AppColors.kGreenLight : AppColors.kSubText,
        size: 16,
      ),
      const SizedBox(width: 10),
      Text(
        text,
        style: TextStyle(
          color: green ? AppColors.kGreenLight : AppColors.kText,
          fontSize: 14,
          fontWeight: green ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    ],
  );
}
