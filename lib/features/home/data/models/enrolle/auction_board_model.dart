class AuctionBoardModel {
  final String? message;
  final Pagination? pagination;
  final List<BiderAuctionData> data;

  AuctionBoardModel({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory AuctionBoardModel.fromJson(Map<String, dynamic> json) {
    return AuctionBoardModel(
      message: json['message'],
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination']),
      data: List<BiderAuctionData>.from(
          json['data'].map((x) => BiderAuctionData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'pagination': pagination == null ? null : pagination!.toJson(),
      'data': data.map((x) => x.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'resultCount': resultCount,
      'totalPages': totalPages,
    };
  }
}

class BiderAuctionData {
  final User user;
  final dynamic bidAmount;
  final String participantNumber;
  final String bidAt;
  final String auctionEnrollment;
  final String status;
  final String id;

  BiderAuctionData({
    required this.user,
    required this.bidAmount,
    required this.participantNumber,
    required this.bidAt,
    required this.auctionEnrollment,
    required this.status,
    required this.id,
  });

  factory BiderAuctionData.fromJson(Map<String, dynamic> json) {
    return BiderAuctionData(
      user: User.fromJson(json['user']),
      bidAmount: json['bidAmount'],
      participantNumber: json['participantNumber'],
      bidAt: json['bidAt'],
      auctionEnrollment: json['auctionEnrollment'],
      status: json['status'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'bidAmount': bidAmount,
      'participantNumber': participantNumber,
      'bidAt': bidAt,
      'auctionEnrollment': auctionEnrollment,
      'status': status,
      '_id': id,
    };
  }
}

class User {
  final String id;
  final String name;
  final String profileImage;
  final String identityNumber;

  User({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.identityNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      profileImage: json['profileImage'],
      identityNumber: json['identityNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'profileImage': profileImage,
      'identityNumber': identityNumber,
    };
  }
}
