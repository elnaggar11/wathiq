class WalletModel {
  final String message;
  final dynamic heldFunds;
  final WalletData data;

  WalletModel(
      {required this.message, required this.heldFunds, required this.data});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      message: json['message'],
      heldFunds: json['heldFunds'],
      data: WalletData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class WalletData {
  final String id;
  final String user;
  final String userType;
  final double balance;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  WalletData({
    required this.id,
    required this.user,
    required this.userType,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
      id: json['_id'],
      user: json['user'],
      userType: json['userType'],
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'userType': userType,
      'balance': balance,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
