
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class SecureStorageUtil {
  static String? deviceId;
  static String Key_DeviceId = "deviceId";
  static var uuid = Uuid();

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
    final storage = new FlutterSecureStorage();
    final prefs = await storage.readAll();
    if (!prefs.containsKey(key)) {
      storage.write(key: key, value: stringValue);
    }
  }

  static Future checkKey(String key) async {
    final storage = new FlutterSecureStorage();
    var value = await storage.readAll();
    return value.containsKey(key);
  }

  static Future setString(String key, String stringValue) async {
    final storage = new FlutterSecureStorage();
    storage.write(key: key, value: stringValue);
  }

  static Future<String> getString(String key) async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: key);
    return value ?? "";
  }
}
