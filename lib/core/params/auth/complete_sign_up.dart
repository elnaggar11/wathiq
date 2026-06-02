import 'package:equatable/equatable.dart';

class CompleteSignUpParams extends Equatable {
  final String country;
  final String password;
  final String phoneNumber;

  const CompleteSignUpParams({
    required this.country,
    required this.password,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [];
  String get sanitizedPhoneNumber {
    if (phoneNumber.startsWith('+966')) {
      return phoneNumber.replaceFirst('+966', '');
    }
    if (phoneNumber.startsWith('0')) {
      return phoneNumber.replaceFirst('0', '');
    }
    return phoneNumber;
  }

  Map<String, dynamic> toMap() {
    print(country + password);
    print('CompleteSignUpParams');

    return <String, dynamic>{
      'country': country,
      'password': password,
      "phoneNumber": {"number": sanitizedPhoneNumber, "key": "+966"}
    };
  }
}
