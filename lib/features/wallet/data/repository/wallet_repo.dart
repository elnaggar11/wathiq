import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wathiq/features/wallet/data/data_source/wallet_data_source.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/params/wallet/psot_withdraw_params.dart';
import '../../../home/data/models/enrolle/privacy_model.dart';
import '../model/add_wallet_balance.dart';
import '../model/held_model.dart';
import '../model/invoice_model.dart';
import '../model/withdraw_model.dart';

class WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepository({
    required this.remoteDataSource,
  });

  Future<Either<Failure, WalletModel>> getWallet() async {
    try {
      final response = await remoteDataSource.getWallet();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        var data = WalletModel.fromJson(response.data);
        log('getWallet Status code is 200');
        // log(response.data);

        return Right(data);
      } else {
        log('getWallet Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getWallet Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, PrivacyModel>> privacyPolicy() async {
    try {
      final response = await remoteDataSource.privacyPolicy();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        var data = PrivacyModel.fromJson(response.data);
        log('getWallet Status code is 200');
        // log(response.data);

        return Right(data);
      } else {
        log('getWallet Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getWallet Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, WithdrawModel>> getWithdraw() async {
    try {
      final response = await remoteDataSource.getWithdraw();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        var data = WithdrawModel.fromJson(response.data);
        log('getWallet Status code is 200');
        // log(response.data);

        return Right(data);
      } else {
        log('getWallet Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getWallet Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, InvoiceModel>> getUserInvoices() async {
    try {
      final response = await remoteDataSource.getUserInvoices();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        var data = InvoiceModel.fromJson(response.data);
        log('getWallet Status code is 200');
        // log(response.data);

        return Right(data);
      } else {
        log('getWallet Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getWallet Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, HeldModel>> getHeldFunds() async {
    try {
      final response = await remoteDataSource.getHeldFunds();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        var data = HeldModel.fromJson(response.data);
        log('getWallet Status code is 200');
        // log(response.data);

        return Right(data);
      } else {
        log('getWallet Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getWallet Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> addWalletBalance(
    dynamic balance,
  ) async {
    try {
      final response = await remoteDataSource.addWalletBalance(balance);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('addWalletBalance Status code is 200');
        // log(response.data);

        return Right(response.data['message']);
      } else {
        log('addWalletBalance Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('addWalletBalance Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> submitWithdrawRequest(
      PsotWithdrawParams params) async {
    try {
      final response = await remoteDataSource.submitWithdrawRequest(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('submitWithdrawRequest Status code is 200');
        return Right("تم إرسال طلب السحب بنجاح");
      } else {
        log('submitWithdrawRequest Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('submitWithdrawRequest Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
