class ProfileModel {
  final String message;
  final UserData data;

  ProfileModel({
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      message: json['message'] ?? '',
      data: json['data'] != null
          ? UserData.fromJson(json['data'])
          : throw Exception('User data is null'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UserData {
  final String id;
  final String name;
  final PhoneNumber phoneNumber;
  final String identityNumber;
  final bool isVerified;
  final bool online;
  final Blocked blocked;
  final String createdAt;
  final String updatedAt;
  final Country country;
  final String? email;
  final String? profileImage;
  final Role role;
  final int agencyCount;
  final int successAuctionsCount;

  UserData({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.identityNumber,
    required this.isVerified,
    required this.online,
    required this.blocked,
    required this.createdAt,
    required this.updatedAt,
    required this.country,
    required this.email,
    required this.profileImage,
    required this.role,
    required this.agencyCount,
    required this.successAuctionsCount,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] != null
          ? PhoneNumber.fromJson(json['phoneNumber'])
          : throw Exception('Phone number is required'),
      identityNumber: json['identityNumber'] ?? '',
      isVerified: json['isVerified'] ?? false,
      online: json['online'] ?? false,
      blocked: json['blocked'] != null
          ? Blocked.fromJson(json['blocked'])
          : throw Exception('Blocked status is required'),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      country: json['country'] != null
          ? Country.fromJson(json['country'])
          : Country(id: '', name: ''),
      email: json['email'],
      profileImage: json['profileImage'],
      role: json['role'] != null
          ? Role.fromJson(json['role'])
          : throw Exception('Role is required'),
      agencyCount: json['agencyCount'] ?? 0,
      successAuctionsCount: json['successAuctionsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'phoneNumber': phoneNumber.toJson(),
      'identityNumber': identityNumber,
      'isVerified': isVerified,
      'online': online,
      'blocked': blocked.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'country': country.toJson(),
      'email': email,
      'profileImage': profileImage,
      'role': role.toJson(),
      'agencyCount': agencyCount,
      'successAuctionsCount': successAuctionsCount,
    };
  }
}

class PhoneNumber {
  final String number;
  final String key;

  PhoneNumber({
    required this.number,
    required this.key,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      number: json['number'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'key': key,
    };
  }
}

class Blocked {
  final bool value;
  final String? reason;
  final String? blockedBy;
  final String? unblockedBy;

  Blocked({
    required this.value,
    this.reason,
    this.blockedBy,
    this.unblockedBy,
  });

  factory Blocked.fromJson(Map<String, dynamic> json) {
    return Blocked(
      value: json['value'],
      reason: json['reason'],
      blockedBy: json['blockedBy'],
      unblockedBy: json['unblockedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'reason': reason,
      'blockedBy': blockedBy,
      'unblockedBy': unblockedBy,
    };
  }
}

class Country {
  final String id;
  final String name;

  Country({
    required this.id,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['_id'].toString(),
      name: json['name'].toString(),
    );
  }

  ///"country":{"_id":"67c9982376d66d04f225129a","name":"المنوفية"},
  ///
  ///
  ///

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Role {
  final String id;
  final String name;
  final List<dynamic> permissions;

  Role({
    required this.id,
    required this.name,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['_id'],
      name: json['name'],
      permissions: json['permissions'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'permissions': permissions,
    };
  }
}
