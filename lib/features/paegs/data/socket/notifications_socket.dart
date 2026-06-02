import 'dart:async';

import '../../../../core/network/socket/socket_end_points.dart';
import '../../../../core/network/socket/socket_service.dart';
import '../../../../core/notifications/local_notifications.dart';
import '../models/notification_model.dart';

class NotificationsSocket {
  static final NotificationsSocket _instance = NotificationsSocket._internal();

  factory NotificationsSocket() => _instance;

  NotificationsSocket._internal();

  /// Socket Service
  final SocketService _socket = SocketService();

  /// Stream Controllers
  final _unReadCountController = StreamController<int>.broadcast();
  final StreamController<NotificationModel> _newNotificationController =
      StreamController<NotificationModel>.broadcast();

  /// Public Streams
  Stream<int> get unReadCountStream => _unReadCountController.stream;

  Stream<NotificationModel> get newNotificationStream =>
      _newNotificationController.stream;

  /// Ensure socket connection
  Future<void> _ensureSocketConnected() async => await _socket.connect();

  Future<void> listenEvents() async {
    getUnReadCount();
    listenToNewNotifications();
  }

  /// Get Unread Notifications Count
  Future<void> getUnReadCount() async {
    await _ensureSocketConnected();
    _socket.onEvent(SocketEndPoints.UNREAD_COUNT, (data) {
      final count = int.tryParse('${data['count']}') ?? 0;
      _unReadCountController.add(count);
    });
  }

  Future<void> emitUnReadCount() async {
    _socket.emitEvent(SocketEndPoints.GET_UNREAD_COUNT);
  }

  /// Listen for New Notifications
  Future<void> listenToNewNotifications() async {
    await _ensureSocketConnected();
    _socket.onEvent(SocketEndPoints.NOTIFICATION, (data) {
      if (data != null) {
        final notification = NotificationModel.fromJson(data);
        LocalNotificationService.displayPopNotification(notification);
        _newNotificationController.add(notification);
      }
    });
  }

  /// Specific Notification Actions
  Future<void> deliverNotification() async {
    await _ensureSocketConnected();
    await _socket.emitEvent(SocketEndPoints.DELIVER_NOTIFICATION);
  }

  Future<void> archiveNotification(String id) async {
    await _ensureSocketConnected();
    await _socket.emitEvent(
      SocketEndPoints.ARCHIVE_NOTIFICATION,
      data: {'notificationId': id},
    );
  }

  Future<void> unArchiveNotification(String id) async {
    await _ensureSocketConnected();
    await _socket.emitEvent(
      SocketEndPoints.UNARCHIVE_NOTIFICATION,
      data: {'notificationId': id},
    );
  }

  Future<void> readNotification(String id) async {
    await _ensureSocketConnected();
    await _socket.emitEvent(
      SocketEndPoints.READ_NOTIFICATION,
      data: {'notificationId': id},
    );
  }

  Future<void> unReadNotification(String id) async {
    await _ensureSocketConnected();
    await _socket.emitEvent(
      SocketEndPoints.UNREAD_NOTIFICATION,
      data: {'notificationId': id},
    );
  }

  /// Dispose Stream Controllers
  void dispose() {
    _unReadCountController.close();
    _newNotificationController.close();
  }
}
