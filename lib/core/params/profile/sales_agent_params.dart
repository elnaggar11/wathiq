import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class SalesAgentParams extends Equatable {
  final File? valAttachment;
  final File? taxAttachment;
  final File? commercialAttachment;
  //
  final File? bankCertificate;

  //
  final File? identityAttachment;
  final File? articlesOfAssociation;
  final File? letterOfAuthorization;

  final String companyName;
  final String companyEmail;
  final String companyPhoneNumber;
  final String companyPhoneKey;
  final String bankAccountNumber;
  final String bankName;
  final String realEstateActivity;
  final String valAuctionsLicenseNumber;
  final String taxType;
  final String taxNumber;
  final String commercialRegNumber;
  final String commercialRegStartDate;
  final String commercialRegEndDate;
  final String userName;
  final String userPhoneKey;
  final String userPhoneNumber;
  final String userEmail;
  final String userBirthDay;
  final String userIdentityNumber;
  final String userPassword;
  final bool approvedByNafath;
  final bool accreditationRequest;

  SalesAgentParams({
    required this.approvedByNafath,
    required this.accreditationRequest,
    required this.valAttachment,
    required this.taxAttachment,
    required this.commercialAttachment,
    required this.identityAttachment,
    required this.articlesOfAssociation,
    required this.letterOfAuthorization,
    required this.bankCertificate,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhoneNumber,
    required this.companyPhoneKey,
    required this.bankAccountNumber,
    required this.bankName,
    required this.realEstateActivity,
    required this.valAuctionsLicenseNumber,
    required this.taxType,
    required this.taxNumber,
    required this.commercialRegNumber,
    required this.commercialRegStartDate,
    required this.commercialRegEndDate,
    required this.userName,
    required this.userPhoneKey,
    required this.userPhoneNumber,
    required this.userEmail,
    required this.userBirthDay,
    required this.userIdentityNumber,
    required this.userPassword,
  });

  @override
  List<Object?> get props => [
        approvedByNafath,
        accreditationRequest,
        letterOfAuthorization,
        articlesOfAssociation,
        identityAttachment,
        commercialAttachment,
        taxAttachment,
        valAttachment,
        bankCertificate,
        companyName,
        companyEmail,
        companyPhoneNumber,
        companyPhoneKey,
        bankAccountNumber,
        bankName,
        realEstateActivity,
        valAuctionsLicenseNumber,
        taxType,
        taxNumber,
        commercialRegNumber,
        commercialRegStartDate,
        commercialRegEndDate,
        userName,
        userPhoneKey,
        userPhoneNumber,
        userEmail,
        userBirthDay,
        userIdentityNumber,
        userPassword,
      ];

  // Helper function to validate and create MultipartFile
  // Future<MultipartFile> _createMultipartFile(File file) async {
  //   final String filePath = file.path;
  //   final String extension = filePath.split('.').last;

  //   return await MultipartFile.fromFile(
  //     filePath,
  //     filename: filePath.split('/').last,
  //     contentType: DioMediaType(
  //       extension == 'pdf' ? 'application' : "image",
  //       extension,
  //     ).change(mimeType: 'image/$extension', parameters: {}),
  //   );
  // }

  // static Future<MultipartFile> prepareFileForUpload(String path) async {
  //   String? mimeType = lookupMimeType(path);
  //   MediaType? mediaType;
  //   if (mimeType != null) {
  //     List<String> types = mimeType.split('/');
  //     if (types.length == 2) mediaType = MediaType(types[0], types[1]);
  //   }
  //   var file = File(path);
  //   return MultipartFile.fromStream(
  //     () => file.openRead(),
  //     await file.length(),
  //     filename: file.path.split('/').last,
  //     contentType: mediaType ?? MediaType('application', 'octet-stream'),
  //   );
  // }
  Future<MultipartFile> _createMultipartFile(File file) async {
    if (!await file.exists()) {
      print('File does not exist: ${file.path}');
      return Future.error('File not found');
    }
    final String mimeType =
        lookupMimeType(file.path) ?? 'application/octet-stream';
    final List<String> mimeParts = mimeType.split('/');

    if (mimeParts.length != 2) {
      throw UnsupportedError('Invalid MIME type: $mimeType');
    }

    return await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
      contentType: MediaType(mimeParts[0], mimeParts[1]),
    );
  }

  /// Convert params to FormData
  Future<FormData> toFormData() async {
    print('bankCertificate');
    print('bankCertificate' + bankCertificate!.path);
    // Construct FormData
    return FormData.fromMap({
      'letterOfAuthorization':
          await _createMultipartFile(letterOfAuthorization!),
      'articlesOfAssociation':
          await _createMultipartFile(articlesOfAssociation!),
      'identityAttachment': await _createMultipartFile(identityAttachment!),
      //
      'bankCertificate': await _createMultipartFile(bankCertificate!),
      //
      'commercialAttachment': await _createMultipartFile(commercialAttachment!),
      if (taxAttachment != null)
        'taxAttachment': await _createMultipartFile(taxAttachment!),
      'valAttachment': await _createMultipartFile(valAttachment!),
      //
      'companyName': companyName,
      'companyEmail': companyEmail,
      'companyPhoneNumber[number]': companyPhoneNumber,
      'companyPhoneNumber[key]': '+966',
      'bankAccountInformation[accountNumber]': bankAccountNumber,
      'bankAccountInformation[bankName]': bankName,
      'realEstateActivity': 'النشاط العقارى',
      'valAuctionsLicense[number]': valAuctionsLicenseNumber,
      'tax[type]': taxType,
      if (taxType == 'خاضع للضريبة') 'tax[number]': taxNumber,
      'commercialRegistration[number]': commercialRegNumber,
      'commercialRegistration[endDate]': commercialRegEndDate,
      'commercialRegistration[startDate]': commercialRegStartDate,
      'user[name]': userName,
      'user[phoneNumber][key]': '+966',
      'user[phoneNumber][number]': userPhoneNumber,
      'user[email]': userEmail,
      'user[birthDay]': commercialRegStartDate,
      'user[identityNumber]': userIdentityNumber,
      'approvedByNafath': approvedByNafath,
      'accreditationRequest': accreditationRequest,
    });
  }
}
