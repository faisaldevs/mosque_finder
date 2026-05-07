import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/router/config/route_extention.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../models/feed_models.dart';
import '../vm/feed_viewmodel.dart';
import '../widgets/comments_sheet.dart';
import '../widgets/create_post_sheet.dart';
import '../widgets/feed_widgets.dart';
import '../widgets/post_card.dart';

// ─── Post type options constants ───────────────────────────────────────────────
const List<PostTypeOption> _postTypes = [
  PostTypeOption(id: 'photo', emoji: '📷', label: 'Photo', colorHex: '#43A047'),
  PostTypeOption(id: 'quran', emoji: '📖', label: 'Quran', colorHex: '#1E88E5'),
  PostTypeOption(
    id: 'hadith',
    emoji: '💬',
    label: 'Hadith',
    colorHex: '#8E24AA',
  ),
  PostTypeOption(
    id: 'checkin',
    emoji: '📍',
    label: 'Check-in',
    colorHex: '#E53935',
  ),
  PostTypeOption(
    id: 'prayer',
    emoji: '🤲',
    label: 'Prayer',
    colorHex: '#2E7D32',
  ),
];

// ═════════════════════════════════════════════════════════════════════════════
// FEED SCREEN
// ═════════════════════════════════════════════════════════════════════════════

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeedViewModel(),
      child: _FeedScreenContent(),
    );
  }
}

// ─── Feed screen content ───────────────────────────────────────────────────────
class _FeedScreenContent extends StatelessWidget {
  const _FeedScreenContent();

  @override
  Widget build(BuildContext context) {
    final feedVM = context.watch<FeedViewModel>();

    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: Column(
        children: [
          _buildTopBar(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 12),
              physics: const BouncingScrollPhysics(),
              itemCount: feedVM.posts.length + 1,
              itemBuilder: (ctx, i) {
                if (i == 0) return _buildCreatePost(context);
                final post = feedVM.posts[i - 1];
                return PostCard(
                  key: ValueKey(post.id),
                  post: post,
                  reactions: feedReactions,
                  onReact: (postId, idx) => feedVM.reactToPost(postId, idx),
                  onCommentTap: (post) => _openComments(context, feedVM, post),
                  onShareTap: (post) => feedVM.sharePost(post.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Top bar ───────────────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 16),
            color: AppColors.kPrimary,
            child: Row(
              children: [
                Text(
                  'Community Feed',
                  style: TextStyle(
                    color: AppColors.kTextWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                Spacer(),
                _TopBarIconButton(icon: Icons.search_rounded, onTap: () {}),
                SizedBox(width: 8),
                _TopBarIconButton(
                  icon: Icons.notifications_outlined,
                  onTap: () => nav.toNotificationScreen(),
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

  // ── Create post bar ───────────────────────────────────────────────────────
  Widget _buildCreatePost(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      decoration: BoxDecoration(
        color: AppColors.kBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                buildAvatar('🧑', 38),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openCreatePost(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kBg,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.kBorder),
                      ),
                      child: const Text(
                        "What's on your mind?",
                        style: TextStyle(
                          color: AppColors.kSubText,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.kBorder),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _quickPostBtn(
                  Icons.image_rounded,
                  'Photo',
                  const Color(0xFF43A047),
                  () => _openCreatePost(context, type: 'photo'),
                ),
                _quickPostBtn(
                  Icons.menu_book_rounded,
                  'Quran',
                  const Color(0xFF1E88E5),
                  () => _openCreatePost(context, type: 'quran'),
                ),
                _quickPostBtn(
                  Icons.format_quote_rounded,
                  'Hadith',
                  const Color(0xFF8E24AA),
                  () => _openCreatePost(context, type: 'hadith'),
                ),
                _quickPostBtn(
                  Icons.location_on_rounded,
                  'Check-in',
                  const Color(0xFFE53935),
                  () => _openCreatePost(context, type: 'checkin'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickPostBtn(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) => GestureDetector(
    onTap: onTap,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.kText,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  // ── Create post sheet ─────────────────────────────────────────────────────
  void _openCreatePost(BuildContext context, {String? type}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final feedVM = context.read<FeedViewModel>();
        return CreatePostSheet(
          initialType: type,
          postTypes: _postTypes,
          onPost: (post) => feedVM.addPost(post),
        );
      },
    );
  }

  // ── Comments sheet ────────────────────────────────────────────────────────
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

// ─── Top bar icon button ───────────────────────────────────────────────────────

class _TopBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _TopBarIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.15),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        child: Icon(icon, color: AppColors.kTextWhite, size: 18),
      ),
    );
  }
}
