import 'dart:convert';

import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceLocalStorageImplementation implements IAppLocalStorage {
  final SharedPreferences shared;

  SharedPreferenceLocalStorageImplementation({required this.shared});

  @override
  Future<bool> deleteAll() async {
    return await shared.clear();
  }

  @override
  Future<bool> deleteValue(String key) async {
    return await shared.remove(key);
  }

  @override
  dynamic getValue(String key) {
    return shared.get(key);
  }

  @override
  Future<bool> setValue(String key, dynamic value) async {
    if (value is String) {
      return shared.setString(key, value);
    } else if (value is int) {
      return shared.setInt(key, value);
    } else if (value is double) {
      return shared.setDouble(key, value);
    } else if (value is bool) {
      return shared.setBool(key, value);
    } else if (value is Map || value is List) {
      return shared.setString(key, jsonEncode(value));
    } else {
      return shared.setString(key, value);
    }
  }
}
