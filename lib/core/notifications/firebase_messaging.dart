import 'dart:developer';

import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/app/injector.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/notifications/local_notifications.dart';

class FirebaseNotifications {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  /// Initialize Firebase Messaging
  static Future<void> initialize() async {
    try {
      // Request FCM Permissions
      await _handleNotificationPermissions();

      // Fetch FCM Token and save to local storage
      final token = await _fcm.getToken();
      if (token != null)
        await serviceLocator<IAppLocalStorage>()
            .setValue(AppStrings.fcmToken, token);

      // Subscribe to default topic
      await subscribeToTopic('AllUsers');

      // Handle initial notification when app launches
      final initialMessage = await _fcm.getInitialMessage();
      if (initialMessage != null) _handleNotificationTap(initialMessage);

      // Set up notification listeners
      FirebaseMessaging.onMessage.listen(_handleNotificationForeground);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
      FirebaseMessaging.onBackgroundMessage(_handleNotificationBackground);
    } catch (e) {
      log('Error initializing Firebase Messaging: $e');
    }
  }

  /// Request notification permissions
  static Future<void> _handleNotificationPermissions() async {
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: false,
      provisional: false,
      announcement: false,
      criticalAlert: false,
    );
  }

  /// Handle notification tap
  static Future<void> _handleNotificationTap(RemoteMessage msg) async {
    navigatorKey.currentState?.context.navigateTo(Routes.notificationScreen);
  }

  /// Handle notification when app is in the foreground
  static Future<void> _handleNotificationForeground(RemoteMessage msg) async {
    await LocalNotificationService.displayNotification(msg);
  }

  /// Handle notification when app is in the background
  @pragma('vm:entry-point')
  static Future<void> _handleNotificationBackground(RemoteMessage msg) async {}

  /// Subscribe to a topic
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _fcm.subscribeToTopic(topic);
      log('Subscribed to topic: $topic');
    } catch (e) {
      log('Failed to subscribe to topic $topic: $e');
    }
  }

  /// Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _fcm.unsubscribeFromTopic(topic);
      log('Unsubscribed from topic: $topic');
    } catch (e) {
      log('Failed to unsubscribe from topic $topic: $e');
    }
  }
}
