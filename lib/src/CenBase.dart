
import 'package:CenBase/Helper/TrackingHelper.dart';
import 'package:CenBase/Model/UserModel.dart';
import 'package:CenBase/Service/ApiService.dart';
import 'package:CenBase/View/ChooseImage/ChooseImage.dart';
import 'package:FlutterBase/Utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

import 'Common/Enum.dart';
import 'Utils/BaseResourceUtil.dart';
import 'package:timeago/timeago.dart' as timeago;

typedef SocialWidgetBuilder = Widget Function(
  Map<String, dynamic> data, {
  Function()? onSeenNotify,
  Function()? onDeleteNotify,
  Function()? onDeleteNotifyQuestion,
  SlidableController? slidableController,
});

class CenBase {
  static String? accessToken; // null là chưa đăng nhập
  static String? refreshToken;
  static String? systemToken;
  static AppName appName = AppName.Cenhomes;
  static UserModel? user;
  static Function()? logout;
  static Function()? onLogoutApi; //khi hết hạn token sẽ call logout
  static Function()? onAccessTokenNew;
  static Function()? onSystemTokenNew;
  static Function()? onGoToLoginPage;
  static Function(BuildContext context)? onRegisterAgency;
  static Function(bool isBuy)? onGoToPostUp;
  static Function(String userId, {List<String>? message})? chatWithUserId;
  static Function(String? channelId)? chatWithChannel;
  static Function(String? roomId)? chatWithRoom;
  static Function()? chatLive;
  static Function(int index)? onMainTab;
  static Function()? goToEditProfileCenID;
  static Function(String slug, bool isBuy)? goToBuyRentDetail;
  static SocialWidgetBuilder? socialWidgetBuilder;
  static var isSocial = false;

  static String baseUrlCenID = "";
  static String baseUrlCenID2 = "";

  static String baseUrlGraphQLCenTrade = ""; //"https://banghang-graphql-sandbox.cenpush.com/v1/graphql";
  static String baseUrWSSCenTrade = ""; //"wss://banghang-graphql-sandbox.cenpush.com/v1/graphql";
  //static String baseUrWSSRegister = "https://omnichannel.cenpush.com/api/graphql";
  static String baseUpdateUrl = ""; //"https://cenhome-api-sandbox.cenpush.com/";
  static String baseUrlTracking = "";

  static String clientID = "";
  static String clientSecret = "";
  static String appStoreId = "";
  static String urlAppStore = "";

  static String packageName = "";
  static String version = "";
  static String buildVersion = "";
  static String sessionId = "";//phiên làm việc từ lúc mở app tới lúc kill app
  static String deviceName = "";


  static final googleMapKey = "AIzaSyBbmxOMWOV2OTV0tR0LkMtohUcikyvYC64";
  static var firebaseTokenSubject = new BehaviorSubject<String>.seeded("");
  static var userInfoSubject = new BehaviorSubject();
  static late CenBuildType buildType;

  static const String urlPaymentPolicy = "https://cenhomes.vn/tin-tuc/dieu-khoan-thanh-toan-11";
  static const String urlPrivacyPolicy = "https://sandbox.cenhomes.vn/tin-tuc/chinh-sach-bao-mat-thong-tin-69965";
  static const String urlCenValue = "https://gianhadat.cenhomes.vn/landing";
  static const String urlAboutCenhomes = "https://cenhomes.vn/ve-cenhomes";

  static init({CenBuildType buildType = CenBuildType.test}) async {
    BaseResourceUtil.pathResource = "packages/CenBase/assets/";
    CenBase.buildType = buildType;
    if (buildType == CenBuildType.test) {
      //CenId
      baseUrlCenID = "https://account-sandbox.cenhomes.vn/";
      clientID = "cen_mobile";
      clientSecret = "9953150b-1aea-83f3-a4c9-d27bc4ca19ed";

      baseUrlGraphQLCenTrade = "https://banghang-graphql-sandbox.cenpush.com/v1/graphql";
      baseUrWSSCenTrade = "wss://banghang-graphql-sandbox.cenpush.com/v1/graphql";

      baseUpdateUrl = "https://cenhome-api-sandbox.cenpush.com/";
      baseUrlTracking = "https://tracking-sandbox.cenhomes.vn/";
    } else if (buildType == CenBuildType.product) {
      //CenId
      baseUrlCenID = "https://account.cenhomes.vn/";
      baseUrlCenID2 = "https://srv.cenhomes.vn/";
      clientID = "cen_mobile";
      clientSecret = "e0d6ec06-ae9b-bbbc-6c00-56156e9a0ea8";

      baseUrlGraphQLCenTrade = "https://trade-graphql.cenhomes.vn/v1/graphql";
      baseUrWSSCenTrade = "wss://trade-graphql.cenhomes.vn/v1/graphql";

      baseUpdateUrl = "https://api-v3.cenhomes.vn/";
      baseUrlTracking = "https://tracking.cenhomes.vn/";
    } else {
      Util.showToast("Chưa thiết lập môi đường dẫn môi trường CenID");
    }
    sessionId = Util.getUuid();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildVersion = packageInfo.buildNumber;
    timeago.setLocaleMessages('vi_short', ViShortMessages());

    TrackingHelper.initData();
  }

  static dispose() {
    firebaseTokenSubject.close();
    userInfoSubject.close();
  }

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

  static onLogout() {
    accessToken = null;
    refreshToken = null;
    systemToken = null;
    user = null;
    logout?.call();
  }

  static Future getUserInfo() async {
    var response = await ApiService.getUserInfo();
    if (response.statusCode == 200) {
      var data = UserModel.fromJson(response.data);
      CenBase.user = data;
      CenBase.userInfoSubject.add(null);
    }
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
