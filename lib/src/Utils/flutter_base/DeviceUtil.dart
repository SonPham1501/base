import 'dart:io';

import 'package:device_info/device_info.dart';

import 'Util.dart';

class DeviceUtil {
  static String? deviceName;
  static String? deviceVersion;
  static String? deviceId;//duy nhất khi cài app

  static Future initData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = "${androidInfo.brand}_${androidInfo.model}";
      deviceVersion = androidInfo.version.release;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
      deviceVersion = iosInfo.systemVersion;
    }
    deviceId = await Util.getDeviceIdentifier();
  }
}
