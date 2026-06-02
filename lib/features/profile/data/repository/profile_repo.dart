import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wathiq/core/params/profile/create_agency_params.dart';
import 'package:wathiq/features/profile/data/models/profile_model.dart';

import 'package:wathiq/app/injector.dart';
import 'package:wathiq/core/error/failure.dart';
import 'package:wathiq/core/params/profile/change_password_params.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:wathiq/features/profile/data/models/agencies_model.dart';

class ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepository({
    required this.remoteDataSource,
  });

  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final response = await remoteDataSource.getProfile();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        var data = ProfileModel.fromJson(response.data);
        serviceLocator<IAppLocalStorage>().setValue(
          AppStrings.userImage,
          data.data.profileImage,
        );
        serviceLocator<IAppLocalStorage>().setValue(
          AppStrings.userId,
          data.data.id,
        );
        serviceLocator<IAppLocalStorage>().setValue(
          AppStrings.userName,
          data.data.name,
        );
        serviceLocator<IAppLocalStorage>().setValue(
          AppStrings.phoneNum,
          data.data.phoneNumber.number,
        );
        serviceLocator<IAppLocalStorage>().setValue(
          AppStrings.Useremail,
          data.data.email,
        );
        serviceLocator<IAppLocalStorage>().setValue(
          AppStrings.userIdentityNumber,
          data.data.identityNumber,
        );
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

  Future<Either<Failure, String>> changeProfileImage(
      File? imageFile, String? countryID) async {
    try {
      final response =
          await remoteDataSource.changeProfileImage(imageFile, countryID);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right(response.data['message']);
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

  Future<Either<Failure, String>> askAddEmail() async {
    try {
      final response = await remoteDataSource.askAddEmail();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right(response.data['data']['code']); //TODO : replase with msg
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

  Future<Either<Failure, String>> addEmail(String email) async {
    try {
      final response = await remoteDataSource.addEmail(email);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right(response.data['data']['code']);
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

  Future<Either<Failure, String>> askEditPhone() async {
    try {
      final response = await remoteDataSource.askEditPhone();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right(response.data['data']['code']); //TODO : replase with msg
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

  Future<Either<Failure, String>> addPhone(String phone) async {
    try {
      final response = await remoteDataSource.addPhone(phone);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right(response.data['data']['code']);
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

  Future<Either<Failure, String>> changePassword(
      ChangePasswordParams params) async {
    try {
      final response = await remoteDataSource.changePassword(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right(response.data['message']);
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

  Future<Either<Failure, String>> deleteAccount() async {
    try {
      final response = await remoteDataSource.deleteAccount();
      if (response.statusCode! >= 200 && response.statusCode! <= 204) {
        log('Register Status code is 200');

        return const Right('تم حذف الحساب بنجاح');
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

  Future<Either<Failure, AgenciesModel>> getAgencies(String status) async {
    try {
      final response = await remoteDataSource.getAgencies(status);
      if (response.statusCode! >= 200 && response.statusCode! <= 204) {
        var data = AgenciesModel.fromJson(response.data);

        log('getAgencies Status code is 200');

        return Right(data);
      } else {
        log('getAgencies Status code is 422');
        return Left(
          AppFailure(
            message: response.data['errors'][0]['message'],
          ),
        );
      }
    } catch (e) {
      log('getAgencies Repository Exception Error: $e');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> createAgency(
      CreateAgencyParams params) async {
    try {
      final response = await remoteDataSource.createAgency(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right(response.data['message']);
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

  Future<Either<Failure, String>> deleteAgencies(String agencyId) async {
    try {
      final response = await remoteDataSource.deleteAgencies(agencyId);
      if (response.statusCode! >= 200 && response.statusCode! <= 204) {
        log('Register Status code is 200');

        return Right(response.data['message']);
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

  Future<Either<Failure, String>> activeAgencies(String agencyId) async {
    try {
      final response = await remoteDataSource.activeAgencies(agencyId);
      if (response.statusCode! >= 200 && response.statusCode! <= 204) {
        log('Register Status code is 200');

        return Right(response.data['message']);
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

  Future<Either<Failure, String>> logOut() async {
    try {
      final response = await remoteDataSource.logOut();
      if (response.statusCode! >= 200 && response.statusCode! <= 204) {
        log('Register Status code is 200');

        return const Right('تم تسجيل الخروج بنجاح');
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
}
