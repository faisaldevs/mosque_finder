// import 'package:flutter/material.dart';
// import 'package:mosque_finder_app/app/router/config/route_extention.dart';
// import 'package:mosque_finder_app/feature/profile/vm/profile_screen_vm.dart';
// import 'package:mosque_finder_app/feature/profile/widgets/profile_widgets.dart';
// import 'package:provider/provider.dart';

// import '../../../app/theme/app_colors.dart';

// // ═════════════════════════════════════════════════════════════════════════════
// // PROFILE MAIN PAGE
// // ═════════════════════════════════════════════════════════════════════════════

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProfileScreenVm>(
//       builder: (context, vm, child) {
//         return Scaffold(
//           backgroundColor: AppColors.kBg,
//           body: SingleChildScrollView(
//             physics: AlwaysScrollableScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildProfileHeader(context),
//                 const SizedBox(height: 24),

//                 // ACCOUNT
//                 sectionCard(
//                   label: 'Account',
//                   children: [
//                     settingsRow(
//                       icon: Icons.person_outline_rounded,
//                       iconBg: AppColors.kPrimary.withValues(alpha: 0.85),
//                       title: 'Personal info',
//                       subtitle: 'Name, phone, email',
//                       onTap: () => nav.toUserProfileScreen(),
//                     ),
//                     settingsRow(
//                       icon: Icons.lock_outline_rounded,
//                       iconBg: AppColors.kDark.withValues(alpha: 0.85),
//                       title: 'Change password',
//                       subtitle: 'Last changed 3 months ago',
//                       onTap: () => nav.toUpdatePassScreen(),
//                       isLast: true,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // PREFERENCES
//                 sectionCard(
//                   label: 'Preferences',
//                   children: [
//                     settingsRow(
//                       icon: Icons.access_time_rounded,
//                       iconBg: AppColors.kBlue.withValues(alpha: 0.85),
//                       title: 'Calculation method',
//                       onTap: () => nav.toCalcMethodScreen(),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppColors.kBorder,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               vm.calculationMethod,
//                               style: const TextStyle(
//                                 color: AppColors.kText,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           const Icon(
//                             Icons.chevron_right_rounded,
//                             color: AppColors.kSubText,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                     ),
//                     settingsRow(
//                       icon: Icons.radar_rounded,
//                       iconBg: AppColors.kPrimary.withValues(alpha: 0.85),
//                       title: 'Search radius',
//                       onTap: () => nav.toSearchRadiusScreen(),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             width: 30,
//                             height: 22,
//                             decoration: BoxDecoration(
//                               color: AppColors.kPrimary,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 '${vm.searchRadius.round()}',
//                                 style: TextStyle(
//                                   color: AppColors.kWhite,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           const Icon(
//                             Icons.chevron_right_rounded,
//                             color: AppColors.kSubText,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                     ),
//                     settingsRow(
//                       icon: Icons.notifications_outlined,
//                       iconBg: AppColors.kWarning.withValues(alpha: 0.85),
//                       title: 'Azan reminders',
//                       subtitle: 'Prayer notifications',
//                       onTap: () => nav.toAzanRemindersScreen(),
//                       trailing: Switch(
//                         value: vm.azanRemindersEnabled,
//                         onChanged: (v) => vm.toggleAzanReminders(v),
//                         activeColor: AppColors.kWhite,
//                         activeTrackColor: AppColors.kPrimary,
//                       ),
//                       isLast: true,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // APP
//                 sectionCard(
//                   label: 'App',
//                   children: [
//                     settingsRow(
//                       icon: Icons.info_outline_rounded,
//                       iconBg: const Color(0xFF37474F),
//                       title: 'About',
//                       subtitle: 'Version 1.0.0',
//                       onTap: () => nav.toAboutScreen(),
//                     ),
//                     settingsRow(
//                       icon: Icons.star_outline_rounded,
//                       iconBg: const Color(0xFF37474F),
//                       title: 'Rate on Play Store',
//                       onTap: () {},
//                       isLast: true,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // LOG OUT
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.kWhite,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: AppColors.kBorder),
//                     ),
//                     child: InkWell(
//                       onTap: () => vm.logout(),
//                       borderRadius: BorderRadius.circular(16),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 14,
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 38,
//                               height: 38,
//                               decoration: BoxDecoration(
//                                 color: AppColors.kError.withValues(alpha: 0.15),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: AppColors.kError.withValues(
//                                     alpha: 0.3,
//                                   ),
//                                 ),
//                               ),
//                               child: const Icon(
//                                 Icons.logout_rounded,
//                                 color: AppColors.kError,
//                                 size: 19,
//                               ),
//                             ),
//                             const SizedBox(width: 13),
//                             const Text(
//                               'Log out',
//                               style: TextStyle(
//                                 color: AppColors.kError,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Footer
//                 const Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 28),
//                     child: Text(
//                       'Mosque Finder v1.0 · OpenStreetMap',
//                       style: TextStyle(
//                         color: AppColors.kDarkLight,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget buildProfileHeader(BuildContext context) {
//     return ClipRect(
//       child: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
//             color: AppColors.kPrimary,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title row
//                 Row(
//                   children: [
//                     const Text(
//                       'My Profile',
//                       style: TextStyle(
//                         color: AppColors.kTextWhite,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       width: 36,
//                       height: 36,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColors.kDarkLight.withValues(alpha: 0.12),
//                         border: Border.all(color: AppColors.kBorder, width: 1),
//                       ),
//                       child: const Icon(
//                         Icons.edit_outlined,
//                         color: AppColors.kTextWhite,
//                         size: 17,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // Avatar + info
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                           width: 68,
//                           height: 68,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.kWhite.withValues(alpha: 0.15),
//                             border: Border.all(
//                               color: AppColors.kBorder,
//                               width: 2,
//                             ),
//                           ),
//                           child: const Center(
//                             child: Text('🧑', style: TextStyle(fontSize: 36)),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             width: 22,
//                             height: 22,
//                             decoration: BoxDecoration(
//                               color: AppColors.kBg,
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: AppColors.kPrimary,
//                                 width: 1.5,
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.camera_alt_rounded,
//                               color: AppColors.kText,
//                               size: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Faisal Ahmed',
//                             style: TextStyle(
//                               color: AppColors.kTextWhite,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           const SizedBox(height: 3),
//                           const Text(
//                             '+880 1712 345 678',
//                             style: TextStyle(
//                               color: AppColors.kSubText,
//                               fontSize: 13,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppColors.kWhite.withValues(alpha: 0.6),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(color: AppColors.kBorder),
//                             ),
//                             child: const Text(
//                               'Member since 2024',
//                               style: TextStyle(
//                                 color: AppColors.kDark,
//                                 fontSize: 11.5,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // Stats row
//                 Row(
//                   children: [
//                     stat('12', 'Saved'),
//                     const SizedBox(width: 8),
//                     stat('47', 'Visited'),
//                     const SizedBox(width: 8),
//                     stat('3 km', 'Radius'),
//                     const SizedBox(width: 8),
//                     stat('Hanafi', 'Method'),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Decorative circles
//           Positioned.fill(
//             child: Stack(
//               children: [
//                 Positioned(top: -35, right: -35, child: hdrCircle(160)),
//                 Positioned(top: 18, right: 55, child: hdrCircle(95)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget stat(String value, String label) => Expanded(
//     child: Container(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.12),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: Colors.white.withValues(alpha: 0.2),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: const TextStyle(
//               color: AppColors.kTextWhite,
//               fontSize: 15,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             label,
//             style: const TextStyle(color: AppColors.kGreenDark, fontSize: 10.5),
//           ),
//         ],
//       ),
//     ),
//   );

