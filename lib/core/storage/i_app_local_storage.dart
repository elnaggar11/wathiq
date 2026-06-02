abstract class IAppLocalStorage {
  Future setValue(String key, dynamic value);
  dynamic getValue(String key);
  Future deleteValue(String key);
  Future deleteAll();
}
