import 'detail.dart';

class AuctionOrigin {
  String? id;
  String? title;
  String? description;
  List<String>? attachment;
  int? openingPrice;
  int? entryDeposit;
  int? garlicDifference;
  List<Detail>? details;
  bool? isFavorite;
  bool? isEnrolled;

  AuctionOrigin({
    this.id,
    this.title,
    this.description,
    this.attachment,
    this.openingPrice,
    this.entryDeposit,
    this.garlicDifference,
    this.details,
    this.isFavorite,
    this.isEnrolled,
  });

  factory AuctionOrigin.fromJson(Map<String, dynamic> json) => AuctionOrigin(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        attachment: json['attachment'] as List<String>?,
        openingPrice: json['openingPrice'] as int?,
        entryDeposit: json['entryDeposit'] as int?,
        garlicDifference: json['garlicDifference'] as int?,
        details: (json['details'] as List<dynamic>?)
            ?.map((e) => Detail.fromJson(e as Map<String, dynamic>))
            .toList(),
        isFavorite: json['isFavorite'] as bool?,
        isEnrolled: json['isEnrolled'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'attachment': attachment,
        'openingPrice': openingPrice,
        'entryDeposit': entryDeposit,
        'garlicDifference': garlicDifference,
        'details': details?.map((e) => e.toJson()).toList(),
        'isFavorite': isFavorite,
        'isEnrolled': isEnrolled,
      };
}
