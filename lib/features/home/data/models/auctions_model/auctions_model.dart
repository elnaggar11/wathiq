import 'package:equatable/equatable.dart';
import 'package:wathiq/features/home/data/models/auctions_model/counts.dart';

class AuctionsModel extends Equatable {
  final String? message;
  final Pagination? pagination;
  final List<AuctionData> data;
  final Counts? counts;

  AuctionsModel({
    required this.message,
    required this.pagination,
    required this.data,
    required this.counts,
  });

  factory AuctionsModel.fromJson(Map<String?, dynamic> json) {
    return AuctionsModel(
      message: json['message'],
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination']),
      data: List<AuctionData>.from(
          json['data'].map((x) => AuctionData.fromJson(x))),
      counts: json['counts'] == null ? null : Counts.fromJson(json['counts']),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [data, counts];
}

class Pagination {
  final int currentPage;
  final int resultCount;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.resultCount,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String?, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      resultCount: json['resultCount'],
      totalPages: json['totalPages'],
    );
  }
}

class AuctionData extends Equatable {
  final String id;
  final Location location;
  final bool? specialToSupportAuthority;
  final String? startDate;
  final String? endDate;
  final int numberOfDays;
  final String? status;
  final String? type;
  final bool? createdByAdmin;
  final String? auctionApprovalNumber;
  final AuctionReviewStatus? auctionReviewStatus;
  final String? createdAt;
  final String? updatedAt;
  final String? title;
  final String? cover;
  final dynamic user;
  final Provider provider;
  final List<Logo> logos;
  final String? auctionBrochure;
  bool? isFavorite;
  final List<AuctionOrigin> auctionOrigins;
  final CreatedBy? createdBy;
  final Updated? updated;
  final TimerAuction? timer;

  AuctionData({
    required this.id,
    required this.location,
    required this.specialToSupportAuthority,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.status,
    required this.type,
    required this.createdByAdmin,
    required this.auctionApprovalNumber,
    required this.auctionReviewStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.cover,
    required this.user,
    required this.provider,
    required this.logos,
    required this.auctionBrochure,
    required this.isFavorite,
    required this.auctionOrigins,
    required this.createdBy,
    required this.updated,
    required this.timer,
  });

