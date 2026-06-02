import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GeneralAuctionParams extends Equatable {
  String auctionId;
  String? originId;
  int? limit;
  dynamic amount;

  GeneralAuctionParams({
    required this.auctionId,
    required this.originId,
    required this.amount,
    required this.limit,
  });

  @override
  List<Object?> get props => [
        auctionId,
        originId,
        amount,
        limit,
      ];
}
