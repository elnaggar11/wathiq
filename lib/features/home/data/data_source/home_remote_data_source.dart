import 'package:dio/dio.dart';
import 'package:wathiq/core/params/home/auctions_params.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/params/home/add_favorite_params.dart';
import '../../../../core/params/home/auction_enrollment_params.dart';

class HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeRemoteDataSource({required this.apiConsumer});

  Future<Response> getAuctions(AuctionsParams params) async {
    final response = await apiConsumer.get(
      EndPoint.getAuctions,
      query: params.toMap(),
    );
    return response;
  }

  Future<Response> getUserAuctions(UserAuctionsParams params) async {
    final response = await apiConsumer.get(
      EndPoint.getUserAuctions,
      query: params.toMap(),
    );
    return response;
  }

  Future<Response> getFavorite() async {
    final response = await apiConsumer.get(
      EndPoint.favorite,
    );
    return response;
  }

  Future<Response> addFavorite(GeneralAuctionParams params) async {
    final response = await apiConsumer.post(
      EndPoint.favorite + '/${params.auctionId}',
      body: {
        if (params.originId != null) 'origin': params.originId,
      },
    );
    return response;
  }

  Future<Response> deleteAuctionFavorite(String auctionId) async {
    final response = await apiConsumer.delete(
      EndPoint.favorite + '/$auctionId',
    );
    return response;
  }

  Future<Response> deleteOriginFavorite(GeneralAuctionParams params) async {
    final response = await apiConsumer.delete(
      EndPoint.favorite + '/${params.auctionId}/origin/${params.originId}',
    );
    return response;
  }

  Future<Response> auctionEnrollment(AuctionEnrollmentParams params) async {
    final response = await apiConsumer.post(
      EndPoint.enrollment,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> deleteAuctionEnrollment(GeneralAuctionParams params) async {
    final response = await apiConsumer.delete(
      EndPoint.enrollment + '/${params.auctionId}/origin/${params.originId}',
    );
    return response;
  }

  Future<Response> getAuctionBoard(GeneralAuctionParams params) async {
    final response = await apiConsumer.get(
        EndPoint.enrollment +
            '/${params.auctionId}/origin/${params.originId}/bidding-board',
        query: {
          if (params.limit != null) 'limit': params.limit.toString(),
        });
    return response;
  }

  Future<Response> addAuctionBid(GeneralAuctionParams params) async {
    final response = await apiConsumer.post(
      EndPoint.enrollment +
          '/${params.auctionId}/origin/${params.originId}/bid',
      body: {'amount': params.amount},
    );
    return response;
  }

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
}
