class AuthModel {
  final int status;
  final bool success;
  final UserData? data;
  final String accessToken;

  AuthModel({
    required this.status,
    required this.success,
    required this.data,
    required this.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json['status'],
      success: json['success'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      accessToken: json['access_token'] ?? '',
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String gender;
  final int? socialStatus; // Nullable
  final String phone;
  final String? deviceToken; // Nullable
  final String birthDate;
  final bool newsletter;
  final String points;
  final double pointsMoney;
  final Avatar? avatar; // Nullable
  final Zone? zone; // Nullable

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    this.socialStatus,
    required this.phone,
    this.deviceToken,
    required this.birthDate,
    required this.newsletter,
    required this.points,
    required this.pointsMoney,
    this.avatar,
    this.zone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      socialStatus: json['SocialStatus'], // Handles null
      phone: json['phone'],
      deviceToken: json['device_token'], // Handles null
      birthDate: json['birthDate'],
      newsletter: json['newsletter'],
      points: json['points'],
      pointsMoney: json['points_money'].toDouble(),
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      zone: json['zone'] != null ? Zone.fromJson(json['zone']) : null,
    );
  }
}

class Avatar {
  final String small;
  final String medium;
  final String large;

  Avatar({
    required this.small,
    required this.medium,
    required this.large,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      small: json['small'] ?? '',
      medium: json['medium'] ?? '',
      large: json['large'] ?? '',
    );
  }
}

class Zone {
  final int id;
  final String nameAr;
  final String nameEn;
  final int delivery;

  Zone({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.delivery,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      delivery: json['delivery'],
    );
  }
}
