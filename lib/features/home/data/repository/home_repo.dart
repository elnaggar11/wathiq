import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wathiq/core/params/home/auctions_params.dart';
import 'package:wathiq/features/home/data/models/enrolle/privacy_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/params/home/add_favorite_params.dart';
import '../../../../core/params/home/auction_enrollment_params.dart';
import '../../../wallet/data/model/add_wallet_balance.dart';
import '../data_source/home_remote_data_source.dart';
import '../models/auctions_model/auctions_model.dart';
import '../models/enrolle/auction_board_model.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepository({
    required this.remoteDataSource,
  });

  Future<Either<Failure, AuctionsModel>> getAuctions(
      AuctionsParams params) async {
    try {
      final response = await remoteDataSource.getAuctions(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('getAuctions Status code is 200');
        // log(response.data);

        var data = AuctionsModel.fromJson(response.data);
        return Right(data);
      } else {
        log('getAuctions Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getAuctions Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuctionsModel>> getUserAuctions(
      UserAuctionsParams params) async {
    try {
      final response = await remoteDataSource.getUserAuctions(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('getUserAuctions Status code is 200');
        // log(response.data);

        var data = AuctionsModel.fromJson(response.data);
        return Right(data);
      } else {
        log('getUserAuctions Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getUserAuctions Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuctionsModel>> getFavorite() async {
    try {
      final response = await remoteDataSource.getFavorite();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('getAuctions Status code is 200');
        // log(response.data);

        var data = AuctionsModel.fromJson(response.data);
        return Right(data);
      } else {
        log('getAuctions Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getAuctions Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> addFavorite(
      GeneralAuctionParams params) async {
    try {
      final response = await remoteDataSource.addFavorite(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('addFavorite Status code is 200');
        // log(response.data);

        return Right("تم إضافة المزاد إلى المفضلة");
      } else {
        log('addFavorite Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('addFavorite Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> deleteAuctionFavorite(
      String auctionId) async {
    try {
      final response = await remoteDataSource.deleteAuctionFavorite(auctionId);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('addFavorite Status code is 200');
        // log(response.data);

        return Right("تم ازالة المزاد من المفضلة");
      } else {
        log('addFavorite Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('addFavorite Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> deleteOriginFavorite(
      GeneralAuctionParams params) async {
    try {
      final response = await remoteDataSource.deleteOriginFavorite(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('addFavorite Status code is 200');
        // log(response.data);

        return Right("تم ازالة المزاد من المفضلة");
      } else {
        log('addFavorite Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('addFavorite Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> auctionEnrollment(
      AuctionEnrollmentParams params) async {
    try {
      final response = await remoteDataSource.auctionEnrollment(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('auctionEnrollment Status code is 200');
        // log(response.data);

        return Right('تم التسجيل في المزاد بنجاح');
      } else {
        log('auctionEnrollment Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('auctionEnrollment Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> deleteAuctionEnrollment(
      GeneralAuctionParams params) async {
    try {
      final response = await remoteDataSource.deleteAuctionEnrollment(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('deleteAuctionEnrollment Status code is 200');
        // log(response.data);

        return Right('تم الغاء تسجيلك في المزاد');
      } else {
        log('deleteAuctionEnrollment Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('deleteAuctionEnrollment Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuctionBoardModel>> getAuctionBoard(
      GeneralAuctionParams params) async {
    try {
      final response = await remoteDataSource.getAuctionBoard(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('getAuctionBoard Status code is 200');

        var data = AuctionBoardModel.fromJson(response.data);
        return Right(data);
      } else {
        log('getAuctionBoard Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getAuctionBoard Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> addAuctionBid(
      GeneralAuctionParams params) async {
    try {
      final response = await remoteDataSource.addAuctionBid(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('addAuctionBid Status code is 200');
        // log(response.data);

        return Right('تم اضافة مزايدتك بنجاح');
      } else {
        log('addAuctionBid Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('addAuctionBid Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

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
}
