import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AuctionEnrollmentParams extends Equatable {
  String auction;
  String auctionOrigin;
  String shareAs;
  String type;
  String? agency;

  AuctionEnrollmentParams({
    required this.auction,
    required this.auctionOrigin,
    required this.shareAs,
    required this.type,
    this.agency,
  });

  @override
  List<Object?> get props => [
        auction,
        auctionOrigin,
        shareAs,
        type,
        agency,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auction': auction,
      'auctionOrigin': auctionOrigin,
      'shareAs': shareAs,
      'type': type,
      if (agency != null) 'agency': agency,
    };
  }
}
