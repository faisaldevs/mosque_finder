import 'package:flutter/material.dart';

import '../models/feed_models.dart';

// ─── Reactions constants ───────────────────────────────────────────────────────
const List<Reaction> feedReactions = [
  Reaction(emoji: '👍', label: 'Like', colorHex: '#2196F3'),
  Reaction(emoji: '❤️', label: 'Love', colorHex: '#E53935'),
  Reaction(emoji: '🤲', label: 'Dua', colorHex: '#9C27B0'),
  Reaction(emoji: '🕌', label: 'MashaAllah', colorHex: '#4CAF50'),
  Reaction(emoji: '😢', label: 'Sad', colorHex: '#FF9800'),
];

// ─── Sample posts ──────────────────────────────────────────────────────────────
List<Post> _generateSamplePosts() => [
  Post(
    id: '1',
    userName: 'Faisal Ahmed',
    userEmoji: '🧑',
    timeAgo: '2 min ago',
    text:
        'SubhanAllah, just finished my Fajr prayer at Baitul Mukarram. '
        'The atmosphere this morning was truly peaceful. 🤲',
    postType: 'prayer',
    typeContent: 'Fajr Prayer',
    likes: 24,
    loves: 12,
    duas: 8,
    mashallahs: 31,
    commentCount: 7,
    shares: 3,
    comments: [
      Comment(
        id: 'c1',
        userName: 'Aisha Binte Omar',
        userEmoji: '👩',
        text: 'MashaAllah, may Allah accept your prayers! 🕌',
        timeAgo: '1 min ago',
        likes: 5,
        replies: [
          Comment(
            id: 'r1',
            userName: 'Faisal Ahmed',
            userEmoji: '🧑',
            text: 'Ameen! JazakAllahu Khayran sister 🤲',
            timeAgo: 'Just now',
            likes: 2,
          ),
        ],
      ),
      Comment(
        id: 'c2',
        userName: 'Ibrahim Al-Rashid',
        userEmoji: '👨',
        text: 'Alhamdulillah! Keep it up brother.',
        timeAgo: '1 min ago',
        likes: 3,
      ),
    ],
  ),
  Post(
    id: '2',
    userName: 'Aisha Binte Omar',
    userEmoji: '👩',
    timeAgo: '15 min ago',
    postType: 'quran',
    typeContent:
        '﴾ Indeed, with hardship will be ease. ﴿\n— Surah Ash-Sharh (94:6)',
    text:
        'This ayah has been getting me through tough times lately. '
        'May Allah grant us all ease. Ameen. 💚',
    likes: 87,
    loves: 45,
    duas: 62,
    mashallahs: 91,
    sads: 4,
    commentCount: 14,
    shares: 29,
    comments: [
      Comment(
        id: 'c3',
        userName: 'Omar Farooq',
        userEmoji: '🧔',
        text: 'Ameen ya Rabb! This ayah hits different every time.',
        timeAgo: '10 min ago',
        likes: 7,
      ),
      Comment(
        id: 'c4',
        userName: 'Zainab Hassan',
        userEmoji: '🧕',
        text: 'JazakAllahu Khayran for sharing 🤲',
        timeAgo: '8 min ago',
        likes: 4,
      ),
    ],
  ),
  Post(
    id: '3',
    userName: 'Omar Farooq',
    userEmoji: '🧔',
    timeAgo: '1 hr ago',
    imageAsset: '🕌',
    text:
        'Just checked in at Baitul Mukarram Mosque. Friday prayers were incredible today, '
        'the khutbah was about the importance of community in Islam.',
    postType: 'checkin',
    typeContent: '📍 Baitul Mukarram National Mosque',
    likes: 156,
    loves: 78,
    duas: 23,
    mashallahs: 210,
    commentCount: 21,
    shares: 15,
    comments: [
      Comment(
        id: 'c5',
        userName: 'Faisal Ahmed',
        userEmoji: '🧑',
        text: 'MashaAllah what a beautiful mosque!',
        timeAgo: '45 min ago',
        likes: 9,
      ),
    ],
  ),
  Post(
    id: '4',
    userName: 'Zainab Hassan',
    userEmoji: '🧕',
    timeAgo: '3 hrs ago',
    postType: 'hadith',
    typeContent:
        '"The best of people are those that bring most benefit to the rest of mankind."\n— Prophet Muhammad ﷺ (Daraqutni)',
    text:
        'A reminder for all of us today. How are you bringing benefit to those around you? 🌟',
    likes: 203,
    loves: 134,
    duas: 89,
    mashallahs: 178,
    sads: 2,
    commentCount: 33,
    shares: 67,
    comments: [
      Comment(
        id: 'c6',
        userName: 'Ibrahim Al-Rashid',
        userEmoji: '👨',
        text:
            'BarakAllahu feek for this reminder! Sharing this with my family.',
        timeAgo: '2 hrs ago',
        likes: 12,
      ),
      Comment(
        id: 'c7',
        userName: 'Aisha Binte Omar',
        userEmoji: '👩',
        text: 'This is so beautiful SubhanAllah 💚',
        timeAgo: '2 hrs ago',
        likes: 8,
      ),
    ],
  ),
  Post(
    id: '5',
    userName: 'Ibrahim Al-Rashid',
    userEmoji: '👨',
    timeAgo: '5 hrs ago',
    imageAsset: '🌙',
    text:
        'Beautiful sunset at Dhaka today. A reminder of the greatness of Allah\'s creation. '
        'SubhanAllah walhamdulillah wa la ilaha illallah wallahu akbar 🌅',
    likes: 312,
    loves: 189,
    duas: 45,
    mashallahs: 267,
    sads: 1,
    commentCount: 42,
  ),
];

// ─── Feed ViewModel (Provider) ─────────────────────────────────────────────────
class FeedViewModel extends ChangeNotifier {
  final List<Post> _posts = _generateSamplePosts();

  List<Post> get posts => _posts;

  void reactToPost(String postId, int reactionIdx) {
    final post = _posts.firstWhere((p) => p.id == postId);
    post.applyReaction(reactionIdx);
    notifyListeners();
  }

  void sharePost(String postId) {
    final post = _posts.firstWhere((p) => p.id == postId);
    post.shares++;
    notifyListeners();
  }

  void addComment(String postId, String commentText) {
    final post = _posts.firstWhere((p) => p.id == postId);
    post.comments.insert(
      0,
      Comment(
        id: DateTime.now().toString(),
        userName: 'Faisal Ahmed',
        userEmoji: '🧑',
        text: commentText,
        timeAgo: 'Just now',
      ),
    );
    post.commentCount++;
    notifyListeners();
  }

  void addPost(Post post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  void likeComment(String postId, String commentId) {
    final post = _posts.firstWhere((p) => p.id == postId);
    final comment = post.comments.firstWhere((c) => c.id == commentId);
    comment.liked = !comment.liked;
    comment.likes += comment.liked ? 1 : -1;
    notifyListeners();
  }
}
