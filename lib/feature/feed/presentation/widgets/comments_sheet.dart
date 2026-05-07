import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../models/feed_models.dart';
import 'feed_widgets.dart';

class CommentsSheet extends StatefulWidget {
  final Post post;
  final void Function(String) onAddComment;
  final void Function(String commentId) onLikeComment;

  const CommentsSheet({
    super.key,
    required this.post,
    required this.onAddComment,
    required this.onLikeComment,
  });

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final _ctrl = TextEditingController();
  String? _replyingTo;
  String? _replyingName;
  final _focus = FocusNode();

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.post;
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      maxChildSize: 0.95,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle + header
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.kBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Row(
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(
                      color: AppColors.kText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.kSubText,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.kBorder),

            // Comments list
            Expanded(
              child: p.comments.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('💬', style: TextStyle(fontSize: 40)),
                          SizedBox(height: 10),
                          Text(
                            'No comments yet.\nBe the first to comment!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.kSubText,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: scrollCtrl,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: p.comments.length,
                      itemBuilder: (_, i) => _CommentTile(
                        comment: p.comments[i],
                        onReply: (id, name) {
                          setState(() {
                            _replyingTo = id;
                            _replyingName = name;
                          });
                          _focus.requestFocus();
                        },
                        onLike: (id) {
                          widget.onLikeComment(id);
                          setState(() {});
                        },
                      ),
                    ),
            ),

            // Reply banner
            if (_replyingTo != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: AppColors.kPrimary.withValues(alpha: 0.1),
                child: Row(
                  children: [
                    Text(
                      'Replying to $_replyingName',
                      style: const TextStyle(
                        color: AppColors.kGreenLight,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => setState(() {
                        _replyingTo = null;
                        _replyingName = null;
                      }),
                      child: const Icon(
                        Icons.close_rounded,
                        color: AppColors.kSubText,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),

            // Input bar
            Container(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.kBorder)),
                color: AppColors.kWhite,
              ),
              child: Row(
                children: [
                  buildAvatar('🧑', 34),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kBg,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: AppColors.kBorder),
                      ),
                      child: TextField(
                        controller: _ctrl,
                        focusNode: _focus,
                        style: const TextStyle(
                          color: AppColors.kText,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Write a comment...',
                          hintStyle: TextStyle(
                            color: AppColors.kSubText,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _ctrl.text.trim().isEmpty
                        ? null
                        : () {
                            widget.onAddComment(_ctrl.text.trim());
                            _ctrl.clear();
                            setState(() {
                              _replyingTo = null;
                              _replyingName = null;
                            });
                          },
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _ctrl.text.trim().isNotEmpty
                            ? AppColors.kPrimary
                            : AppColors.kPrimary.withValues(alpha: 0.3),
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: AppColors.kTextWhite,
                        size: 18,
                      ),
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
}

// ─── Comment tile ─────────────────────────────────────────────────────────────
class _CommentTile extends StatefulWidget {
  final Comment comment;
  final void Function(String id, String name) onReply;
  final void Function(String id) onLike;

  const _CommentTile({
    required this.comment,
    required this.onReply,
    required this.onLike,
  });

  @override
  State<_CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<_CommentTile> {
  bool _showReplies = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.comment;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAvatar(c.userEmoji, 34),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  decoration: BoxDecoration(
                    color: AppColors.kBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.kBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.userName,
                        style: const TextStyle(
                          color: AppColors.kText,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        c.text,
                        style: const TextStyle(
                          color: AppColors.kText,
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      c.timeAgo,
                      style: const TextStyle(
                        color: AppColors.kSubText,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 14),
                    GestureDetector(
                      onTap: () {
                        widget.onLike(c.id);
                      },
                      child: Text(
                        c.liked ? 'Liked' : 'Like',
                        style: TextStyle(
                          color: c.liked
                              ? AppColors.kPrimary
                              : AppColors.kSubText,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (c.likes > 0) ...[
                      const SizedBox(width: 4),
                      Text(
                        '· ${c.likes}',
                        style: const TextStyle(
                          color: AppColors.kSubText,
                          fontSize: 11,
                        ),
                      ),
                    ],
                    const SizedBox(width: 14),
                    GestureDetector(
                      onTap: () => widget.onReply(c.id, c.userName),
                      child: const Text(
                        'Reply',
                        style: TextStyle(
                          color: AppColors.kSubText,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Replies
                if (c.replies.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => setState(() => _showReplies = !_showReplies),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 1,
                          color: AppColors.kBorder,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _showReplies
                              ? 'Hide ${c.replies.length} ${c.replies.length == 1 ? 'reply' : 'replies'}'
                              : 'Show ${c.replies.length} ${c.replies.length == 1 ? 'reply' : 'replies'}',
                          style: const TextStyle(
                            color: AppColors.kGreenLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_showReplies)
                    ...c.replies.map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildAvatar(r.userEmoji, 28),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                      10,
                                      8,
                                      10,
                                      8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.kBg,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColors.kBorder,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          r.userName,
                                          style: const TextStyle(
                                            color: AppColors.kText,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          r.text,
                                          style: const TextStyle(
                                            color: AppColors.kText,
                                            fontSize: 12.5,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text(
                                        r.timeAgo,
                                        style: const TextStyle(
                                          color: AppColors.kSubText,
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          widget.onLike(r.id);
                                        },
                                        child: Text(
                                          r.liked ? 'Liked' : 'Like',
                                          style: TextStyle(
                                            color: r.liked
                                                ? AppColors.kGreenLight
                                                : AppColors.kSubText,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
