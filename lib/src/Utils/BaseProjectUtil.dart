import 'dart:io';

import 'package:base/src/Extends/DoubleExtend.dart';
import 'package:base/src/Extends/StringExtend.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../AppBase.dart';
import '../Common/Constant.dart';
import 'DialogUtil.dart';
import 'flutter_base/Util.dart';

class BaseProjectUtil {
  static String formatMoney(dynamic money) {
    if (money == null) {
      return "";
    } else if (money is String) {
      if (money.toInt() != null) {
        return Util.intToPriceDouble(money.toInt()!).replaceAll(".", ",");
      } else if (money.toDouble() != null) {
        return Util.intToPriceDouble(money.toDouble()!).replaceAll(".", ",");
      }
    } else if (money is double) {
      return Util.intToPriceDouble(money).replaceAll(".", ",");
    } else if (money is int) {
      return Util.intToPriceDouble(money).replaceAll(".", ",");
    }
    return "0";
  }

  static String convertMoney(
    double? value, {
    isDetail = false, //show chi tiết về đơn vị hay không
  }) {
    if (value == null) {
      return "";
    }
    var b = " tỷ";
    var m = " tr";
    var k = " ng";
    var unit = " ";
    if (isDetail) {
      b = " tỷ";
      m = " triệu";
      k = " nghìn";
      unit = " đ";
    }

    var price = value.toInt();
    var priceView = "";
    if (price >= 1000000000) {
      var priceNew = price / 1000000000;
      var priceString = priceNew.toRound(2).toStringRound();
      priceView = "$priceString$b";
    } else if (price >= 1000000) {
      var priceNew = price / 1000000;
      var priceString = priceNew.toRound(2).toStringRound();
      priceView = "$priceString$m";
    } else if (price >= 1000) {
      var priceNew = price / 1000;
      var priceString = priceNew.toRound(2).toStringRound();

      priceView = "$priceString$k";
    } else {
      priceView = "$price$unit";
    }
    return priceView;
  }

  static void share({
    String? title,
    String? subject,
  }) {
    Share.share(title ?? "", subject: subject ?? "Cenhomes.vn");
  }

  static String getMessageErrorGraphQL(QueryResult result) {
    if (result.exception != null && result.exception!.graphqlErrors.isNotEmpty) {
      return result.exception!.graphqlErrors[0].message;
    } else {
      return "Lỗi GraphQL";
    }
  }

  static String getCodeErrorGraphQL(QueryResult result) {
    if (result.exception != null && result.exception!.graphqlErrors.isNotEmpty) {
      return result.exception!.graphqlErrors[0].extensions?["code"] ?? "";
    } else {
      return "Lỗi GraphQL";
    }
  }

  static bool compareCodeErrorGraphQL(QueryResult result, String code) {
    if (result.exception != null && result.exception!.graphqlErrors.isNotEmpty) {
      for (var extension in result.exception!.graphqlErrors) {
        if (extension.extensions!['code'] == code) {
          return true;
        }
      }
    }
    return false;
  }

  static void copy(String content, {String? message}) {
    FlutterClipboard.copy(content).then((value) => Util.showToast(message ?? "Sao chép thành công"));
  }

  static String getTimeAgo(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return timeago.format(dateTime, locale: "vi_short");
  }

  static void askLogin(BuildContext context, Function()? onGoToLoginPage) {
    DialogUtil.showCompleteDialogQuestion(context,
      content: "Tính năng này cần phải đăng nhập\nBạn có muốn đăng nhập ngay không?",
      titleAction: "Đăng nhập",
      onButtonAction: onGoToLoginPage,
    );
  }

  static creatFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}${Constant.kFileName}');
    return file;
  }

  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get localFile async {
    final path = await localPath;
    return File('$path${Constant.kFileName}');
  }

  static Future<int> deleteFile() async {
    try {
      final file = await localFile;
      await file.delete();
    } catch (e) {
      return 0;
    }
    return 1;
  }

  static Future<bool> checkFileExist() async {
    try {
      if (await Directory("$localPath${Constant.kFileName}").exists()) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('e  eee ' + e.toString());
      return false;
    }
  }

  static Future<String> readFile() async {
    try {
      final file = await localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      print('readErrrrrrrrrrrrrrrrrrrrrr  ' + e.toString());
      return "";
    }
  }

  static Future<bool> writeFile(file, String text) async {
    try {
      await file.writeAsString(text);
      return true;
    } catch (e) {
      print('readErrrrrrrrrrrrrrrrrrrrrr  ' + e.toString());
      return false;
    }
  }

  static String resizeUrlImage({
    required String url,
    required double width,
    required double height,
  }) {
    // const mappingSize = {
    //   'list': '330x210',
    //   'detail': '633x350',
    //   'listNews': '254x160',
    //   'full': '1920x860',
    //   'origin': ''
    // };
    //if(type == 'source') return url;
    //const size = mappingSize[type] || mappingSize['list'];
    // '972x582' and '648x288' only support 2 size
    String size = width.toInt().toString() + "x" + height.toInt().toString();
    var link = url
        .replaceAll('https://images.cenhomes.vn', "https://img.cenhomes.vn${'/' + size}")
        .replaceAll('https://cenhomesvn.s3.ap-southeast-1.amazonaws.com', "https://img.cenhomes.vn${'/' + size}")
        .replaceAll('https://cenhomes-ai.s3-ap-southeast-1.amazonaws.com', "https://img.cenhomes.vn${'/' + size}")
        .replaceAll('https://cenhomesvn.s3.amazonaws.com', "https://img.cenhomes.vn${'/' + size}")
        .replaceAll('https://cenhomesvn.s3-ap-southeast-1.amazonaws.com', "https://img.cenhomes.vn${'/' + size}");
    return link;
    return url;
  }

  static convertStateApartment(String state) {
    switch (state) {
      case Constant.APT_CM:
        return "Chưa mở bán";
      case Constant.APT_CB:
        return "Chưa bán";
      case Constant.APT_GCTT:
        return "Giữ chỗ tạm thời";
      case Constant.APT_LO:
        return "Giữ chỗ";
      case Constant.APT_DC:
        return "Đã cọc";
      case Constant.APT_HT:
        return "Đã bán";
      case Constant.APT_HGC:
        return "Hủy giữ chỗ";
      case Constant.APT_HDC:
        return "Hủy đặt cọc";
      case Constant.APT_GCTC:
        return "Giữ chỗ thiện chí";
      case Constant.APT_HGCTC:
        return "Hủy giữ chỗ thiện chí";
      case Constant.APT_KNG:
        return "Khóa ngoại giao";
      default:
        return state;
    }
  }
}
