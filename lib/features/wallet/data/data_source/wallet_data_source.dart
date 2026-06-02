import 'package:dio/dio.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/params/wallet/psot_withdraw_params.dart';

class WalletRemoteDataSource {
  final ApiConsumer apiConsumer;

  WalletRemoteDataSource({required this.apiConsumer});
  Future<Response> getWallet() async {
    final response = await apiConsumer.get(
      EndPoint.getWallet,
    );
    return response;
  }

  Future<Response> addWalletBalance(dynamic balance) async {
    final response = await apiConsumer.post(EndPoint.addWalletBalance, body: {
      'balance': balance,
    });
    return response;
  }

  Future<Response> privacyPolicy() async {
    final response = await apiConsumer.get(
      EndPoint.privacyPolicy,
    );
    return response;
  }

  Future<Response> submitWithdrawRequest(PsotWithdrawParams params) async {
    var formData = await params.toFormData();
    return await apiConsumer.post(
      EndPoint.posWithdraw,
      body: formData,
    );
  }

  Future<Response> getHeldFunds() async {
    final response = await apiConsumer.get(
      EndPoint.heldFunds,
    );
    return response;
  }

  Future<Response> getWithdraw() async {
    final response = await apiConsumer.get(
      EndPoint.getWithdraw,
    );
    return response;
  }

  Future<Response> getUserInvoices() async {
    final response = await apiConsumer.get(
      EndPoint.getUserInvoices,
    );
    return response;
  }
}
