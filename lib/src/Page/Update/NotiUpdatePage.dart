import 'package:base/src/CenBase.dart';
import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Model/UpdateModel.dart';
import 'package:base/src/Page/Update/NotiUpdateController.dart';
import 'package:base/src/Utils/BaseResourceUtil.dart';
import 'package:base/src/Utils/FontUtil.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';
import 'package:base/src/View/ChooseImage/ChooseImage.dart';
import 'package:base/src/Widget/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NotiUpdatePage extends StatelessWidget {
  late NotiUpdateController _notiUpdateController;
  UpdateItemModel updateItemModel;
  String packageName;
  bool isForceUpdate;

  NotiUpdatePage({
    required this.updateItemModel,
    required this.packageName,
    this.isForceUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    _notiUpdateController = Provider.of<NotiUpdateController>(
      context,
      listen: false,
    );
    return WillPopScope(
      onWillPop: () async {
        if (isForceUpdate) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Image.asset(BaseResourceUtil.icon("img_noti.png")),
                  ),
                  Positioned(
                    top: 4,
                    left: 4,
                    child: !isForceUpdate
                        ? IconButton(
                            icon: SvgPicture.asset(
                              BaseResourceUtil.icon("ic_arrow_left.svg"),
                              color: Constant.kColorOrangePrimary,
                            ),
                            onPressed: Navigator.of(context).pop,
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  isForceUpdate ? "Ứng dụng cần phải cập nhật" : "Thông báo cập nhật",
                  style: TextStyle(fontSize: 20, fontFamily: FontUtil.bold),
                ),
              ),
              if (isForceUpdate)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Text(
                    "Để tiếp tục sử dụng ứng dụng, vui lòng hãy tải xuống phiên bản mới nhất",
                    style: TextStyle(fontSize: 16, fontFamily: FontUtil.regular),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              if (updateItemModel.description != null && updateItemModel.description!.isNotEmpty)
                Container(
                  decoration: const BoxDecoration(
                    color: Constant.kColorBackgroundInput,
                  ),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Nội dung phiên bản cập nhật ${updateItemModel.version}",
                            style: TextStyle(fontSize: 13, fontFamily: FontUtil.semiBold, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(updateItemModel.description ?? "",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: FontUtil.regular,
                            color: Colors.black,
                          )),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Phiên bản cập nhật: ${updateItemModel.version}",
                    style: TextStyle(fontSize: 13, fontFamily: FontUtil.semiBold, color: Colors.black),
                  ),
                ),
              const Expanded(child: SizedBox()),
              Consumer<NotiUpdateController>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: ButtonWidget(
                            onTap: () {
                              if (Platform.isAndroid) {
                                Util.openURL(
                                    "https://play.google.com/store/apps/details?id=" +
                                        packageName);
                              } else {
                                Util.openURL(CenBase.urlAppStore);
                              }
                            },
                            buttonType: value.isAgree
                                ? ButtonType.Normal
                                : ButtonType.DisableDarkBackground,
                            title: "Cập nhật ngay",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
