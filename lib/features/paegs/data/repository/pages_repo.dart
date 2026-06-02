import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wathiq/features/paegs/data/models/notification_model.dart';
import 'package:wathiq/features/paegs/data/models/question_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/params/add_real_state_params.dart';
import '../../../../core/params/contact_us_params.dart';
import '../../../../core/params/get_questions_params.dart';
import '../../../../core/params/profile/sales_agent_params.dart';
import '../../../../core/params/properity_managment.dart';
import '../data_source/pages_remote_data_source.dart';
import '../models/categories_model.dart';
import '../models/social_model.dart';

class PagesRepository {
  final PagesRemoteDataSource remoteDataSource;

  PagesRepository({
    required this.remoteDataSource,
  });

  Future<Either<Failure, String>> addRealState(
      AddRealStateParams params) async {
    try {
      final response = await remoteDataSource.addRealState(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right('تم تقديم الطلب بنجاح');
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

  Future<Either<Failure, String>> properityManagment(
      ProperityManagment params) async {
    try {
      final response = await remoteDataSource.properityManagment(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right('تم تقديم الطلب بنجاح');
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

  Future<Either<Failure, QuestionsModel>> getQuestions(
      GetQuestionsParams params) async {
    try {
      final response = await remoteDataSource.getQuestions(params);
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        var data = QuestionsModel.fromJson(response.data);
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

  Future<Either<Failure, QestionsCategoriesModel>>
      getQestionsCategories() async {
    try {
      final response = await remoteDataSource.getCategories();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        var data = QestionsCategoriesModel.fromJson(response.data);
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

  Future<Either<Failure, SocialModel>> getSocial() async {
    try {
      final response = await remoteDataSource.getSocial();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        var data = SocialModel.fromJson(response.data);
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

  Future<Either<Failure, String>> postcontactUs(ContactUsParams params) async {
    try {
      final response = await remoteDataSource.postcontactUs(params);
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

  Future<Either<Failure, String>> createSalesAgent(
      SalesAgentParams params) async {
    try {
      final response = await remoteDataSource.createSalesAgent(params);
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

  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await remoteDataSource.getNotifications();
      if (response.statusCode! >= 200 && response.statusCode! <= 202) {
        log('Register Status code is 200');

        return Right(
            NotificationModel.notificationListFromJson(response.data["data"]));
      } else {
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

  Future<Either<Failure, String>> deleteNotifications() async {
    try {
      final response = await remoteDataSource.deleteNotifications();
      if (response.statusCode! >= 200 && response.statusCode! <= 204) {
        log('Register Status code is 200');

        return Right('تم حذف جميع الاشعارات بنجاح');
      } else {
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
