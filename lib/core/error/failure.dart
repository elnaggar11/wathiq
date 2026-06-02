import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final int? statesCode;
  final Map<String, dynamic>? data;

  const Failure({this.message, this.data, this.statesCode});

  @override
  List<Object?> get props => [message];
}

class AppFailure extends Failure {
  const AppFailure({super.message, super.data, super.statesCode});

  @override
  List<Object?> get props => [message, data, statesCode];
}

class EditProfileFailure extends Failure {
  // List<String>
  // @override
  // final Map<String, dynamic>? data;

  const EditProfileFailure({super.message, super.data});

  @override
  List<Object?> get props => [message, data];
}

class SliderFailure extends Failure {
  const SliderFailure({
    super.message,
    super.data,
  });

  @override
  List<Object?> get props => [
        message,
        data,
      ];
}

class UpdateAnswerPinnedFailure extends Failure {
  const UpdateAnswerPinnedFailure({
    super.message,
    super.data,
  });

  @override
  List<Object?> get props => [
        message,
        data,
      ];
}

class GetUserFavoriteAnswerFailure extends Failure {
  const GetUserFavoriteAnswerFailure({
    super.message,
    super.data,
  });

  @override
  List<Object?> get props => [
        message,
        data,
      ];
}

class AddToFavoriteFailure extends Failure {
  const AddToFavoriteFailure({
    super.message,
    super.data,
  });

  @override
  List<Object?> get props => [
        message,
        data,
      ];
}

class CityFailure extends Failure {
  const CityFailure({
    super.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class AddQuestionFailure extends Failure {
  const AddQuestionFailure({
    super.message,
    super.data,
  });

  @override
  List<Object?> get props => [
        message,
        data,
      ];
}

class AddAnswerFailure extends Failure {
  const AddAnswerFailure({
    super.message,
    super.data,
  });

  @override
  List<Object?> get props => [message, data];
}

class AnswersFailure extends Failure {
  const AnswersFailure({
    super.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class UserAnswersFailure extends Failure {
  const UserAnswersFailure({
    super.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class CountryFailure extends Failure {
  const CountryFailure({
    super.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class NationalityFailure extends Failure {
  const NationalityFailure({
    super.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class ProfileFailure extends Failure {
  const ProfileFailure({
    super.message,
    super.data,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class OnBoardingFailure extends Failure {
  const OnBoardingFailure({
    super.message,
    super.data,
  });

  @override
  List<Object?> get props => [
        message,
        data,
      ];
}

class NoInternetFailure extends Failure {
  const NoInternetFailure() : super(message: 'No Internet Connection');
}

class ServerFailure extends Failure {
  const ServerFailure({super.message, super.data});
  @override
  List<Object?> get props => [
        message,
        data,
      ];
}

class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure()
      : super(message: 'Location permissions are denied');
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure({super.message, super.data});
  @override
  List<Object?> get props => [message, data];
}
