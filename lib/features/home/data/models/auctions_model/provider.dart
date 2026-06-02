import 'company_phone_number.dart';

class Provider {
  String? id;
  String? companyName;
  String? companyProfileImage;
  String? valAuctionsLicenseNumber;
  CompanyPhoneNumber? companyPhoneNumber;
  String? companyEmail;

  Provider({
    this.id,
    this.companyName,
    this.companyProfileImage,
    this.valAuctionsLicenseNumber,
    this.companyPhoneNumber,
    this.companyEmail,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json['_id'] as String?,
        companyName: json['companyName'] as String?,
        companyProfileImage: json['companyProfileImage'] as String?,
        valAuctionsLicenseNumber: json['valAuctionsLicenseNumber'] as String?,
        companyPhoneNumber: json['companyPhoneNumber'] == null
            ? null
            : CompanyPhoneNumber.fromJson(
                json['companyPhoneNumber'] as Map<String, dynamic>),
        companyEmail: json['companyEmail'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'companyName': companyName,
        'companyProfileImage': companyProfileImage,
        'valAuctionsLicenseNumber': valAuctionsLicenseNumber,
        'companyPhoneNumber': companyPhoneNumber?.toJson(),
        'companyEmail': companyEmail,
      };
}
