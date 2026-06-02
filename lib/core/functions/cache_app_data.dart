import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app/injector.dart';
import '../storage/i_app_local_storage.dart';

Future<void> cacheAppData() async {
  try {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    Map<String, dynamic> deviceInfo = {};

    // Determine platform and fetch device-specific details
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceInfo = {
        'platform': 'android',
        'manufacturer': androidInfo.manufacturer,
        'model': androidInfo.model,
        'osVersion': androidInfo.version.release,
        'deviceId': androidInfo.id,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceInfo = {
        'platform': 'ios',
        'manufacturer': 'Apple',
        'model': iosInfo.utsname.machine,
        'osVersion': iosInfo.systemVersion,
        'deviceId': iosInfo.identifierForVendor,
      };
    }

    // Cache data
    await serviceLocator<IAppLocalStorage>().setValue('lang', 'ar');
    await serviceLocator<IAppLocalStorage>().setValue('packageInfo', {
      'version': packageInfo.version,
    });
    await serviceLocator<IAppLocalStorage>().setValue('deviceInfo', deviceInfo);

    debugPrint('Dynamic app data cached successfully');
  } catch (e) {
    debugPrint('Error caching dynamic app data: $e');
  }
}
