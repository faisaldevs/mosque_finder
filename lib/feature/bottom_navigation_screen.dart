// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mosque_finder_app/app/theme/app_colors.dart';

// class BottomNavigationScreen extends StatefulWidget {
//   const BottomNavigationScreen({super.key, required this.shell});

//   final StatefulNavigationShell shell;

//   @override
//   State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
// }

// class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
//   int _navIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(bottomNavigationBar: _buildNavBar());
//   }

//   // ── Bottom Navigation ──────────────────────────────────────────────────────

//   Widget _buildNavBar() {
//     const items = [
//       _NavItem(icon: Icons.home_rounded, label: 'Home'),
//       _NavItem(icon: Icons.article_rounded, label: 'Feed'),
//       _NavItem(icon: Icons.event_rounded, label: 'Events'),
//       _NavItem(icon: Icons.person_rounded, label: 'Profile'),
//     ];

//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.kCard,
//         border: const Border(
//           top: BorderSide(color: AppColors.kBorder, width: 1),
//         ),
//       ),
//       child: SafeArea(
//         top: false,
//         child: SizedBox(
//           height: 64,
//           child: Row(
//             children: List.generate(items.length, (i) {
//               final selected = i == _navIndex;
//               return Expanded(
//                 child: GestureDetector(
//                   onTap: () => setState(() => _navIndex = i),
//                   behavior: HitTestBehavior.opaque,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         padding: const EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: selected
//                               ? AppColors.kGreen.withValues(alpha: 0.15)
//                               : Colors.transparent,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           items[i].icon,
//                           color: selected
//                               ? AppColors.kGreenLight
//                               : AppColors.kSubText,
//                           size: 22,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         items[i].label,
//                         style: TextStyle(
//                           color: selected
//                               ? AppColors.kGreenLight
//                               : AppColors.kSubText,
//                           fontSize: 11,
//                           fontWeight: selected
//                               ? FontWeight.w600
//                               : FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _NavItem {
//   final IconData icon;
//   final String label;
//   const _NavItem({required this.icon, required this.label});
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: _buildNavBar(),
      drawer: Drawer(),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Bottom Navigation Bar
  // ─────────────────────────────────────────────────────────────

  Widget _buildNavBar() {
    const items = [
      _NavItem(icon: Icons.article_rounded, label: 'Feed'),
      _NavItem(icon: Icons.explore_rounded, label: 'Discover'),
      _NavItem(icon: Icons.location_on_rounded, label: 'Mosques'),
      _NavItem(icon: Icons.person_rounded, label: 'Profile'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        border: const Border(
          top: BorderSide(color: AppColors.kBorder, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),

      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 74,
          child: Row(
            children: List.generate(items.length, (index) {
              final selected = widget.shell.currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                  
                    widget.shell.goBranch(
                      index,
                      initialLocation: index == widget.shell.currentIndex,
                    );
                    
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.kPrimary.withValues(alpha: 0.9)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          items[index].icon,
                          size: 24,
                          color: selected
                              ? AppColors.kWhite
                              : AppColors.kDarkLight.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        items[index].label,
                        style: TextStyle(
                          fontSize: 11,
                          color: selected
                              ? AppColors.kPrimary
                              : AppColors.kDarkLight.withValues(alpha: 0.6),
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
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

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
