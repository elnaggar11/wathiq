import 'package:equatable/equatable.dart';

class ChangePasswordParams extends Equatable {
  String? newPassword;
  String? oldPassword;
  ChangePasswordParams({
    this.newPassword,
    this.oldPassword,
  });

  @override
  List<Object?> get props => [
        newPassword,
        oldPassword,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'newPassword': newPassword,
      'oldPassword': oldPassword,
    };
  }
}