  factory AuctionData.fromJson(Map<String?, dynamic> json) {
    return AuctionData(
      id: json['_id'],
      location: Location.fromJson(json['location']),
      specialToSupportAuthority: json['specialToSupportAuthority'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      numberOfDays: json['numberOfDays'],
      status: json['status'],
      type: json['type'],
      createdByAdmin: json['createdByAdmin'],
      auctionApprovalNumber: json['auctionApprovalNumber'],
      auctionReviewStatus: json['auctionReviewStatus'] == null
          ? null
          : AuctionReviewStatus.fromJson(json['auctionReviewStatus']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      title: json['title'],
      cover: json['cover'],
      user: json['user'],
      provider: Provider.fromJson(json['provider']),
      logos: List<Logo>.from(json['logos'].map((x) => Logo.fromJson(x))),
      auctionBrochure: json['auctionBrochure'],
      isFavorite: json['isFavorite'] ?? true,
      auctionOrigins: List<AuctionOrigin>.from(
          json['auctionOrigins'].map((x) => AuctionOrigin.fromJson(x))),
      createdBy: json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy']),
      updated:
          json['updated'] == null ? null : Updated.fromJson(json['updated']),
      timer:
          json['timer'] == null ? null : TimerAuction.fromJson(json['timer']),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, createdAt, status, cover];
}

class Location {
  final double longitude;
  final double latitude;
  final String? title;

  Location({
    required this.longitude,
    required this.latitude,
    required this.title,
  });

  factory Location.fromJson(Map<String?, dynamic> json) {
    return Location(
      longitude: json['longitude'].toDouble(),
      latitude: json['latitude'].toDouble(),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'title': title,
    };
  }
}

class AuctionReviewStatus {
  final String? status;
  final String? reason;
  final String? at;
  final By by;

  AuctionReviewStatus({
    required this.status,
    required this.reason,
    required this.at,
    required this.by,
  });

  factory AuctionReviewStatus.fromJson(Map<String?, dynamic> json) {
    return AuctionReviewStatus(
      status: json['status'],
      reason: json['reason'],
      at: json['at'],
      by: By.fromJson(json['by']),
    );
  }
}

class By {
  final String id;
  final String? name;
  final String? profileImage;

  By({
    required this.id,
    required this.name,
    required this.profileImage,
  });

  factory By.fromJson(Map<String?, dynamic> json) {
    return By(
      id: json['_id'],
      name: json['name'],
      profileImage: json['profileImage'],
    );
  }
}

class Provider {
  final String? companyName;

  final String? companyProfileImage;
  final String? valAuctionsLicenseNumber;
  final CompanyPhoneNumber? companyPhoneNumber;
  final CompanyPhoneNumber? auctionPhoneNumber;
  final String? companyEmail;

  Provider({
    this.companyName,
    this.companyProfileImage,
    required this.valAuctionsLicenseNumber,
    this.companyPhoneNumber,
    this.auctionPhoneNumber,
    this.companyEmail,
  });

  factory Provider.fromJson(Map<String?, dynamic> json) {
    return Provider(
      companyName: json['companyName'],
      companyProfileImage: json['companyProfileImage'],
      valAuctionsLicenseNumber: json['valAuctionsLicenseNumber'],
      companyPhoneNumber: json['companyPhoneNumber'] != null
          ? CompanyPhoneNumber.fromJson(json['companyPhoneNumber'])
          : null,
      auctionPhoneNumber: json['auctionPhoneNumber'] != null
          ? CompanyPhoneNumber.fromJson(json['auctionPhoneNumber'])
          : null,
      companyEmail: json['companyEmail'],
    );
  }
}

class CompanyPhoneNumber {
  final String? key;
  final String? number;

  CompanyPhoneNumber({
    required this.key,
    required this.number,
  });

  factory CompanyPhoneNumber.fromJson(Map<String?, dynamic> json) {
    return CompanyPhoneNumber(
      key: json['key'],
      number: json['number'],
    );
  }
}

class Logo {
  final String id;
  final String? logo;
  final bool? active;

  Logo({
    required this.id,
    required this.logo,
    required this.active,
  });

  factory Logo.fromJson(Map<String?, dynamic> json) {
    return Logo(
      id: json['_id'],
      logo: json['logo'],
      active: json['active'],
    );
  }
}

// class AuctionOrigin {
//   final String id;
//   final String? title;
//   final String? description;
//   final List<String?> attachment;

//   AuctionOrigin({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.attachment,
//   });

//   factory AuctionOrigin.fromJson(Map<String?, dynamic> json) {
//     return AuctionOrigin(
//       id: json['_id'],
//       title: json['title'],
//       description: json['description'],
//       attachment: List<String?>.from(json['attachment']),
//     );
//   }
// }

class AuctionOrigin {
  String id;
  String? title;
  String? description;
  List<String> attachment;
  dynamic openingPrice;
  dynamic entryDeposit;
  dynamic garlicDifference;
  List<Detail> details;
  bool? isFavorite;
  bool? isEnrolled;
  final Location location;

  AuctionOrigin({
    required this.id,
    required this.title,
    required this.description,
    required this.attachment,
    required this.openingPrice,
    required this.entryDeposit,
    required this.garlicDifference,
    required this.details,
    required this.isFavorite,
    required this.isEnrolled,
    required this.location,
  });

  // From JSON
  factory AuctionOrigin.fromJson(Map<String?, dynamic> json) {
    return AuctionOrigin(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      attachment: List<String>.from(json['attachment']),
      openingPrice: json['openingPrice'],
      entryDeposit: json['entryDeposit'],
      garlicDifference: json['garlicDifference'],
      details: (json['details'] as List)
          .map((item) => Detail.fromJson(item))
          .toList(),
      isFavorite: json['isFavorite'] ?? true,
      isEnrolled: json['isEnrolled'],
      location: Location.fromJson(json['location']),
    );
  }

  // To JSON
  Map<String?, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'attachment': attachment,
      'openingPrice': openingPrice,
      'entryDeposit': entryDeposit,
      'garlicDifference': garlicDifference,
      'details': details.map((item) => item.toJson()).toList(),
      'isFavorite': isFavorite ?? true,
      'isEnrolled': isEnrolled,
      'location': location.toJson(),
    };
  }
}

class Detail {
  String? title;
  List<AuctionDetail> auctionDetails;

  Detail({
    required this.title,
    required this.auctionDetails,
  });

  // From JSON
  factory Detail.fromJson(Map<String?, dynamic> json) {
    return Detail(
      title: json['title'],
      auctionDetails: (json['auctionDetails'] as List)
          .map((item) => AuctionDetail.fromJson(item))
          .toList(),
    );
  }

  // To JSON
  Map<String?, dynamic> toJson() {
    return {
      'title': title,
      'auctionDetails': auctionDetails.map((item) => item.toJson()).toList(),
    };
  }
}

class AuctionDetail {
  String? title;
  String? description;

  AuctionDetail({
    required this.title,
    required this.description,
  });

  // From JSON
  factory AuctionDetail.fromJson(Map<String?, dynamic> json) {
    return AuctionDetail(
      title: json['title'],
      description: json['description'],
    );
  }

  // To JSON
  Map<String?, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}

class CreatedBy {
  final String id;
  final String? name;
  final String? profileImage;

  CreatedBy({
    required this.id,
    required this.name,
    required this.profileImage,
  });

  factory CreatedBy.fromJson(Map<String?, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      name: json['name'],
      profileImage: json['profileImage'],
    );
  }
}

class Updated {
  final By by;
  final String? at;

  Updated({
    required this.by,
    required this.at,
  });

  factory Updated.fromJson(Map<String?, dynamic> json) {
    return Updated(
      by: By.fromJson(json['by']),
      at: json['at'],
    );
  }
}

class TimerAuction {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  TimerAuction({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory TimerAuction.fromJson(Map<String?, dynamic> json) {
    return TimerAuction(
      days: json['days'],
      hours: json['hours'],
      minutes: json['minutes'],
      seconds: json['seconds'],
    );
  }
}
