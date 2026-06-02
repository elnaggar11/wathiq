class WithdrawModel {
  final String message;
  final Pagination pagination;
  final List<WithdrawRequest> data;

  WithdrawModel({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      message: json['message'] ?? '',
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List<dynamic>)
          .map((e) => WithdrawRequest.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'pagination': pagination.toJson(),
        'data': data.map((e) => e.toJson()).toList(),
      };
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
      currentPage: json['currentPage'] ?? 0,
      resultCount: json['resultCount'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'resultCount': resultCount,
        'totalPages': totalPages,
      };
}

class WithdrawRequest {
  final String id;
  final String name;
  final PhoneNumber phoneNumber;
  final String bankName;
  final String iban;
  final double amount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic ibanCertificate;
  final User user;

  WithdrawRequest({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.bankName,
    required this.iban,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.ibanCertificate,
    required this.user,
  });

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) {
    return WithdrawRequest(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: PhoneNumber.fromJson(json['phoneNumber']),
      bankName: json['bankName'] ?? '',
      iban: json['iban'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      ibanCertificate: json['ibanCertificate'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phoneNumber': phoneNumber.toJson(),
        'bankName': bankName,
        'iban': iban,
        'amount': amount,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'ibanCertificate': ibanCertificate,
        'user': user.toJson(),
      };
}

class PhoneNumber {
  final String key;
  final String number;

  PhoneNumber({
    required this.key,
    required this.number,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      key: json['key'] ?? '',
      number: json['number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'number': number,
      };
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
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      online: json['online'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'online': online,
      };
}
