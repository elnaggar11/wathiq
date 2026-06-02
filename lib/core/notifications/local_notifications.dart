import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/features/paegs/data/models/notification_model.dart';

class LocalNotificationService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    try {
      final androidPlugin =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (Platform.isAndroid && androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
      }
      const initialSettings = InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      );
      await _notificationsPlugin.initialize(
        initialSettings,
        onDidReceiveNotificationResponse: receiveNotification,
        onDidReceiveBackgroundNotificationResponse: receiveNotification,
      );
      log('Notification service initialized successfully.');
    } catch (e) {
      log('Error initializing notification service: $e');
    }
  }

  static String convertJsonFormat(String? jsonStr) {
    return jsonStr?.replaceAllMapped(
          RegExp(r'(\w+)(\s*:\s*)(\w+)'),
          (match) {
            String key = match.group(1)!;
            String colon = match.group(2)!;
            String value = match.group(3)!;
            bool isNumeric = double.tryParse(value) != null;
            bool isBoolean = value == 'true' || value == 'false';
            if (!isNumeric && !isBoolean) value = '"$value"';
            return '"$key"$colon$value';
          },
        ) ??
        '{}';
  }

  static void navigateNotification(Map<String, dynamic> data) {
    log('Navigating with data: $data');
    navigatorKey.currentState?.context.navigateTo(Routes.notificationScreen);
  }

  static void receiveNotification(NotificationResponse response) {
    if (response.payload != null) {
      Map<String, dynamic> data = jsonDecode(response.payload!);
      navigateNotification(data);
    }
  }

  static Future<void> displayNotification(RemoteMessage message) async {
    try {
      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const notificationDetails = NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
        android: AndroidNotificationDetails(
          'PushNotificationApp',
          'PushNotificationAppChannel',
          priority: Priority.high,
          importance: Importance.max,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title ?? '',
        message.notification!.body ?? '',
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } catch (e) {
      log('Error creating and displaying notification: $e');
    }
  }

  static void displayPopNotification(NotificationModel notification) {
    displayNotification(
      RemoteMessage(
        notification: RemoteNotification(
          title: notification.title,
          body: notification.message,
          android: AndroidNotification(
            imageUrl: notification.sender?.profileImage,
          ),
          apple: AppleNotification(
            imageUrl: notification.sender?.profileImage,
          ),
        ),
      ),
    );
  }
}
