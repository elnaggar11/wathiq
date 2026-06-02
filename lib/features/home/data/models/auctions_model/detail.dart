import 'auction_detail.dart';

class Detail {
  String? title;
  List<AuctionDetail>? auctionDetails;

  Detail({this.title, this.auctionDetails});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        title: json['title'] as String?,
        auctionDetails: (json['auctionDetails'] as List<dynamic>?)
            ?.map((e) => AuctionDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'auctionDetails': auctionDetails?.map((e) => e.toJson()).toList(),
      };
}
