import 'dart:io';

import 'package:base/src/AppBase.dart';
import 'package:base/src/Service/ApiService.dart';
import 'package:base/src/Utils/ScreenUtil.dart';
import 'package:base/src/Utils/flutter_base/DeviceUtil.dart';
import 'package:package_info/package_info.dart';

//action: /submitform: khi submit form, subscribe: khi submit form đăng ký nhận bản tin qua email, chat: click to chat, call: click to call, scrollend: cuộn trang đến cuối, pageview: load page
enum ActionTracking {
  submitform,
  subscribe,
  chat,
  call,
  scrollend,
  pageview,
}

extension ParseToString on ActionTracking {
  String toShortString() {
    return toString().split('.').last;
  }
}

class TrackingHelper {
  static String appVersion = "";
  static String buildNumber = "";
  static String platform = "";
  static String languageCode = "vi";
  static String deviceInfo = "";

  static Future initData() async {
    if (Platform.isAndroid) {
      platform = "android";
    } else {
      platform = "ios";
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }
}
