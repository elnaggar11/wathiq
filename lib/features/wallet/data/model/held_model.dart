class HeldModel {
  final String message;
  final Pagination pagination;
  final List<AuctionDataHeld> data;

  HeldModel({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory HeldModel.fromJson(Map<String, dynamic> json) {
    return HeldModel(
      message: json['message'],
      pagination: Pagination.fromJson(json['pagination']),
      data: List<AuctionDataHeld>.from(
          json['data'].map((x) => AuctionDataHeld.fromJson(x))),
    );
  }
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

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      resultCount: json['resultCount'],
      totalPages: json['totalPages'],
    );
  }
}

class AuctionDataHeld {
  final String id;
  final String user;
  final Enrollment enrollment;
  final int amount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  AuctionDataHeld({
    required this.id,
    required this.user,
    required this.enrollment,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuctionDataHeld.fromJson(Map<String, dynamic> json) {
    return AuctionDataHeld(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      enrollment: Enrollment.fromJson(json['enrollment']),
      amount: json['amount'] ?? 0,
      status: json['status'] ?? '',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class Enrollment {
  final Reject reject;
  final bool winner;
  final String id;
  final Auction auction;
  final String auctionOrigin;
  final String user;
  final String status;
  final String type;
  final int depositAmount;
  final String shareAs;
  final String participantNumber;
  final DateTime enrollmentDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Enrollment({
    required this.reject,
    required this.winner,
    required this.id,
    required this.auction,
    required this.auctionOrigin,
    required this.user,
    required this.status,
    required this.type,
    required this.depositAmount,
    required this.shareAs,
    required this.participantNumber,
    required this.enrollmentDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      reject: Reject.fromJson(json['reject'] ?? {}),
      winner: json['winner'] ?? false,
      id: json['_id'] ?? '',
      auction: Auction.fromJson(json['auction']),
      auctionOrigin: json['auctionOrigin'] ?? '',
      user: json['user'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      depositAmount: json['depositAmount'] ?? 0,
      shareAs: json['shareAs'] ?? '',
      participantNumber: json['participantNumber'] ?? '',
      enrollmentDate: DateTime.parse(
          json['enrollmentDate'] ?? DateTime.now().toIso8601String()),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class Reject {
  final String? reason;

  Reject({this.reason});

  factory Reject.fromJson(Map<String, dynamic> json) {
    return Reject(
      reason: json['reason'],
    );
  }
}

class Auction {
  final String id;
  final String title;
  final Location location;
  final AuctionReviewStatus auctionReviewStatus;
  final Updated updated;
  final String cover;
  final bool specialToSupportAuthority;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfDays;
  final String status;
  final String type;
  final String user;
  final bool createdByAdmin;
  final String auctionApprovalNumber;
  final String auctionBrochure;
  final String createdBy;
  final List<Logo> logos;
  final List<AuctionOriginheld> auctionOrigins;
  final DateTime createdAt;
  final DateTime updatedAt;

  Auction({
    required this.id,
    required this.title,
    required this.location,
    required this.auctionReviewStatus,
    required this.updated,
    required this.cover,
    required this.specialToSupportAuthority,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.status,
    required this.type,
    required this.user,
    required this.createdByAdmin,
    required this.auctionApprovalNumber,
    required this.auctionBrochure,
    required this.createdBy,
    required this.logos,
    required this.auctionOrigins,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Auction.fromJson(Map<String, dynamic> json) {
    return Auction(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      auctionReviewStatus:
          AuctionReviewStatus.fromJson(json['auctionReviewStatus'] ?? {}),
      updated: Updated.fromJson(json['updated'] ?? {}),
      cover: json['cover'] ?? '',
      specialToSupportAuthority: json['specialToSupportAuthority'] ?? false,
      startDate:
          DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate:
          DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      numberOfDays: json['numberOfDays'] ?? 0,
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      user: json['user'] ?? '',
      createdByAdmin: json['createdByAdmin'] ?? false,
      auctionApprovalNumber: json['auctionApprovalNumber'] ?? '',
      auctionBrochure: json['auctionBrochure'] ?? '',
      createdBy: json['createdBy'] ?? '',
      logos:
          List<Logo>.from((json['logos'] ?? []).map((x) => Logo.fromJson(x))),
      auctionOrigins: List<AuctionOriginheld>.from(
          (json['auctionOrigins'] ?? [])
              .map((x) => AuctionOriginheld.fromJson(x))),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class Location {
  final double longitude;
  final double latitude;
  final String title;

  Location({
    required this.longitude,
    required this.latitude,
    required this.title,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      longitude: json['longitude'].toDouble(),
      latitude: json['latitude'].toDouble(),
      title: json['title'],
    );
  }
}

class AuctionReviewStatus {
  final String status;
  final String? reason;
  final String by;
  final DateTime at;

  AuctionReviewStatus({
    required this.status,
    this.reason,
    required this.by,
    required this.at,
  });

  factory AuctionReviewStatus.fromJson(Map<String, dynamic> json) {
    return AuctionReviewStatus(
      status: json['status'],
      reason: json['reason'],
      by: json['by'],
      at: DateTime.parse(json['at']),
    );
  }
}

class Updated {
  final String by;
  final DateTime at;

  Updated({
    required this.by,
    required this.at,
  });

  factory Updated.fromJson(Map<String, dynamic> json) {
    return Updated(
      by: json['by'],
      at: DateTime.parse(json['at']),
    );
  }
}

class Logo {
  final String logo;
  final bool active;
  final String id;

  Logo({
    required this.logo,
    required this.active,
    required this.id,
  });

  factory Logo.fromJson(Map<String, dynamic> json) {
    return Logo(
      logo: json['logo'],
      active: json['active'],
      id: json['_id'],
    );
  }
}

class AuctionOriginheld {
  final String id;
  final String title;
  final String description;
  final Location location;
  final String awardStatus;
  final dynamic awardAt;
  final List<String> attachment;
  final int openingPrice;
  final int entryDeposit;
  final int garlicDifference;
  final List<AuctionDetailGroup> details;

  AuctionOriginheld({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.awardStatus,
    this.awardAt,
    required this.attachment,
    required this.openingPrice,
    required this.entryDeposit,
    required this.garlicDifference,
    required this.details,
  });

  factory AuctionOriginheld.fromJson(Map<String, dynamic> json) {
    return AuctionOriginheld(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      location: Location.fromJson(json['location']),
      awardStatus: json['awardStatus'],
      awardAt: json['awardAt'],
      attachment: List<String>.from(json['attachment']),
      openingPrice: json['openingPrice'],
      entryDeposit: json['entryDeposit'],
      garlicDifference: json['garlicDifference'],
      details: List<AuctionDetailGroup>.from(
          json['details'].map((x) => AuctionDetailGroup.fromJson(x))),
    );
  }
}

class AuctionDetailGroup {
  final String id;
  final String title;
  final List<AuctionDetail> auctionDetails;

  AuctionDetailGroup({
    required this.id,
    required this.title,
    required this.auctionDetails,
  });

  factory AuctionDetailGroup.fromJson(Map<String, dynamic> json) {
    return AuctionDetailGroup(
      id: json['_id'],
      title: json['title'],
      auctionDetails: List<AuctionDetail>.from(
          json['auctionDetails'].map((x) => AuctionDetail.fromJson(x))),
    );
  }
}

class AuctionDetail {
  final String id;
  final String title;
  final String description;

  AuctionDetail({
    required this.id,
    required this.title,
    required this.description,
  });

  factory AuctionDetail.fromJson(Map<String, dynamic> json) {
    return AuctionDetail(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
