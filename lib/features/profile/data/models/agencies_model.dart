class AgenciesModel {
  final String message;
  final Pagination pagination;
  final List<Agency> data;

  AgenciesModel({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory AgenciesModel.fromJson(Map<String, dynamic> json) {
    return AgenciesModel(
      message: json['message'],
      pagination: Pagination.fromJson(json['pagination']),
      data:
          (json['data'] as List).map((item) => Agency.fromJson(item)).toList(),
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int resultCount;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.resultCount,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      resultCount: json['resultCount'],
    );
  }
}

class Agency {
  final String id;
  final String agencyName;
  final String agencyNumber;
  final DateTime agencyIssuedDate;
  final DateTime? expireAt;
  final Status? status;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String agencyAttachment;
  final User user;
  final dynamic updatedBy;

  Agency({
    required this.id,
    required this.agencyName,
    required this.agencyNumber,
    required this.agencyIssuedDate,
    required this.expireAt,
    required this.status,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.agencyAttachment,
    required this.user,
    this.updatedBy,
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['_id'],
      agencyName: json['agencyName'],
      agencyNumber: json['agencyNumber'],
      agencyIssuedDate: DateTime.parse(json['agencyIssuedDate']),
      expireAt:
          json['expireAt'] == null ? null : DateTime.parse(json['expireAt']),
      status: json['status'] == null ? null : Status.fromJson(json['status']),
      active: json['active'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      agencyAttachment: json['agencyAttachment'],
      user: User.fromJson(json['user']),
      updatedBy: json['updatedBy'],
    );
  }
}

class Status {
  final String value;
  final dynamic reason;

  Status({
    required this.value,
    this.reason,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      value: json['value'],
      reason: json['reason'],
    );
  }
}

class User {
  final String id;
  final String name;
  final bool online;

  User({
    required this.id,
    required this.name,
    required this.online,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      online: json['online'],
    );
  }
}
