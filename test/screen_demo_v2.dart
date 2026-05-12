import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const DiscoverPage(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const kTeal = Color(0xFF1AA596);
const kTealLight = Color(0xFF22C4B0);
const kTealDark = Color(0xFF0D7A6E);
const kBg = Color(0xFFF5F7F9);
const kCard = Colors.white;
const kText = Color(0xFF0D1B1E);
const kMuted = Color(0xFF7A9199);

// ─── Quick Action Data ────────────────────────────────────────────────────────

class QuickAction {
  final String label;
  final IconData icon;
  final Color color;
  const QuickAction(this.label, this.icon, this.color);
}

const _actions = [
  QuickAction('Mosques', Icons.location_on_rounded, Color(0xFF1AA596)),
  QuickAction('Education', Icons.menu_book_rounded, Color(0xFF4A6CF7)),
  QuickAction('Donate', Icons.favorite_rounded, Color(0xFFE8567A)),
  QuickAction('Market', Icons.shopping_bag_rounded, Color(0xFF8B5CF6)),
  QuickAction('Events', Icons.event_rounded, Color(0xFFFF8C42)),
  QuickAction('Consult', Icons.chat_bubble_rounded, Color(0xFF1AA596)),
  QuickAction('Friends', Icons.group_rounded, Color(0xFF3D7A5E)),
  QuickAction('Hajj', Icons.flight_rounded, Color(0xFF0B9EAE)),
];

// ─── Featured Card Data ───────────────────────────────────────────────────────

class FeaturedCard {
  final String title;
  final String subtitle;
  final String tag;
  final Color color;
  final Color tagColor;
  final IconData icon;
  const FeaturedCard({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.color,
    required this.tagColor,
    required this.icon,
  });
}

const _featured = [
  FeaturedCard(
    title: 'Ramadan Calendar 2026',
    subtitle: 'Prepare for the blessed month ahead',
    tag: 'Upcoming',
    color: Color(0xFF1AA596),
    tagColor: Color(0xFFFFD166),
    icon: Icons.calendar_month_rounded,
  ),
  FeaturedCard(
    title: 'Daily Dhikr',
    subtitle: 'Morning & evening remembrance',
    tag: 'New',
    color: Color(0xFF4A6CF7),
    tagColor: Color(0xFFBBF7D0),
    icon: Icons.auto_awesome_rounded,
  ),
  FeaturedCard(
    title: 'Quran Recitation',
    subtitle: 'Listen to beautiful recitations',
    tag: 'Popular',
    color: Color(0xFF8B5CF6),
    tagColor: Color(0xFFFCA5A5),
    icon: Icons.headphones_rounded,
  ),
];

// ─── Discover Page ────────────────────────────────────────────────────────────

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  int _navIndex = 1;
  late AnimationController _headerAnim;
  late Animation<double> _headerFade;

  @override
  void initState() {
    super.initState();
    _headerAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _headerFade = CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut);
    _headerAnim.forward();
  }

  @override
  void dispose() {
    _headerAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildPrayerCard(),
            const SizedBox(height: 28),
            _buildSectionTitle('Quick Actions'),
            const SizedBox(height: 14),
            _buildQuickActions(),
            const SizedBox(height: 28),
            _buildSectionTitle('Featured'),
            const SizedBox(height: 14),
            _buildFeaturedScroll(),
            const SizedBox(height: 28),
            _buildSectionTitle('Explore'),
            const SizedBox(height: 14),
            _buildExploreGrid(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _headerFade,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kTeal,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -30,
              right: -20,
              child: _circle(140, Colors.white.withOpacity(0.07)),
            ),
            Positioned(
              top: 30,
              right: 60,
              child: _circle(80, Colors.white.withOpacity(0.06)),
            ),
            Positioned(
              bottom: -10,
              left: -30,
              child: _circle(100, Colors.white.withOpacity(0.05)),
            ),
            // Content
            Padding(
              padding: EdgeInsets.fromLTRB(
                  24, MediaQuery.of(context).padding.top + 20, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'As-Salamu Alaykum',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Monday, April 28, 2026  ·  29 Shawwal 1447',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      // Bell button
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withOpacity(0.25), width: 1),
                        ),
                        child: const Icon(Icons.notifications_none_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Next prayer pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.2), width: 0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFD166),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Next: Asr',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '4:33 PM',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 13),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Maghrib  6:32 PM',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12),
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
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  // ── Prayer Times Card ─────────────────────────────────────────────────────

  Widget _buildPrayerCard() {
    final prayers = [
      ('Fajr', '5:10 AM', false),
      ('Dhuhr', '12:15 PM', false),
      ('Asr', '4:33 PM', true),
      ('Maghrib', '6:32 PM', false),
      ('Isha', '8:00 PM', false),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
              child: Row(
                children: [
                  const Icon(Icons.access_time_rounded,
                      color: kTeal, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Prayer Times',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: kTeal),
                  ),
                  const Spacer(),
                  Text('Today',
                      style: TextStyle(fontSize: 12, color: kMuted)),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF0F2F5)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: prayers.map((p) {
                  final isNext = p.$3;
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isNext ? kTeal : const Color(0xFFF5F7F9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Text(
                          p.$1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isNext
                                ? Colors.white.withOpacity(0.85)
                                : kMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p.$2,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isNext ? Colors.white : kText,
                          ),
                        ),
                        if (isNext) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Title ─────────────────────────────────────────────────────────

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: kText,
              letterSpacing: -0.2,
            ),
          ),
          Text(
            'See all',
            style: TextStyle(
                fontSize: 13, color: kTeal, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // ── Quick Actions ─────────────────────────────────────────────────────────

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemCount: _actions.length,
        itemBuilder: (context, i) => _buildActionItem(_actions[i]),
      ),
    );
  }

  Widget _buildActionItem(QuickAction action) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: action.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: action.color.withOpacity(0.15), width: 0.5),
            ),
            child: Icon(action.icon, color: action.color, size: 26),
          ),
          const SizedBox(height: 7),
          Text(
            action.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: kText,
            ),
          ),
        ],
      ),
    );
  }

  // ── Featured Horizontal Scroll ────────────────────────────────────────────

  Widget _buildFeaturedScroll() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _featured.length,
        itemBuilder: (context, i) {
          final card = _featured[i];
          return Container(
            width: 240,
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              color: card.color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                // Decorative arc
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: -15,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.07),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: card.tagColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              card.tag,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: card.color,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Icon(card.icon,
                              color: Colors.white.withOpacity(0.7),
                              size: 22),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        card.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.72),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 0.5),
                            ),
                            child: const Text(
                              'Explore',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Explore Grid ──────────────────────────────────────────────────────────

  Widget _buildExploreGrid() {
    final items = [
      ('Qibla Direction', Icons.explore_rounded, const Color(0xFF1AA596)),
      ('Islamic Articles', Icons.article_rounded, const Color(0xFF4A6CF7)),
      ('Charity Drive', Icons.volunteer_activism_rounded, const Color(0xFFE8567A)),
      ('Community', Icons.diversity_3_rounded, const Color(0xFF3D7A5E)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.55,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: item.$3.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item.$2, color: item.$3, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.$1,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kText,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Bottom Navigation ─────────────────────────────────────────────────────

  Widget _buildNavBar() {
    final items = [
      (Icons.dynamic_feed_rounded, 'Feed'),
      (Icons.explore_rounded, 'Discover'),
      (Icons.location_on_rounded, 'Mosques'),
      (Icons.person_rounded, 'Profile'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: kCard,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: List.generate(items.length, (i) {
              final isActive = i == _navIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _navIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive
                          ? kTeal.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[i].$1,
                          color: isActive ? kTeal : kMuted,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          items[i].$2,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isActive ? kTeal : kMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}