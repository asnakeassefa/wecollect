import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  Future<void> saveData(String key, String value) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> getData(String key) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: key) ?? "";
  }

  Future<void> deleteData(String key) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: key);
  }
}
