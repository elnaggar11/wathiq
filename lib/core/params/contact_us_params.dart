import 'package:equatable/equatable.dart';

class ContactUsParams extends Equatable {
  final String phoneNumber;
  final String email;
  final String type; // question, suggestion, complaint, or other
  final String name;
  final String message;

  const ContactUsParams({
    required this.phoneNumber,
    required this.email,
    required this.type,
    required this.name,
    required this.message,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        email,
        type,
        name,
        message,
      ];

  /// Remove the prefix `+966` from the phone number if it exists
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
    print('sanitizedPhoneNumbern $sanitizedPhoneNumber');
    return <String, dynamic>{
      'phoneNumber': {
        "number": sanitizedPhoneNumber,
        "key": '+966',
      },
      'email': email,
      'type': type,
      'name': name,
      'message': message,
    };
  }
}
