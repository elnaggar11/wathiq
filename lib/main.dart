import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/app/app.dart';
import 'package:wathiq/app/injector.dart';
import 'package:wathiq/core/functions/cache_app_data.dart';

import 'package:wathiq/core/network/socket/socket_service.dart';
import 'package:wathiq/core/notifications/local_notifications.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupServiceLocator();
    await cacheAppData();

    /// NOTIFICATIONS
    // await FirebaseNotifications.initialize();
    await LocalNotificationService.initialize();

    /// SOCKET IO INIT
    await SocketService().initialize();
  } catch (e) {
    print('Error in initialization: $e');
  }

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ));
}
