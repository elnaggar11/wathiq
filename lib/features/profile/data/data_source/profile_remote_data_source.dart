import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/params/profile/change_password_params.dart';
import '../../../../core/params/profile/create_agency_params.dart';

class ProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProfileRemoteDataSource({required this.apiConsumer});

  Future<Response> getProfile() async {
    final response = await apiConsumer.get(
      EndPoint.profile,
    );
    return response;
  }

  Future<Response> changeProfileImage(
      File? imageFile, String? countryID) async {
    String? extensionName;
    extensionName = imageFile?.path.split('.').last;

    FormData formData = FormData.fromMap({
      if (imageFile != null)
        "profileImage": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: DioMediaType(
            'image',
            extensionName!,
          ).change(mimeType: 'image/$extensionName', parameters: {}),
        ),
      if (countryID != null) "country": countryID
    });
    final response = await apiConsumer.patch(
      EndPoint.changeProfileImage,
      body: formData,
    );
    return response;
  }

  Future<Response> askAddEmail() async {
    final response = await apiConsumer.post(
      EndPoint.email,
    );
    return response;
  }

  Future<Response> addEmail(String email) async {
    final response = await apiConsumer.patch(
      EndPoint.email,
      body: {
        'email': email,
      },
    );
    return response;
  }

  Future<Response> askEditPhone() async {
    final response = await apiConsumer.post(
      EndPoint.phone,
    );
    return response;
  }

  Future<Response> addPhone(String phone) async {
    final response = await apiConsumer.patch(
      EndPoint.phone,
      body: {
        "phoneNumber": {
          "number": phone,
          "key": "+966",
        }
      },
    );
    return response;
  }

  Future<Response> changePassword(ChangePasswordParams params) async {
    final response = await apiConsumer.patch(
      EndPoint.changePassword,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> deleteAccount() async {
    final response = await apiConsumer.delete(
      EndPoint.profile,
    );
    return response;
  }

  Future<Response> getAgencies(String status) async {
    final response = await apiConsumer.get(
      EndPoint.agencies + '?status=$status',
    );
    return response;
  }

  Future<Response> createAgency(CreateAgencyParams params) async {
    final formData = await params.toFormData();
    final response = await apiConsumer.post(
      EndPoint.agencies,
      body: formData,
    );
    return response;
  }

  Future<Response> deleteAgencies(String agencyId) async {
    final response = await apiConsumer.delete(
      EndPoint.agencies + '/$agencyId',
    );
    return response;
  }

  Future<Response> activeAgencies(String agencyId) async {
    final response = await apiConsumer.patch(
      EndPoint.agencies + '/$agencyId',
    );
    return response;
  }

  Future<Response> logOut() async {
    final response = await apiConsumer.post(
      EndPoint.logOut,
    );
    return response;
  }
}
