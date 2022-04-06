import 'dart:io';

import 'package:CenBase/CenBase.dart';
import 'package:CenBase/Service/ApiService.dart';
import 'package:FlutterBase/Utils/DeviceUtil.dart';
import 'package:FlutterBase/Utils/ScreenUtil.dart';
import 'package:FlutterBase/Utils/Util.dart';
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
    return this.toString().split('.').last;
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

  static action({
    String? screenName,
    String? screenTitle,
    ActionTracking action = ActionTracking.pageview,
    dynamic objectId,
    String? type,
    String? source,
  }) {
    try {
      var params = new Map<String, dynamic>();
      //

      params["dt"] = screenTitle;
      params["s"] = source;
      params["dl"] = screenName; //url
      params["t"] = type; //type các màn hình

      params["act"] = action.toShortString(); //action
      params["pid"] = objectId;

      //
      params["ts"] = DateTime.now().toIso8601String();
      params["cp"] = ""; //campaign - bỏ
      params["rl"] = ""; //referer - bỏ
      //user
      params["uid"] = CenBase.user?.sub; //user id
      params["ut"] = _getUserType(); //user id

      //device
      params["sr"] = "${ScreenUtil.screenSize?.width ?? ""}x${ScreenUtil.screenSize?.height ?? ""}"; //screenResolution
      params["vp"] = ""; //viewport -bỏ
      params["sd"] = "24-bit"; //bỏ
      params["de"] = "UTF-8";
      //
      params["ul"] = Platform.localeName; //ngôn ngữ máy
      params["bid"] = CenBase.packageName; //bundleId, packageName
      params["aid"] = CenBase.appId; //bundleId, packageName
      params["fprint"] = DeviceUtil.deviceId;
      params["os"] = platform;
      params["pf"] = "app";
      params["ov"] = DeviceUtil.deviceVersion; //OS version
      params["dv"] = DeviceUtil.deviceName; //Tên thiết bị
      params["v"] = appVersion; //OS version
      params["sid"] = CenBase.sessionId; //sessionId id sinh ra tu luc mo app den luc kill app
      //
      ApiService.tracking(params);
    } catch (ex) {}
  }

  static String _getUserType() {
    if (CenBase.user?.role != null) {
      if (CenBase.user!.role!.contains("CyberAgent") || CenBase.user!.role!.contains("LeadCyberAgent")) {
        return "ca";
      }
      if (CenBase.user!.role!.contains("Sale")) {
        return "sale";
      }
    }
    return "enduser";
  }
}
