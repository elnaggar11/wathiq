class SignUpModel {
  final String message;
  final AuthData data;

  SignUpModel({required this.message, required this.data});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      message: json['message'],
      data: AuthData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AuthData {
  final String name;
  final String identityNumber;

  AuthData({
    required this.name,
    required this.identityNumber,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      name: json['name'],
      identityNumber: json['identityNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'identityNumber': identityNumber,
    };
  }
}
