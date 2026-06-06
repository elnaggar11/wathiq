import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wathiq/core/params/auth/verify_params.dart';
import 'package:wathiq/features/auth/data/models/sign_up_model.dart';

import 'package:wathiq/app/injector.dart';
import 'package:wathiq/core/error/failure.dart';
import 'package:wathiq/core/params/auth/complete_sign_up.dart';
import 'package:wathiq/core/params/auth/login.dart';
import 'package:wathiq/core/params/auth/reset_password.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:wathiq/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:wathiq/features/auth/data/models/countries_model.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<Failure, SignUpModel>> signUp(String nationalID) async {
    try {
      final response = await remoteDataSource.signUp(nationalID);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');
        serviceLocator<IAppLocalStorage>()
            .setValue(AppStrings.userName, response.data['data']['name']);
        serviceLocator<IAppLocalStorage>()
            .setValue(AppStrings.userIdentityNumber, nationalID);
        var data = SignUpModel.fromJson(response.data);
        return Right(data);
      } else {
        log('Register Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('Register Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, CountriesModel>> getCountries() async {
    try {
      final response = await remoteDataSource.getCountries();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        var data = CountriesModel.fromJson(response.data);
        return Right(data);
      } else {
        log('Register Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('Register Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> completeSignUp(
    CompleteSignUpParams params,
  ) async {
    try {
      final response = await remoteDataSource.completeSignUp(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        String code =
            response.data['data']['code']; //TODO : return msg at production

        return Right(code);
      } else {
        log('Register Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('Register Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> login(LoginParams params) async {
    try {
      final response = await remoteDataSource.login(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        String code =
            response.data['data']['code']; //TODO : return msg at production
        serviceLocator<IAppLocalStorage>()
            .setValue(AppStrings.userName, response.data['data']['name']);
        serviceLocator<IAppLocalStorage>()
            .setValue(AppStrings.userIdentityNumber, params.identityNumber);

        return Right(code);
      } else if (response.statusCode == 401) {
        return Left(AppFailure(
          message: response.data['errors'][0]['message'],
        ));
      } else if (response.statusCode == 422) {
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
      return Left(AppFailure(
        message: response.data['errors'][0]['message'],
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> foregtPassword(String identityNumber) async {
    try {
      final response = await remoteDataSource.foregtPassword(identityNumber);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        String code =
            response.data['data']['code']; //TODO : return msg at production
        serviceLocator<IAppLocalStorage>()
            .setValue(AppStrings.userIdentityNumber, identityNumber);

        return Right(code);
      } else {
        return Left(AppFailure(
          message: response.data['errors'][0]['message'],
        ));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> resetPassword(
      ResetPasswordParams params) async {
    try {
      final response = await remoteDataSource.resetPassword(params);
      if (response.statusCode == 200) {
        // var data = AuthModel.fromJson(response.data);
        // await localDataSource.cacheToken(data.accessToken);
        //TODO cash cokkiy
        String message = response.data['message'];

        return Right(message);
      } else {
        return Left(AppFailure(
          message: response.data['errors'][0]['message'],
        ));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> verify(VerifyParams params) async {
    try {
      final response = await remoteDataSource.verify(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        //TODO cash cokkiy if it contain cookiy
        return Right(response.data['message'] ?? 'Verification successful');
      } else {
        return Left(AppFailure(
          message: response.data['errors'][0]['message'],
        ));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> resendCode(String identityNumber) async {
    try {
      final response = await remoteDataSource.resendCode(identityNumber);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        String code =
            response.data['data']['code']; //TODO : return msg at production
        return Right(code);
      } else {
        return Left(AppFailure(
          message: response.data['errors'][0]['message'],
        ));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
