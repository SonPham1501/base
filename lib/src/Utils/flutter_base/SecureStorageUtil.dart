
// ignore_for_file: constant_identifier_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class SecureStorageUtil {
  static const Token = 'token';
  static const TemporallyToken = 'temporally_token';
  static String? deviceId;
  static String Key_DeviceId = "deviceId";
  static var uuid = const Uuid();

  static Future init() async {
    //print("==============================uuid============================== $id");
    if (!await checkKey(Key_DeviceId)) {
      var id = uuid.v4();
      deviceId = id;
      createString(Key_DeviceId, deviceId!);
    } else {
      deviceId = await getString(Key_DeviceId);
    }
    print("==============================deviceId============================== $deviceId");
  }

  //String

  static Future createString(String key, String stringValue) async {
    const storage = FlutterSecureStorage();
    final prefs = await storage.readAll();
    if (!prefs.containsKey(key)) {
      storage.write(key: key, value: stringValue);
    }
  }

  static Future checkKey(String key) async {
    const storage = FlutterSecureStorage();
    var value = await storage.readAll();
    return value.containsKey(key);
  }

  static Future setString(String key, String stringValue) async {
    const storage = FlutterSecureStorage();
    storage.write(key: key, value: stringValue);
  }

  static Future<String> getString(String key) async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: key);
    return value ?? "";
  }

  static Future removeString(String key) async {
    const storage = FlutterSecureStorage();
    storage.delete(key: key);
  }
}
