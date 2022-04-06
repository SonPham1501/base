import 'package:CenBase/CenBase.dart';
import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Model/UpdateModel.dart';
import 'package:CenBase/Page/Update/NotiUpdatePage.dart';
import 'package:CenBase/Page/Update/Widget/DialogNoticeWidget.dart';
import 'package:CenBase/Service/ApiService.dart';
import 'package:CenBase/View/ChooseImage/ChooseImage.dart';
import 'package:FlutterBase/Utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class UpdateHelper {
  static String versionApp = "";
  static String packageName = "";
  static UpdateItemModel? latestUpdateItem;

  static void checkVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionApp = packageInfo.version;
    String packName = packageInfo.packageName;
    packageName = packName;
    getListUpdate(context, packName);
  }

  static void getListUpdate(
    BuildContext context,
    String packName,
  ) async {
    var listVersion = await PreferUtil.getString(Constant.kListUpdated);

    var response = await ApiService.getListUpdate();
    if (response.statusCode == 200) {
      var data = UpdateModel.fromJson(response.data);
      var listUpdate = data.data ?? <UpdateItemModel>[];
//      listUpdate.add(UpdateItemModel(version: "3.0.0", isForceUpdate: false));
//      listUpdate.add(UpdateItemModel(version: "4.12.1", isForceUpdate: false));
//      listUpdate.add(UpdateItemModel(version: "4.13.11", isForceUpdate: false));
//      listUpdate.add(UpdateItemModel(version: "5.11.13", isForceUpdate: false));
//      listUpdate.add(UpdateItemModel(version: "5.1.13", isForceUpdate: false));
      var latestItem = versionApp;
      var latestItemDialog = versionApp;
      var latestItemDialogIndex = 0;
      var latestItemIndex = 0;
      bool isForceUpdate = false;
      UpdateItemModel? _updateItemModel;
      for (int i = 0; i < listUpdate.length; i++) {
        var item = listUpdate[i];
        var isNew = Util.checkNewVersionWithOldVersion(oldVersion: versionApp, newVersion: item.version!);
        if (isNew) {
          _updateItemModel = item;
        }
        if (isNew && item.isForceUpdate!) {
          isForceUpdate = true;
        }
      }

      if (isForceUpdate) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotiUpdatePage(
            packageName: packName,
            updateItemModel: _updateItemModel!,
            isForceUpdate: true,
          ),
        ));
        return;
      }

      for (int i = 0; i < listUpdate.length; i++) {
        var isNew = Util.checkNewVersionWithOldVersion(oldVersion: versionApp, newVersion: listUpdate[i].version!);
        if (isNew && !listUpdate[i].isForceUpdate!) {
          if (Util.checkNewVersionWithOldVersion(oldVersion: latestItem, newVersion: listUpdate[i].version!)) {
            latestItem = listUpdate[i].version!;
            latestItemIndex = i;
            latestUpdateItem = listUpdate[i];
          }
        }
        if (isNew && !listUpdate[i].isForceUpdate! && !listVersion.contains(listUpdate[i].version!)) {
          if (Util.checkNewVersionWithOldVersion(oldVersion: latestItemDialog, newVersion: listUpdate[i].version!)) {
            latestItemDialog = listUpdate[i].version!;
            latestItemDialogIndex = i;
          }
        }
      }

      if (latestItemDialog != versionApp) {
        print('ver app' + versionApp);
        listVersion += ("$latestItemDialog ");
        PreferUtil.setString(Constant.kListUpdated, listVersion);
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return DialogNoticeWidget(
              updateItemModel: listUpdate[latestItemDialogIndex],
              onTapUpdate: () {
                Navigator.of(context).pop();
                if (Platform.isAndroid) {
                  Util.openURL("https://play.google.com/store/apps/details?id=" + packName);
                } else {
                  Util.openURL(CenBase.urlAppStore);
                }
              },
              onTapSeeMore: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotiUpdatePage(
                    packageName: packName,
                    updateItemModel: listUpdate[latestItemDialogIndex],
                  ),
                ));
              },
            );
          },
        );
      }
    }
  }
}
