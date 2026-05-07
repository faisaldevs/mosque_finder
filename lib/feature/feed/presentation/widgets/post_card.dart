import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../models/feed_models.dart';
import 'feed_widgets.dart';

// ─── Post card widget ──────────────────────────────────────────────────────────
class PostCard extends StatefulWidget {
  final Post post;
  final List<Reaction> reactions;
  final void Function(String postId, int reactionIdx) onReact;
  final void Function(Post) onCommentTap;
  final void Function(Post) onShareTap;

  const PostCard({
    super.key,
    required this.post,
    required this.reactions,
    required this.onReact,
    required this.onCommentTap,
    required this.onShareTap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  OverlayEntry? _reactionOverlay;
  bool _showFullText = false;

  void _showReactions(BuildContext ctx) {
    final box = ctx.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(Offset.zero);

    _reactionOverlay = OverlayEntry(
      builder: (_) => Positioned(
        left: 12,
        top: pos.dy - 60,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.kCard,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.kBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.reactions.length,
                (i) => GestureDetector(
                  onTap: () {
                    widget.onReact(widget.post.id, i);
                    _dismissReactions();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.reactions[i].emoji,
                          style: const TextStyle(fontSize: 26),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.reactions[i].label,
                          style: const TextStyle(
                            color: AppColors.kSubText,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(ctx).insert(_reactionOverlay!);
  }

  void _dismissReactions() {
    _reactionOverlay?.remove();
    _reactionOverlay = null;
  }

  @override
  void dispose() {
    _reactionOverlay?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.post;
    final hasReaction = p.reactionIndex >= 0;
    final rxn = hasReaction
        ? widget.reactions[p.reactionIndex]
        : widget.reactions[0];

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                buildAvatar(p.userEmoji, 42),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.userName,
                        style: const TextStyle(
                          color: AppColors.kText,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.public_rounded,
                            color: AppColors.kSubText,
                            size: 11,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            p.timeAgo,
                            style: const TextStyle(
                              color: AppColors.kSubText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    color: AppColors.kSubText,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // ── Post type badge ──────────────────────────────────────────────────
          if (p.postType != null)
            _buildTypeBadge(p.postType!, p.typeContent ?? ''),

          // ── Text ─────────────────────────────────────────────────────────────
          if (p.text != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.text!,
                    maxLines: _showFullText ? null : 3,
                    overflow: _showFullText ? null : TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.kText,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  if (!_showFullText && (p.text?.length ?? 0) > 120)
                    GestureDetector(
                      onTap: () => setState(() => _showFullText = true),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          'See more',
                          style: TextStyle(
                            color: AppColors.kGreenLight,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

          // ── Image placeholder ─────────────────────────────────────────────────
          if (p.imageAsset != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.kPrimary.withValues(alpha: 0.15),
              ),
              child: Center(
                child: Text(
                  p.imageAsset!,
                  style: const TextStyle(fontSize: 72),
                ),
              ),
            ),
          ],

          const SizedBox(height: 10),

          // ── Reaction summary ─────────────────────────────────────────────────
          if (p.totalReactions > 0 || p.commentCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  if (p.totalReactions > 0) ...[
                    _buildReactionBubbles(p),
                    const SizedBox(width: 6),
                    Text(
                      formatCount(p.totalReactions),
                      style: const TextStyle(
                        color: AppColors.kSubText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                  const Spacer(),
                  if (p.commentCount > 0)
                    GestureDetector(
                      onTap: () => widget.onCommentTap(p),
                      child: Text(
                        '${formatCount(p.commentCount)} comments',
                        style: const TextStyle(
                          color: AppColors.kSubText,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  if (p.shares > 0) ...[
                    const SizedBox(width: 10),
                    Text(
                      '${formatCount(p.shares)} shares',
                      style: const TextStyle(
                        color: AppColors.kSubText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),

          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.kBorder),

          // ── Action bar ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                // Like (long press for reactions)
                Expanded(
                  child: Builder(
                    builder: (ctx) => GestureDetector(
                      onLongPress: () => _showReactions(ctx),
                      child: ActionButton(
                        emoji: hasReaction ? rxn.emoji : '👍',
                        label: hasReaction ? rxn.label : 'Like',
                        color: hasReaction
                            ? hexToColor(rxn.colorHex)
                            : AppColors.kSubText,
                        isBold: hasReaction,
                        onTap: () => widget.onReact(p.id, 0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ActionButton(
                    emoji: '💬',
                    label: 'Comment',
                    color: AppColors.kSubText,
                    onTap: () => widget.onCommentTap(p),
                  ),
                ),
                Expanded(
                  child: ActionButton(
                    emoji: '🔗',
                    label: 'Share',
                    color: AppColors.kSubText,
                    onTap: () => widget.onShareTap(p),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(String type, String content) {
    Color bg;
    IconData icon;
    String tag;
    switch (type) {
      case 'quran':
        bg = const Color(0xFF1565C0);
        icon = Icons.menu_book_rounded;
        tag = 'Quran';
        break;
      case 'hadith':
        bg = const Color(0xFF6A1B9A);
        icon = Icons.format_quote_rounded;
        tag = 'Hadith';
        break;
      case 'checkin':
        bg = const Color(0xFFB71C1C);
        icon = Icons.location_on_rounded;
        tag = 'Check-in';
        break;
      case 'prayer':
        bg = const Color.fromARGB(255, 61, 87, 86);
        icon = Icons.access_time_rounded;
        tag = 'Prayer';
        break;
      default:
        bg = AppColors.kCard;
        icon = Icons.info_outline_rounded;
        tag = '';
    }

    if (type == 'quran' || type == 'hadith') {
      return Container(
        margin: const EdgeInsets.fromLTRB(14, 8, 14, 0),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: bg.withValues(alpha: 0.35), width: 1),
          gradient: LinearGradient(
            colors: [bg.withValues(alpha: 0.15), bg.withValues(alpha: 0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: bg.withValues(alpha: 0.9), size: 14),
                const SizedBox(width: 6),
                Text(
                  tag,
                  style: TextStyle(
                    color: bg.withValues(alpha: 0.9),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14,
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: bg.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: bg.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: bg.withValues(alpha: 0.9), size: 13),
            const SizedBox(width: 5),
            Text(
              content,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionBubbles(Post p) {
    final shown = <int>[];
    if (p.likes > 0) shown.add(0);
    if (p.loves > 0) shown.add(1);
    if (p.duas > 0) shown.add(2);
    if (p.mashallahs > 0) shown.add(3);
    if (p.sads > 0) shown.add(4);

    return SizedBox(
      height: 20,
      width: shown.take(3).length * 18.0,
      child: Stack(
        children: List.generate(
          shown.take(3).length,
          (i) => Positioned(
            left: i * 14.0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kCard,
                border: Border.all(color: AppColors.kBorder, width: 1.2),
              ),
              child: Center(
                child: Text(
                  widget.reactions[shown[i]].emoji,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
