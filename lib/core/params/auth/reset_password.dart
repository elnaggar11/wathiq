import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String identityNumber;
  final String newPassword;
  const ResetPasswordParams({
    required this.identityNumber,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [
        identityNumber,
        newPassword,
      ];
  // String get sanitizedPhoneNumber {
  //   if (phoneNumber.startsWith('+966')) {
  //     return phoneNumber.replaceFirst('+966', '');
  //   }
  //   if (phoneNumber.startsWith('0')) {
  //     return phoneNumber.replaceFirst('0', '');
  //   }
  //   return phoneNumber;
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identityNumber': identityNumber,
      'newPassword': newPassword,
    };
  }
}
