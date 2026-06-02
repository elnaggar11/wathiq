import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

// han
class PsotWithdrawParams extends Equatable {
  final String name;
  final String bankName;
  final String iban;
  final String amount;
  final String phoneNumber;
  final File? ibanCertificate;

  PsotWithdrawParams({
    required this.name,
    required this.bankName,
    required this.iban,
    required this.amount,
    required this.phoneNumber,
    this.ibanCertificate,
  });

  @override
  List<Object?> get props => [
        name,
        bankName,
        iban,
        amount,
        phoneNumber,
        ibanCertificate,
      ];

  Future<FormData> toFormData() async {
    Future<MultipartFile> _createMultipartFile(File file) async {
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

    print('name: $name');
    print('bankName: $bankName');
    print('iban: $iban');
    print('amount: $amount');
    print('phoneNumber: $phoneNumber');
    print('ibanCertificate: ${ibanCertificate?.path}');

    Map<String, dynamic> formDataMap = {
      'name': name,
      'bankName': bankName,
      'iban': iban,
      'amount': amount,
      'phoneNumber[key]': '+966',
      'phoneNumber[number]': phoneNumber,
    };

    if (ibanCertificate != null) {
      formDataMap['ibanCertificate'] =
          await _createMultipartFile(ibanCertificate!);
    }

    return FormData.fromMap(formDataMap);
  }
}
