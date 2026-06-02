import 'dart:async';

import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../core/network/socket/socket_end_points.dart';
import '../../../../core/network/socket/socket_service.dart';
import '../models/enrolle/auction_board_model.dart';

class AuctionBoardSocket {
  static final AuctionBoardSocket _instance = AuctionBoardSocket._internal();

  factory AuctionBoardSocket() => _instance;

  AuctionBoardSocket._internal();

  /// Socket Service
  final SocketService _socket = SocketService();

  /// Stream Controllers

  final StreamController<AuctionBoardModel> _newBidersController =
      StreamController<AuctionBoardModel>.broadcast();

  Stream<AuctionBoardModel> get newBidersController =>
      _newBidersController.stream;

  /// Ensure socket connection
  Future<void> _ensureSocketConnected() async => await _socket.connect();

  Future<void> listenEvents() async {
    listenToNewBider();
  }

  /// Listen for New Notifications
  Future<void> listenToNewBider() async {
    print('KoriginId $KoriginId');
    await _ensureSocketConnected();
    _socket.onEvent(SocketEndPoints.NEW_BID_BIDDING_BOARD + KoriginId, (data) {
      print('EventlistenToNewBider $data');
      if (data == null) {
        print('EventlistenToNewBider true');
      }

      if (data != null) {
        try {
          final bider = AuctionBoardModel.fromJson(data);
          print('Parsed Bider Object: ${bider.data}');
          _newBidersController.add(bider);
        } catch (e) {
          print('eroor from json ${e.toString()}');
        }
      }
    });
  }

  /// Dispose Stream Controllers
  void dispose() {
    _newBidersController.close();
  }
}
