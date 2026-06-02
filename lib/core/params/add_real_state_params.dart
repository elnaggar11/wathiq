import 'package:equatable/equatable.dart';

class AddRealStateParams extends Equatable {
  final String phoneNumber;
  final String name;
  final String city;
  final String area;
  final String neighborhood;
  final bool certified;
  final String description;

  const AddRealStateParams({
    required this.phoneNumber,
    required this.name,
    required this.city,
    required this.area,
    required this.neighborhood,
    required this.certified,
    required this.description,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        name,
        city,
        area,
        neighborhood,
        certified,
        description,
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
      'name': name,
      'city': city,
      'area': area,
      'neighborhood': neighborhood,
      'certified': certified,
      'description': description,
    };
  }
}
