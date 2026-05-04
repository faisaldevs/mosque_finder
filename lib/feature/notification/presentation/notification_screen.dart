import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

// ─── Notification Type ────────────────────────────────────────────────────────
enum NotifType { prayer, donation, event, announcement, reminder, system }

// ─── Notification Model ───────────────────────────────────────────────────────
class AppNotification {
  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final NotifType type;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.type,
    this.isRead = false,
  });
}

// ─── Sample Data ──────────────────────────────────────────────────────────────
List<AppNotification> _buildNotifications() => [
  AppNotification(
    id: '1',
    title: 'Fajr Prayer Time',
    body: 'Fajr prayer starts in 10 minutes. Time to prepare for Salah.',
    timeAgo: 'Just now',
    type: NotifType.prayer,
    isRead: false,
  ),
  AppNotification(
    id: '2',
    title: 'Donation Received 🎉',
    body:
        'Your donation of \$25.00 to "Build New Masjid" was successfully processed.',
    timeAgo: '5m ago',
    type: NotifType.donation,
    isRead: false,
  ),
  AppNotification(
    id: '3',
    title: 'Friday Khutbah Reminder',
    body:
        'Jumu\'ah prayer at Islamic Center begins at 1:15 PM today. Don\'t be late!',
    timeAgo: '30m ago',
    type: NotifType.reminder,
    isRead: false,
  ),
  AppNotification(
    id: '4',
    title: 'New Event: Eid Celebration',
    body:
        'The annual Eid Al-Adha celebration will be held at the main grounds on June 16th.',
    timeAgo: '2h ago',
    type: NotifType.event,
    isRead: true,
  ),
  AppNotification(
    id: '5',
    title: 'Campaign Update',
    body:
        '"Orphan Support Program" has reached 80% of its goal. Help us cross the finish line!',
    timeAgo: '3h ago',
    type: NotifType.donation,
    isRead: true,
  ),
  AppNotification(
    id: '6',
    title: 'Mosque Closed Tomorrow',
    body:
        'The mosque will be closed for maintenance on Saturday. Prayers will resume Sunday.',
    timeAgo: 'Yesterday',
    type: NotifType.announcement,
    isRead: true,
  ),
  AppNotification(
    id: '7',
    title: 'Quran Class This Weekend',
    body:
        'Weekly Quran recitation class starts Saturday at 10:00 AM. All levels welcome.',
    timeAgo: 'Yesterday',
    type: NotifType.event,
    isRead: true,
  ),
  AppNotification(
    id: '8',
    title: 'Zakat Reminder',
    body:
        'Have you paid your Zakat Al-Mal this year? Calculate and donate through the app.',
    timeAgo: '2 days ago',
    type: NotifType.reminder,
    isRead: true,
  ),
  AppNotification(
    id: '9',
    title: 'App Update Available',
    body:
        'Version 2.1 is available with new features including Qibla direction and Quran audio.',
    timeAgo: '3 days ago',
    type: NotifType.system,
    isRead: true,
  ),
];

// ─── Type config helpers ──────────────────────────────────────────────────────
extension NotifTypeX on NotifType {
  Color get color {
    switch (this) {
      case NotifType.prayer:
        return AppColors.kGreen;
      case NotifType.donation:
        return AppColors.kGold;
      case NotifType.event:
        return AppColors.kBlueLight;
      case NotifType.announcement:
        return AppColors.kOrange;
      case NotifType.reminder:
        return AppColors.kTeal;
      case NotifType.system:
        return AppColors.kSubText;
    }
  }

  IconData get icon {
    switch (this) {
      case NotifType.prayer:
        return Icons.mosque_rounded;
      case NotifType.donation:
        return Icons.favorite_rounded;
      case NotifType.event:
        return Icons.event_rounded;
      case NotifType.announcement:
        return Icons.campaign_rounded;
      case NotifType.reminder:
        return Icons.alarm_rounded;
      case NotifType.system:
        return Icons.settings_rounded;
    }
  }

