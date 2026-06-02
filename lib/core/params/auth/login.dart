import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String identityNumber;
  final String password;

  const LoginParams({
    required this.identityNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [identityNumber, password];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identityNumber': identityNumber,
      'password': password,
    };
  }
}
