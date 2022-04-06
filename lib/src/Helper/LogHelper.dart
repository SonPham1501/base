import 'dart:io';

import 'package:CenBase/Helper/SqfLiteHelper.dart';
import 'package:CenBase/Utils/BaseProjectUtil.dart';
import 'package:FlutterBase/Utils/DateTimeUtil.dart';
import 'package:FlutterBase/Utils/Util.dart';

import '../CenBase.dart';

enum EnumStatus { normal, disable }
enum EnumLogType { normal, api }

class LogHelper {
  static EnumStatus enumStatus = EnumStatus.normal;
  static EnumLogType enumLogType = EnumLogType.normal;

  static void saveLog(String text,
      {DateTime? timeStart, required EnumLogType logType}) async {
    var content = "";
    if (logType == EnumLogType.normal) {
      content +=
          "timeStart: ${DateTimeUtil.getFullDateAndTimeSecond(timeStart) ?? ""} \n";
    }
    var id = await Util.getDeviceIdentifier();
    content += "deviceId: $id \n";
    content += "userId: ${CenBase.user?.username ?? ""} \n";
    content += text;
    content += "\n----------------------------------------------------\n\n";
    if (logType == EnumLogType.normal) {
      APiLogModel aPiLogModel = APiLogModel(
        response: content,
        type: 1,
        timeStartRequest: timeStart.toString(),
      );
      SqfLiteHelper.insert(aPiLogModel);
    } else {
      APiLogModel aPiLogModel = APiLogModel(
        response: content,
        type: 2,
        timeStartRequest: timeStart.toString(),
      );
      SqfLiteHelper.insert(aPiLogModel);
    }
  }

  static Future<bool> creatLogFile() async {
    try {
      var text = "";
      var apiLog = await SqfLiteHelper.getListApiLog();
      for (var item in apiLog) {
        String content = item.response ?? "";
        text += content;
      }
      var isSuccess = await writeFile(text);
      return isSuccess;
    } on Exception catch (e) {
      return false;
    }
  }

  static Future<String> getContentByType(EnumLogType enumLogType) async {
    var apiLog = <APiLogModel>[];
    try {
      var text = "";
      if (enumLogType == EnumLogType.normal) {
        apiLog = await SqfLiteHelper.getListLogByType(1);
      } else {
        apiLog = await SqfLiteHelper.getListLogByType(2);
      }
      for (var item in apiLog) {
        String content = item.response ?? "";
        text += content;
      }
      return text;
    } on Exception catch (e) {
      return "";
    }
  }

  static void resetDatabase() {
    BaseProjectUtil.deleteFile();
    SqfLiteHelper.delete();
  }

  static Future<bool> writeFile(String text) async {
    try {
      File file = await BaseProjectUtil.localFile;
      var isSuccess = await BaseProjectUtil.writeFile(file, text);
      return isSuccess;
    } on Exception catch (e) {
      return false;
    }
  }
}
