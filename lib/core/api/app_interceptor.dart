import 'dart:convert'; // Import for JSON decoding
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/core/api/end_point.dart';

import 'package:wathiq/app/injector.dart';
import 'package:wathiq/core/network/socket/socket_service.dart';
import 'package:wathiq/core/storage/flutter_secure_storage.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/utils.dart';
import 'package:wathiq/core/widgets/guest_dialog.dart';
import 'package:wathiq/core/api/status_code.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    // Fetch data from local storage
    // var cashedCookie =
    //     serviceLocator<IAppLocalStorage>().getValue(AppStrings.cookie) ?? '';
    // print('cashedCookie cookie $cashedCookie');
    var packageInfoJson =
        serviceLocator<IAppLocalStorage>().getValue('packageInfo');
    var deviceInfoJson =
        serviceLocator<IAppLocalStorage>().getValue('deviceInfo');
    var lang = serviceLocator<IAppLocalStorage>().getValue('lang') ??
        'en'; // Default to 'en' if not found

    Map<String, dynamic>? packageInfo;
    Map<String, dynamic>? deviceInfo;

    // Parse packageInfo JSON if it exists
    if (packageInfoJson != null) {
      try {
        packageInfo = jsonDecode(packageInfoJson) as Map<String, dynamic>;
      } catch (e) {
        debugPrint('Error parsing packageInfo: $e');
      }
    }

    // Parse deviceInfo JSON if it exists
    if (deviceInfoJson != null) {
      try {
        deviceInfo = jsonDecode(deviceInfoJson) as Map<String, dynamic>;
      } catch (e) {
        debugPrint('Error parsing deviceInfo: $e');
      }
    }

    // If this is a POST request and KisAnonymous is true, show a guest dialog
    if (options.method.toUpperCase() == 'POST' &&
        GlobalVar.KisAnonymous == true) {
      debugPrint(
          'This is a POST request and KisAnonymous is true. Showing guest dialog.');
      showGuestDialog();
      return; // Stop the request
    }

    // Set base URL, response type, and other settings
    options
      ..getCacheOptions()
      ..baseUrl = EndPoint.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internetServerError;
      }
      ..sendTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 60)
      ..headers = {
        AppStrings.contentType: AppStrings.applicationJson,
        'Accept': 'application/json',
      };
    final String? cookie =
        await SecureStorageServices().getCookie().then((value) => value);
    // if (cookie != null) {
    options.headers['Cookie'] =
        'broker_sa_session=s%3Ae_z_Ls6ATqfqLzXaPRWCCkJMTQppZ_kZ.1dREktv%2BQoygPQbMDP4jhKeG39fr%2FyOI0e%2Fk0MU6V9M'; //cookie;
    print('cashed coocke $cookie');
    // }

    /// 191353 / Aa@1235678
    options.headers.addAll({
      // 'lang': lang,
      /// Add Cookie here if needed
      // if (packageInfo != null && packageInfo.containsKey('version'))
      //   'x-app-version': packageInfo['version'].toString(),
      // if (deviceInfo != null) ...{
      //   'x-platform': deviceInfo['platform'],
      //   'x-device-manufacturer': deviceInfo['manufacturer'],
      //   'x-device-model': deviceInfo['model'],
      //   'x-os-version': deviceInfo['osVersion'],
      //   'x-device-id': deviceInfo['deviceId'],
      // },
    });

    debugPrint('options.headers: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // if ((response.statusCode == 401)) {
    //   navigatorKey.currentState?.pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (_) => LoginScreen()),
    //     (route) => false,
    //   );
    // }
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    debugPrint('RESPONSE HEADERS: ${response.headers}');

    // List<String>? cookies = response.headers['set-cookie'];
    // print("response.headers['set-cookie'] ${response.headers['set-cookie']}");
    // if (cookies != null && cookies.isNotEmpty) {
    //   String? connectSid = cookies // cookies.first;
    //       .firstWhere(
    //         (cookie) => cookie.startsWith('connect.sid='),
    //         orElse: () => '',
    //       )
    //       .split(';')
    //       .firstWhere(
    //         (segment) => segment.trim().startsWith('connect.sid='),
    //         orElse: () => '',
    //       )
    //       .trim();
    if (response.headers['set-cookie'] != null) {
      await SecureStorageServices()
          .setCookie(cookie: response.headers['set-cookie']?.first);

      log('login cookie ${response.headers['set-cookie']!}');
      log('data ${response.data}');
      String? connectSid = await SecureStorageServices().getCookie();
      SocketService().token = connectSid;
      debugPrint('connect.sid saved: $connectSid');
      print('Now Start cashe coocke $connectSid');
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
