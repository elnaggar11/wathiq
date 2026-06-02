import 'auction_origin.dart';
import 'auction_review_status.dart';
import 'created_by.dart';
import 'location.dart';
import 'logo.dart';
import 'provider.dart';
import 'timer.dart';
import 'updated.dart';

class Datum {
  String? id;
  Location? location;
  bool? specialToSupportAuthority;
  DateTime? startDate;
  DateTime? endDate;
  int? numberOfDays;
  String? status;
  String? type;
  bool? createdByAdmin;
  String? auctionApprovalNumber;
  AuctionReviewStatus? auctionReviewStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? cover;
  dynamic user;
  Provider? provider;
  List<Logo>? logos;
  String? auctionBrochure;
  bool? isFavorite;
  List<AuctionOrigin>? auctionOrigins;
  CreatedBy? createdBy;
  Updated? updated;
  Timer? timer;

  Datum({
    this.id,
    this.location,
    this.specialToSupportAuthority,
    this.startDate,
    this.endDate,
    this.numberOfDays,
    this.status,
    this.type,
    this.createdByAdmin,
    this.auctionApprovalNumber,
    this.auctionReviewStatus,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.cover,
    this.user,
    this.provider,
    this.logos,
    this.auctionBrochure,
    this.isFavorite,
    this.auctionOrigins,
    this.createdBy,
    this.updated,
    this.timer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['_id'] as String?,
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        specialToSupportAuthority: json['specialToSupportAuthority'] as bool?,
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null
            ? null
            : DateTime.parse(json['endDate'] as String),
        numberOfDays: json['numberOfDays'] as int?,
        status: json['status'] as String?,
        type: json['type'] as String?,
        createdByAdmin: json['createdByAdmin'] as bool?,
        auctionApprovalNumber: json['auctionApprovalNumber'] as String?,
        auctionReviewStatus: json['auctionReviewStatus'] == null
            ? null
            : AuctionReviewStatus.fromJson(
                json['auctionReviewStatus'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        title: json['title'] as String?,
        cover: json['cover'] as String?,
        user: json['user'] as dynamic,
        provider: json['provider'] == null
            ? null
            : Provider.fromJson(json['provider'] as Map<String, dynamic>),
        logos: (json['logos'] as List<dynamic>?)
            ?.map((e) => Logo.fromJson(e as Map<String, dynamic>))
            .toList(),
        auctionBrochure: json['auctionBrochure'] as String?,
        isFavorite: json['isFavorite'] as bool?,
        auctionOrigins: (json['auctionOrigins'] as List<dynamic>?)
            ?.map((e) => AuctionOrigin.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdBy: json['createdBy'] == null
            ? null
            : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
        updated: json['updated'] == null
            ? null
            : Updated.fromJson(json['updated'] as Map<String, dynamic>),
        timer: json['timer'] == null
            ? null
            : Timer.fromJson(json['timer'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'location': location?.toJson(),
        'specialToSupportAuthority': specialToSupportAuthority,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'numberOfDays': numberOfDays,
        'status': status,
        'type': type,
        'createdByAdmin': createdByAdmin,
        'auctionApprovalNumber': auctionApprovalNumber,
        'auctionReviewStatus': auctionReviewStatus?.toJson(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'title': title,
        'cover': cover,
        'user': user,
        'provider': provider?.toJson(),
        'logos': logos?.map((e) => e.toJson()).toList(),
        'auctionBrochure': auctionBrochure,
        'isFavorite': isFavorite,
        'auctionOrigins': auctionOrigins?.map((e) => e.toJson()).toList(),
        'createdBy': createdBy?.toJson(),
        'updated': updated?.toJson(),
        'timer': timer?.toJson(),
      };
}
