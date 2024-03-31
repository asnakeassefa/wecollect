import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataSource {
  static Future<String?> readFromStorage(String key) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final data = await secureStorage.read(key: key);
    return data;
  }

  static Future<void> writeToStorage(String key, String val) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: key, value: val);
  }

  static Future<void> deleteFromStorage(String key) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: key);
  }
}
