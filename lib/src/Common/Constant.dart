
import 'package:flutter/material.dart';

class Constant{
  static const Color kColorOrangePrimary = Color(0xFFF6891F);
  static const Color kColorBlackPrimary = Color(0xFF14142B);

  static const kGreyColor = Color(0xFF6E7191);
  static const kGreyColor4E = Color(0xFF4E4B66);
  static const kNormalTextColor = Color(0xFF192038);
  static const kTextTitleColor = Color(0xFF5E5873);
  static const kGreenColor = Color(0xFF00BA88);
  static const kRedColor = Color(0xFFFF0000);

  static const kErrorColor = Color(0x33FF3B30);
  static const kLineColor = Color(0xFFDDDEE6);
  static const white = Colors.white;

  static const kColorGreyCC = Color(0xffCCCCCC);
  static const kColorBgE5 = Color(0xffE5E5E5);
  static const kColorBgF5 = Color(0xffF5F7FC);
  static const Color kColorWhite = Colors.white;
  static const Color kColorBlack = Colors.black;
  static const Color kColorDisable = Color(0xffD9DBE9);
  static final Color kColorInputDisable = const Color(0xffD9DBE9).withOpacity(0.3);
  static const Color kColorTransparent = Colors.transparent;

  static const Color kColorBorderD9DBE9 = Color(0xffD9DBE9);
  static const Color kColorBorderInput = Color(0xffD9DBE9);
  static const Color kColorBorderInputSelector = Color(0xffF6891F);
  static const Color kColorBlueLink = Color(0xff007AFF);
  static const Color kColorBackground = Color(0xffF3F4F5);
  static const Color kColorBackgroundInput = Color(0xffF8F8FA);
  static const Color kColorBackgroundInputF5 = Color(0xffF5F7FC);
  static const Color kColorBackgroundBack = Color(0xffF4F4F5);
  static const Color kColorRedLine = Color(0xffEE3D48);
  static const Color kColorGreyInactive = Color(0xffE4E9F2);
  static const Color kColorButtonSuccess= Color(0xffD9DBE9);
  static const Color kColorLineDetail = Color(0xFFF5F5F5);

  static final kColorGradientBlue = [const Color(0xFF0A69DA),const Color(0xFF0856C8),const Color(0xFF0231A5)];

  static const Color kColorText6E71 = Color(0xff6E7191);
  static const Color kColorText141 = Color(0xff14142B);

  static const String kFontSF = 'SF';
  static const String kFontRoboto = 'Roboto';

  static const String kAccessToken = "access_token";
  static const String kRefreshToken = "refresh_token";
  static const String kUserInfo = "user_info";
  static const String kHistorySearch = "history_search";
  static const String kHistorySearchUnit = "history_search_unit";
  static const String kAesKey = "as_123_key";
  static const String kFirstLogin = "first_login";
  static const String kKeyboardHeight = "keyboard_height";

  static const String kUserName = "user_name";
  static const String kPassword = "info_user";

  static String? OPERATION_NAME ="widgetsSaveLead";
  static String? QUERY = r'''
  mutation widgetsSaveLead($integrationId: String!, $formId: String!, $submissions: [FieldValueInput], $browserInfo: JSON!, $cachedCustomerId: String) {\n  widgetsSaveLead(integrationId: $integrationId, formId: $formId, submissions: $submissions, browserInfo: $browserInfo, cachedCustomerId: $cachedCustomerId) {\n    status\n    messageId\n    customerId\n    errors {\n      fieldId\n      code\n      text\n      __typename\n    }\n    __typename\n  }\n}\n                                                   
''';

  static String queries= r'''
    mutation widgetsSaveLead($integrationId: String!, $formId: String!, $submissions: [FieldValueInput], $browserInfo: JSON!, $cachedCustomerId: String) {
      widgetsSaveLead(integrationId: $integrationId, formId: $formId, submissions: $submissions, browserInfo: $browserInfo, cachedCustomerId: $cachedCustomerId) {
          status
              messageId
                  customerId
                      errors {
                            fieldId
                                  code
                                        text
                                              __typename
                                                  }
                                                      __typename
                                                        }
                                                        }
                                                                                                                                                  
''';

  static var kIntegrationID = "";
  static var kListUpdated = "list_update";
  static var kFormId = "";

  static String kCachedCustomer = "cach_customer";

  static String IOSLinkStore= "https://apps.apple.com/vn/app/cenhomes/id1462680353?l=vi";

  static var kFileName= "/netWorkLog.txt";
  static var kOldTime= "old_time_log";
  static var kDatabase= "apiLog.db";
  static var kPostUpDatabase= "postUpSave.db";
  static var kTableDatabase= "apiLogTable";
  static var kPostUpTableDatabase= "postUpSaveTable";
  static var kIsCreatTable= "creat_table";

  static var kSocialUrl = "https://social-sandbox.cenhomes.vn";



  static const APT_CM = 'CM';
  static const APT_CB = 'CB';
  static const APT_GCTT = 'GCTT';
  static const APT_LO = 'LO';
  static const APT_DC = 'DC';
  static const APT_HT = 'HT';
  static const APT_HGC = 'HGC';
  static const APT_HDC = 'HDC';
  static const APT_GCTC = 'GCTC';
  static const APT_HGCTC = 'HGCTC';
  static const APT_KNG = 'KNG';

  static const FRIEND_TAG = 'FRIEND_TAG';
  static const GROUP_TAG = 'GROUP_TAG';
  static const GROUP_SINGLE_TAG = 'GROUP__SINGLE_TAG';
  static const NEWFEED_TAG = 'NEWFEED_TAG';
  static const PERSONAL_TAG = 'PERSONAL_TAG';


}