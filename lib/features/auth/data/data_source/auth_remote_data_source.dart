import 'package:dio/dio.dart';
import 'package:wathiq/core/params/auth/complete_sign_up.dart';
import 'package:wathiq/core/params/auth/verify_params.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/params/auth/login.dart';
import '../../../../core/params/auth/reset_password.dart';

class AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSource({required this.apiConsumer});

  Future<Response> signUp(String nationalID) async {
    final response = await apiConsumer.post(
      EndPoint.signUp,
      body: {
        "identityNumber": nationalID,
      },
    );
    return response;
  }

  Future<Response> completeSignUp(CompleteSignUpParams params) async {
    final response = await apiConsumer.patch(
      EndPoint.completeSignUp,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> login(LoginParams params) async {
    final response = await apiConsumer.post(
      EndPoint.login,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> foregtPassword(String identityNumber) async {
    final response = await apiConsumer.post(
      EndPoint.forgetPassword,
      body: {
        "identityNumber": identityNumber,
      },
    );
    return response;
  }

  Future<Response> resetPassword(ResetPasswordParams params) async {
    final response = await apiConsumer.patch(
      EndPoint.resetPassword,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> verify(VerifyParams params) async {
    final response = await apiConsumer.post(
      EndPoint.verify,
      body: params.toMap(),
    );
    return response;
  }

  Future<Response> resendCode(String identityNumber) async {
    final response = await apiConsumer.post(
      EndPoint.resendCode,
      body: {"identityNumber": identityNumber},
    );
    return response;
  }

  Future<Response> getCountries() async {
    final response = await apiConsumer.get(
      EndPoint.countries,
    );
    return response;
  }
}
