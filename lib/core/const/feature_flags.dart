// Toggle any notification feature on/off without deleting code.
// In production, these can come from remote config.

class FeatureFlags {
  FeatureFlags._();

  // ── Core ────────────────────────────────────────────────
  static const bool fcmEnabled = true;
  static const bool tokenAutoRefresh = true;
  static const bool sendTokenToBackend = true;

  // ── Notification Types ───────────────────────────────────
  static const bool basicNotifications = true;
  static const bool richNotifications = true; // image support
  static const bool silentNotifications = true; // data-only
  static const bool scheduledNotifications = true;

  // ── Targeting ───────────────────────────────────────────
  static const bool topicSubscriptions = true;
  static const bool userSpecificPush = true;

  // ── UX ──────────────────────────────────────────────────
  static const bool foregroundNotificationUI = true;
  static const bool deepLinkingEnabled = true;
  static const bool inAppNotificationCenter = true;

  // ── Analytics ───────────────────────────────────────────
  static const bool notificationAnalytics = true;
  static const bool sendAnalyticsToBackend = true;
}
