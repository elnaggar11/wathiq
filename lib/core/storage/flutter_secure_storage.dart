import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageServices extends FlutterSecureStorage {
  static const String cookieToken = "cookie";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? _cookie;

  Future<void> setCookie({required String? cookie}) async {
    try {
      await storage.write(key: cookieToken, value: cookie);
      _cookie = cookie;
    } catch (e) {
      print('Error writing cookie: $e');
      // محاولة إعادة تعيين التخزين
      await _resetStorage();
    }
  }

  Future<void> deleteCookie() async {
    try {
      await storage.delete(key: cookieToken);
      _cookie = null;
    } catch (e) {
      print('Error deleting cookie: $e');
      await _resetStorage();
    }
  }

  Future<String?> getCookie() async {
    try {
      _cookie = await storage.read(key: cookieToken);
      print('getCookie: $_cookie');
      return _cookie;
    } catch (e) {
      print('Error reading cookie: $e');
      // محاولة إعادة تعيين التخزين
      await _resetStorage();
      return null;
    }
  }

  Future<void> _resetStorage() async {
    try {
      // حذف جميع البيانات المخزنة
      await storage.deleteAll();
      _cookie = null;
      print('Storage has been reset');
    } catch (e) {
      print('Error resetting storage: $e');
    }
  }

  set cookie(String? cookie) {
    _cookie = cookie;
  }

  String? get cookie {
    return _cookie;
  }
}
