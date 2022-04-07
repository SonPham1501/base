import 'dart:io';

import 'package:base/src/Common/export_common.dart';
import 'package:base/src/Helper/TrackingHelper.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'Utils/BaseResourceUtil.dart';


class AppBase {
  static void init({
    required CenBuildType buildTypeInit,
    String? fingerInit,
  }) {
    BaseResourceUtil.pathResource = "packages/CenBase/assets/";
    finger = fingerInit;
    buildType = buildTypeInit;
    sessionId = Util.getUuid();
    PackageInfo.fromPlatform().then((packageInfo) {
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildVersion = packageInfo.buildNumber;
    });
    timeago.setLocaleMessages('vi_short', ViShortMessages());

    TrackingHelper.initData();
  }

  static CenBuildType buildType = CenBuildType.test;
  static String packageName = "";
  static String version = "";
  static String buildVersion = "";
  static String sessionId = "";//phiên làm việc từ lúc mở app tới lúc kill app
  static String deviceName = "";
  static String? finger;

  static String get appId {
    var build = "test";
    var platform = "ios";
    if (buildType == CenBuildType.product) {
      build = "product";
    }
    if (buildType == CenBuildType.staging) {
      build = "staging";
    }
    if (Platform.isAndroid) {
      platform = "android";
    }
    var id = "$packageName.$platform.$build";
    debugPrint(id);
    return id;
  }
}

class ViShortMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'bây giờ';

  @override
  String aboutAMinute(int minutes) => '1 phút';

  @override
  String minutes(int minutes) => '$minutes phút';

  @override
  String aboutAnHour(int minutes) => '1 giờ';

  @override
  String hours(int hours) => '$hours giờ';

  @override
  String aDay(int hours) => '1 ngày';

  @override
  String days(int days) => '$days ngày';

  @override
  String aboutAMonth(int days) => '1 tháng';

  @override
  String months(int months) => '$months tháng';

  @override
  String aboutAYear(int year) => '1 năm';

  @override
  String years(int years) => '$years năm';

  @override
  String wordSeparator() => ' ';
}
