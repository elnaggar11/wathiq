import '../../../../core/storage/i_app_local_storage.dart';
import '../../../../core/utils/constant.dart';

class AuthLocalDataSource {
  final IAppLocalStorage localStorage;

  const AuthLocalDataSource(this.localStorage);

  Future<void> cacheToken(String token) async {
    await localStorage.setValue(AppConstant.token, token);
  }

  Future<void> deleteToken() async {
    print('token has been deleted');
    await localStorage.deleteValue(AppConstant.token);
  }
}
