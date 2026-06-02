import 'package:equatable/equatable.dart';

class ProperityManagment extends Equatable {
  final String phoneNumber;
  final String city;
  final String area;
  final String neighborhood;
  final String realType;
  final String realCategory;

  const ProperityManagment({
    required this.phoneNumber,
    required this.city,
    required this.area,
    required this.neighborhood,
    required this.realType,
    required this.realCategory,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        city,
        area,
        neighborhood,
        realType,
        realCategory,
      ];

  /// Remove the prefix `+966` or leading `0` from the phone number
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
    print('sanitizedPhoneNumber: $sanitizedPhoneNumber');
    return <String, dynamic>{
      'phoneNumber': {
        'number': sanitizedPhoneNumber,
        'key': '+966',
      },
      'city': city,
      'area': area,
      'neighborhood': neighborhood,
      'realType': realType,
      'realCategory': realCategory,
    };
  }
}