//   Widget hdrCircle(double s) => Container(
//     width: s,
//     height: s,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
//       color: Colors.transparent,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/feed/presentation/models/feed_models.dart';
import 'package:mosque_finder_app/feature/feed/presentation/vm/feed_viewmodel.dart';
import 'package:mosque_finder_app/feature/feed/presentation/widgets/comments_sheet.dart';
import 'package:mosque_finder_app/feature/feed/presentation/widgets/post_card.dart';
import 'package:mosque_finder_app/feature/profile/vm/profile_screen_vm.dart';
import 'package:provider/provider.dart';

// ═════════════════════════════════════════════════════════════════════════════
// PROFILE SCREEN — Facebook-style layout
// ═════════════════════════════════════════════════════════════════════════════

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Placeholder data — replace with real auth/user model when ready
  static const String _kName = 'Faisal Ahmed';
  static const String _kPhone = '+880 1712 345 678';
  static const int _kSaved = 12;
  static const int _kVisited = 47;

  // @override
  // Widget build(BuildContext context) {
  //   final feedVM = context.watch<FeedViewModel>();
  //   return Consumer<ProfileScreenVm>(
  //     builder: (context, vm, child) {
  //       return Scaffold(
  //         backgroundColor: AppColors.kBg,
  //         body: SingleChildScrollView(
  //           physics: const AlwaysScrollableScrollPhysics(),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // ── Cover + floating avatar + name ────────────────────────
  //               ProfileHeader(
  //                 name: _kName,
  //                 phone: _kPhone,
  //                 calculationMethod: vm.calculationMethod,
  //               ),

  //               // ── 4-stat row ────────────────────────────────────────────
  //               StatsRow(
  //                 saved: _kSaved,
  //                 visited: _kVisited,
  //                 radius: vm.searchRadius,
  //                 method: vm.calculationMethod,
  //               ),

  //               // ── Action buttons ────────────────────────────────────────
  //               const _ActionButtons(),

  //               const SectionDivider(),

  //               Expanded(
  //                 child: ListView.builder(
  //                   padding: const EdgeInsets.only(bottom: 12),
  //                   physics: const BouncingScrollPhysics(),
  //                   itemCount: feedVM.posts.length + 1,
  //                   itemBuilder: (ctx, i) {
  //                     // if (i == 0) return _buildCreatePost(context);
  //                     final post = feedVM.posts[i - 1];
  //                     return PostCard(
  //                       key: ValueKey(post.id),
  //                       post: post,
  //                       reactions: feedReactions,
  //                       onReact: (postId, idx) =>
  //                           feedVM.reactToPost(postId, idx),
  //                       onCommentTap: (post) =>
  //                           _openComments(context, feedVM, post),
  //                       onShareTap: (post) => feedVM.sharePost(post.id),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final feedVM = context.watch<FeedViewModel>();
    return Consumer<ProfileScreenVm>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: AppColors.kBg,
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // ── Fixed header section ──────────────────────────────────
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover + floating avatar + name
                    ProfileHeader(
                      name: _kName,
                      phone: _kPhone,
                      calculationMethod: vm.calculationMethod,
                    ),

                    // 4-stat row
                    StatsRow(
                      saved: _kSaved,
                      visited: _kVisited,
                      radius: vm.searchRadius,
                      method: vm.calculationMethod,
                    ),

                    // Action buttons
                    const _ActionButtons(),

                    const SectionDivider(),
                  ],
                ),
              ),

              // ── Scrollable feed content ───────────────────────────────
              SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  // if (i == 0) return _buildCreatePost(context);
                  final post = feedVM.posts[i];
                  return PostCard(
                    key: ValueKey(post.id),
                    post: post,
                    reactions: feedReactions,
                    onReact: (postId, idx) => feedVM.reactToPost(postId, idx),
                    onCommentTap: (post) =>
                        _openComments(context, feedVM, post),
                    onShareTap: (post) => feedVM.sharePost(post.id),
                  );
                }, childCount: feedVM.posts.length),
              ),

              // Bottom padding
              SliverToBoxAdapter(child: SizedBox(height: 12)),
            ],
          ),
        );
      },
    );
  }

  void _openComments(BuildContext context, FeedViewModel feedVM, Post post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CommentsSheet(
        post: post,
        onAddComment: (text) => feedVM.addComment(post.id, text),
        onLikeComment: (commentId) => feedVM.likeComment(post.id, commentId),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// PROFILE HEADER
// Layout: cover photo behind → white panel below → avatar floats at boundary
// ═════════════════════════════════════════════════════════════════════════════

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.phone,
    required this.calculationMethod,
  });

  final String name;
  final String phone;
  final String calculationMethod;

  static const double _coverHeight = 195;
  static const double _avatarSize = 94;
  // How many px of the avatar overlap INTO the cover from below
  static const double _avatarOverlap = 46;

  @override
  Widget build(BuildContext context) {
    // Top of avatar circle relative to Stack origin (top of cover)
    final double avatarTop = _coverHeight - _avatarOverlap;

    // White panel starts where the bottom half of the avatar begins
    final double panelTop = avatarTop + _avatarSize - _avatarOverlap;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1 ── Cover photo (green + diagonal stripe pattern)
        const CoverPhoto(height: _coverHeight),

        // 2 ── White info panel below cover
        Padding(
          padding: EdgeInsets.only(top: panelTop),
          child: Container(
            width: double.infinity,
            color: AppColors.kWhite,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Horizontal space reserved for the avatar
                    SizedBox(width: _avatarSize + 10),

                    // Name + subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.kDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Member since 2024 · $calculationMethod',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.kSubText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Edit profile button
                    OutlineButton(
                      label: 'Edit profile',
                      icon: Icons.edit_outlined,
                      onTap: () => nav.toUserProfileScreen(),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Phone
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: 15,
                      color: AppColors.kSubText,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.kText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // 3 ── Floating avatar — positioned on the cover / white boundary
        Positioned(
          top: avatarTop,
          left: 16,
          child: FloatingAvatar(name: name, size: _avatarSize),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// COVER PHOTO — solid green + subtle diagonal stripe (no images needed)
// ═════════════════════════════════════════════════════════════════════════════

class CoverPhoto extends StatelessWidget {
  const CoverPhoto({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          // Solid green base
          Container(color: AppColors.kPrimary),

          // Diagonal stripe overlay
          CustomPaint(
            size: Size(double.infinity, height),
            painter: _DiagonalStripePainter(),
          ),

          // Top bar: safe-area-aware, right-aligned "Edit cover" button
          SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: OutlineButton(
                  label: 'Edit cover',
                  icon: Icons.photo_camera_outlined,
                  onTap: () {},
                  dark: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints subtle semi-transparent diagonal lines across the cover.
class _DiagonalStripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke;

    const spacing = 36.0;
    final lineCount = (size.width + size.height) ~/ spacing + 2;

    for (var i = 0; i < lineCount; i++) {
      final offset = i * spacing;
      canvas.drawLine(Offset(offset, 0), Offset(0, offset), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═════════════════════════════════════════════════════════════════════════════
// FLOATING AVATAR — initials + white ring border + camera badge
// ═════════════════════════════════════════════════════════════════════════════

class FloatingAvatar extends StatelessWidget {
  const FloatingAvatar({super.key, required this.name, required this.size});

  final String name;
  final double size;

  /// Extract up to 2 initials from the full name.
  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Avatar circle with white border
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.kWhite, width: 4),
            color: AppColors.kPrimary.withValues(alpha: 0.85),
          ),
          child: Center(
            child: Text(
              _initials,
              style: TextStyle(
                fontSize: size * 0.33,
                fontWeight: FontWeight.w700,
                color: AppColors.kWhite,
              ),
            ),
          ),
        ),
        // Camera badge
        Positioned(
          bottom: 3,
          right: 2,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kBg,
              border: Border.all(color: AppColors.kWhite, width: 2),
            ),
            child: const Icon(
              Icons.camera_alt_rounded,
              size: 13,
              color: AppColors.kText,
            ),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// STATS ROW  —  Saved · Visited · Radius · Method
// ═════════════════════════════════════════════════════════════════════════════

class StatsRow extends StatelessWidget {
  const StatsRow({
    super.key,
    required this.saved,
    required this.visited,
    required this.radius,
    required this.method,
  });

  final int saved;
  final int visited;
  final double radius;
  final String method;

  @override
  Widget build(BuildContext context) {
    // Shorten long method labels so they fit the tile  (e.g. "Karachi / Hanafi" → "Hanafi")
    final shortMethod = method.contains('/')
        ? method.split('/').last.trim()
        : method;

    return Container(
      color: AppColors.kWhite,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
      child: Row(
        children: [
          _StatTile(value: '$saved', label: 'Saved'),
          const SizedBox(width: 8),
          _StatTile(value: '$visited', label: 'Visited'),
          const SizedBox(width: 8),
          _StatTile(value: '${radius.round()} km', label: 'Radius'),
          const SizedBox(width: 8),
          _StatTile(value: shortMethod, label: 'Method', small: true),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    this.small = false,
  });

  final String value;
  final String label;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.kBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.kBorder),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: small ? 12 : 15,
                fontWeight: FontWeight.w700,
                color: AppColors.kDark,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppColors.kSubText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// ACTION BUTTONS  —  [Add mosque]  [Share profile]  [˅]
// ═════════════════════════════════════════════════════════════════════════════

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kWhite,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: OutlineActionButton(
                  label: 'Dashboard',
                  icon: Icons.dashboard_outlined,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 5,
                child: OutlineActionButton(
                  label: 'Analytics',
                  icon: Icons.bar_chart_outlined,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: OutlineActionButton(
                  label: 'Settings',
                  icon: Icons.settings_outlined,
                  onTap: () => nav.toSettingScreen(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 5,
                child: OutlineActionButton(
                  label: 'Share profile',
                  icon: Icons.share_outlined,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// SETTINGS SECTION LABEL
// ═════════════════════════════════════════════════════════════════════════════

class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.kText,
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// SETTINGS CARD
// ═════════════════════════════════════════════════════════════════════════════

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kBorder),
        ),
        child: Column(children: children),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// SETTING ROW
// ═════════════════════════════════════════════════════════════════════════════

class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.trailing,
    this.isLast = false,
  });

  final IconData icon;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(16),
            bottom: isLast ? const Radius.circular(16) : Radius.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Icon pill
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: AppColors.kWhite, size: 18),
                ),
                const SizedBox(width: 13),
                // Title + optional subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kText,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.kSubText,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Trailing or default chevron
                trailing ??
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.kSubText,
                      size: 18,
                    ),
              ],
            ),
          ),
        ),
        if (!isLast)
          const Divider(height: 1, indent: 63, color: AppColors.kBorder),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// LOG OUT CARD
// ═════════════════════════════════════════════════════════════════════════════

class LogoutCard extends StatelessWidget {
  const LogoutCard({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kBorder),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.kError.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.kError.withValues(alpha: 0.25),
                    ),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.kError,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 13),
                const Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kError,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// SMALL REUSABLE WIDGETS
// ═════════════════════════════════════════════════════════════════════════════

/// 8 px grey gap between major white sections
class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});
  @override
  Widget build(BuildContext context) =>
      Container(height: 8, color: AppColors.kBg);
}

/// Outline button — dark=true for use on the green cover, dark=false on white
class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.dark = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? Colors.black38 : AppColors.kBg;
    final fg = dark ? AppColors.kWhite : AppColors.kText;
    final bd = dark ? Colors.white24 : AppColors.kBorder;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: bd),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Green filled primary button
class FilledButton extends StatelessWidget {
  const FilledButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: AppColors.kPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: AppColors.kWhite),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bordered secondary button
class OutlineActionButton extends StatelessWidget {
  const OutlineActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: AppColors.kBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.kBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: AppColors.kText),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.kText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Circle "more options" button (˅ chevron)
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.kBg,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.kBorder),
        ),
        child: Icon(icon, size: 20, color: AppColors.kText),
      ),
    );
  }
}

/// Grey pill badge — e.g. "Muslim World League"
class Pill extends StatelessWidget {
  const Pill({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.kBorder,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: AppColors.kText),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Green number badge — search radius km value
class RadiusBadge extends StatelessWidget {
  const RadiusBadge({super.key, required this.value});
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 22,
      decoration: BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          '$value',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.kWhite,
          ),
        ),
      ),
    );
  }
}
