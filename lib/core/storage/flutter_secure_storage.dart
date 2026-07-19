import 'package:wathiq/app/injector.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';

class SecureStorageServices {
  static const _cookieKey = 'cookie';

  SecureStorageServices._();

  static final SecureStorageServices _instance = SecureStorageServices._();
  factory SecureStorageServices() => _instance;

  final IAppLocalStorage _storage = serviceLocator<IAppLocalStorage>();

  String? _cookie;

  Future<void> setCookie({required String? cookie}) async {
    await _storage.setValue(_cookieKey, cookie);
    _cookie = cookie;
  }

  Future<void> deleteCookie() async {
    await _storage.deleteValue(_cookieKey);
    _cookie = null;
  }

  Future<String?> getCookie() async {
    if (_cookie != null) return _cookie;

    _cookie = _storage.getValue(_cookieKey)?.toString();
    return _cookie;
  }
}