  String get label {
    switch (this) {
      case NotifType.prayer:
        return 'Prayer';
      case NotifType.donation:
        return 'Donation';
      case NotifType.event:
        return 'Event';
      case NotifType.announcement:
        return 'Announcement';
      case NotifType.reminder:
        return 'Reminder';
      case NotifType.system:
        return 'System';
    }
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// NotificationScreen
// ═════════════════════════════════════════════════════════════════════════════
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<AppNotification> _notifications = _buildNotifications();

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  // void _markAllRead() {
  //   setState(() {
  //     for (final n in _notifications) {
  //       n.isRead = true;
  //     }
  //   });
  // }

  void _markRead(String id) {
    setState(() {
      _notifications.firstWhere((n) => n.id == id).isRead = true;
    });
  }

  void _delete(String id) {
    setState(() => _notifications.removeWhere((n) => n.id == id));
  }

  List<AppNotification> get _todayNotifs => _notifications
      .where(
        (n) =>
            n.timeAgo.contains('now') ||
            n.timeAgo.contains('m ago') ||
            n.timeAgo.contains('h ago'),
      )
      .toList();

  List<AppNotification> get _earlierNotifs => _notifications
      .where((n) => n.timeAgo == 'Yesterday' || n.timeAgo.contains('days ago'))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: _notifications.isEmpty
                ? _buildEmpty()
                : ListView(
                    padding: const EdgeInsets.only(bottom: 32),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      if (_todayNotifs.isNotEmpty) ...[
                        _buildSectionLabel('Today', _unreadCount),
                        ..._todayNotifs.map(_buildNotifTile),
                      ],
                      if (_earlierNotifs.isNotEmpty) ...[
                        _buildSectionLabel('Earlier', null),
                        ..._earlierNotifs.map(_buildNotifTile),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).padding.top + 16,
            20,
            28,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button row
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  // const Spacer(),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (_unreadCount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kError,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$_unreadCount new',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _unreadCount > 0
                            ? 'You have $_unreadCount unread notification${_unreadCount > 1 ? 's' : ''}'
                            : 'You\'re all caught up!',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              // // Mosque icon
              // Container(
              //   width: 56,
              //   height: 56,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Colors.white.withValues(alpha: 0.15),
              //     border: Border.all(
              //       color: Colors.white.withValues(alpha: 0.3),
              //       width: 1.5,
              //     ),
              //   ),
              //   child: const Center(
              //     child: Text('🕌', style: TextStyle(fontSize: 28)),
              //   ),
              // ),
              const SizedBox(height: 14),
            ],
          ),
        ),
        // Decorative circles
        Positioned(top: -30, right: -30, child: _circle(160)),
        Positioned(top: 20, right: 60, child: _circle(90)),
      ],
    );
  }

  Widget _circle(double size) => SizedBox(
    width: size,
    height: size,
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1.5,
        ),
      ),
    ),
  );

  // ── Section label ───────────────────────────────────────────────────────────
  Widget _buildSectionLabel(String label, int? badge) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.kText,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (badge != null && badge > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.kError,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$badge',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Notification tile ───────────────────────────────────────────────────────
  Widget _buildNotifTile(AppNotification notif) {
    return Dismissible(
      key: Key(notif.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        decoration: BoxDecoration(
          color: AppColors.kError.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kError.withValues(alpha: 0.3)),
        ),
        child: const Icon(Icons.delete_rounded, color: AppColors.kError),
      ),
      onDismissed: (_) => _delete(notif.id),
      child: GestureDetector(
        onTap: () => _markRead(notif.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: notif.isRead
                ? AppColors.kCard
                : AppColors.kCard.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: notif.isRead
                  ? AppColors.kBorder
                  : notif.type.color.withValues(alpha: 0.4),
              width: notif.isRead ? 1 : 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon circle
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: notif.type.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: notif.type.color.withValues(alpha: 0.3),
                  ),
                ),
                child: Icon(notif.type.icon, color: notif.type.color, size: 22),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notif.title,
                            style: TextStyle(
                              color: AppColors.kText,
                              fontSize: 14,
                              fontWeight: notif.isRead
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Unread dot
                        if (!notif.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: notif.type.color,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notif.body,
                      style: const TextStyle(
                        color: AppColors.kSubText,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Type badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: notif.type.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: notif.type.color.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            notif.type.label,
                            style: TextStyle(
                              color: notif.type.color,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          notif.timeAgo,
                          style: const TextStyle(
                            color: AppColors.kSubText,
                            fontSize: 11.5,
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
    );
  }

  // ── Empty state ─────────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kCard,
              border: Border.all(color: AppColors.kBorder),
            ),
            child: const Icon(
              Icons.notifications_off_rounded,
              color: AppColors.kSubText,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No notifications',
            style: TextStyle(
              color: AppColors.kText,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'You\'re all caught up!\nCheck back later.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.kSubText,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
