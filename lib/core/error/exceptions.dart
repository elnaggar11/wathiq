import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];
}

class FetchDataException extends ServerException {
  const FetchDataException([String? message])
      : super('Error During Communication');
}

class BadRequestException extends ServerException {
  const BadRequestException([String? message]) : super('Bad Request');
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([String? message]) : super('Unauthorized');
}

class NotFoundException extends ServerException {
  const NotFoundException([String? message]) : super('Request Info Not Found');
}

class ConflictException extends ServerException {
  const ConflictException([String? message]) : super('Conflict Occurred');
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([String? message])
      : super('Internal Server Error');
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([String? message])
      : super('No Internet Connection');
}

class CancelRequestException extends ServerException {
  const CancelRequestException([String? message]) : super('Cancel Request');
}

class UnknownException extends ServerException {
  const UnknownException([String? message]) : super('Unknown ');
}

class BadCertificateException extends ServerException {
  const BadCertificateException([String? message]) : super('Bad Certificate');
}

class CachedException extends ServerException {
  const CachedException([String? message]) : super('Cached Exception');
}
