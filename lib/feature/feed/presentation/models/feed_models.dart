/// Feed feature models for posts, comments, and reactions
library;

// ─── Reaction model ───────────────────────────────────────────────────────────
class Reaction {
  final String emoji;
  final String label;
  final String colorHex;

  const Reaction({
    required this.emoji,
    required this.label,
    required this.colorHex,
  });
}

// ─── Post model ───────────────────────────────────────────────────────────────
class Post {
  final String id;
  final String userName;
  final String userEmoji;
  final String timeAgo;
  final String? text;
  final String? imageAsset;
  final String? postType; // 'quran' | 'hadith' | 'checkin' | 'prayer' | null
  final String? typeContent;
  int reactionIndex; // -1 = none
  int likes;
  int loves;
  int duas;
  int mashallahs;
  int sads;
  int commentCount;
  int shares;
  List<Comment> comments;
  String? privacy;

  Post({
    required this.id,
    required this.userName,
    required this.userEmoji,
    required this.timeAgo,
    this.text,
    this.imageAsset,
    this.postType,
    this.typeContent,
    this.reactionIndex = -1,
    this.likes = 0,
    this.loves = 0,
    this.duas = 0,
    this.mashallahs = 0,
    this.sads = 0,
    this.commentCount = 0,
    this.shares = 0,
    this.privacy = 'Public',
    List<Comment>? comments,
  }) : comments = comments ?? [];

  int get totalReactions => likes + loves + duas + mashallahs + sads;

  void applyReaction(int idx) {
    // remove old reaction
    if (reactionIndex == 0) likes--;
    if (reactionIndex == 1) loves--;
    if (reactionIndex == 2) duas--;
    if (reactionIndex == 3) mashallahs--;
    if (reactionIndex == 4) sads--;

    // toggle off if same reaction
    if (idx == reactionIndex) {
      reactionIndex = -1;
      return;
    }

    // apply new reaction
    reactionIndex = idx;
    if (idx == 0) likes++;
    if (idx == 1) loves++;
    if (idx == 2) duas++;
    if (idx == 3) mashallahs++;
    if (idx == 4) sads++;
  }
}

// ─── Comment model ────────────────────────────────────────────────────────────
class Comment {
  final String id;
  final String userName;
  final String userEmoji;
  final String text;
  final String timeAgo;
  int likes;
  bool liked;
  List<Comment> replies;

  Comment({
    required this.id,
    required this.userName,
    required this.userEmoji,
    required this.text,
    required this.timeAgo,
    this.likes = 0,
    this.liked = false,
    List<Comment>? replies,
  }) : replies = replies ?? [];
}

// ─── Post Type Option ─────────────────────────────────────────────────────────
class PostTypeOption {
  final String id;
  final String emoji;
  final String label;
  final String colorHex;

  const PostTypeOption({
    required this.id,
    required this.emoji,
    required this.label,
    required this.colorHex,
  });
}
