import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../app/injector.dart';
import '../../../features/home/data/socket/auction_board_socket.dart';
import '../../../features/paegs/data/socket/notifications_socket.dart';
import '../../storage/flutter_secure_storage.dart';
import '../../storage/i_app_local_storage.dart';
import '../../utils/app_strings.dart';
import 'socket_end_points.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  String? _lang;
  String? _token;
  io.Socket? _socket;

  /// Initialize the service with defaults
  Future<void> initialize() async {
    try {
      await _loadDefaults();
      await _setupSocket();
    } catch (e) {
      print('Error initializing socket: $e');
    }
  }

  /// Load cached defaults like language and token
  Future<void> _loadDefaults() async {
    try {
      _lang =
          await serviceLocator<IAppLocalStorage>().getValue(AppStrings.lang);
      _token = await SecureStorageServices().getCookie().then((value) => value);
    } catch (e) {
      print('Error loading defaults: $e');
      _lang = null;
      _token = null;
    }
  }

  /// Initialize and configure the socket connection
  Future<void> _setupSocket() async {
    await disconnect();
    _socket = io.io(
      SocketEndPoints.BASE_URL,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setQuery({if (_lang != null) "lang": _lang})
          .setExtraHeaders({if (_token != null) 'Cookie': _token})
          .build(),
    );
    _socket?.io.options?['extraHeaders'] = {
      if (_token != null) 'Cookie': _token,
    };
    _registerSocketEvents();
    _socket?.connect();
  }

  /// Setter for token
  set token(String? newToken) {
    _token = newToken;
    debugPrint("Token updated: $_token");
    _setupSocket();
  }

  /// Connect to socket if not already connected
  Future<void> connect() async {
    if (_socket == null || !_socket!.connected) {
      await _setupSocket();
      debugPrint("Connecting socket...");
    }
  }

  /// Register default socket events
  void _registerSocketEvents() {
    _socket?.onConnect((data) async {
      debugPrint('Socket.IO Connected');
      _loadDefaults();
      if (_token?.isNotEmpty ?? false) {
        debugPrint('Token is available: $_token');
        NotificationsSocket().listenEvents();
        AuctionBoardSocket().listenEvents();
      } else {
        debugPrint("Token is not available.");
      }
    });
    _socket?.onDisconnect(
      (data) => debugPrint('Socket.IO Disconnected'),
    );
    _socket?.onError(
      (data) => debugPrint('Socket.IO Error: $data'),
    );
    _socket?.onConnectError(
      (data) => debugPrint('Socket.IO Connection Error: $data'),
    );
  }

  /// Listen to specific socket events
  void onEvent(String event, Function(dynamic data) handler) {
    debugPrint("Listening to event ---> $event");
    _socket?.on(event, (data) {
      handler(data);
      debugPrint("$event received ---> $data");
    });
  }

  /// Emit socket events with data
  Future<void> emitEvent(String event, {Map<String, dynamic>? data}) async {
    if (_socket == null || !_socket!.connected) await connect();
    _socket?.emit(event, data);
    debugPrint("Event emitted: $event with data: $data");
  }

  /// Disconnect the socket and clear listeners
  Future<void> disconnect() async {
    if (_socket != null) {
      _socket?.clearListeners();
      _socket?.disconnect();
      debugPrint("Socket disconnected and listeners cleared");
    }
  }

  /// Dispose the socket completely
  void dispose() {
    disconnect();
    _socket?.destroy();
    _socket = null;
    debugPrint("Socket completely disposed");
  }
}
