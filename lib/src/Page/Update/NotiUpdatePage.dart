// ignore_for_file: use_key_in_widget_constructors

import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Model/UpdateModel.dart';
import 'package:base/src/Utils/BaseResourceUtil.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';
import 'package:base/src/View/ChooseImage/ChooseImage.dart';
import 'package:base/src/Widget/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotiUpdatePage extends StatefulWidget {
  final UpdateItemModel updateItemModel;
  final String packageName;
  final bool isForceUpdate;
  final String urlAppStore;

  const NotiUpdatePage({
    required this.updateItemModel,
    required this.packageName,
    required this.urlAppStore,
    this.isForceUpdate = false,
  });

  @override
  State<NotiUpdatePage> createState() => _NotiUpdatePageState();
}

class _NotiUpdatePageState extends State<NotiUpdatePage> {
  bool isAgree = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isForceUpdate) {
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
                    child: !widget.isForceUpdate
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
                  widget.isForceUpdate ? "Ứng dụng cần phải cập nhật" : "Thông báo cập nhật",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              if (widget.isForceUpdate)
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Text(
                    "Để tiếp tục sử dụng ứng dụng, vui lòng hãy tải xuống phiên bản mới nhất",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              if (widget.updateItemModel.description != null && widget.updateItemModel.description!.isNotEmpty)
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
                            "Nội dung phiên bản cập nhật ${widget.updateItemModel.version}",
                            style: const TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.updateItemModel.description ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          )),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Phiên bản cập nhật: ${widget.updateItemModel.version}",
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: ButtonWidget(
                        onTap: () {
                          if (Platform.isAndroid) {
                            Util.openURL(
                                "https://play.google.com/store/apps/details?id=" +
                                    widget.packageName);
                          } else {
                            Util.openURL(widget.urlAppStore);
                          }
                        },
                        buttonType: isAgree
                          ? ButtonType.Normal
                          : ButtonType.DisableDarkBackground,
                        title: "Cập nhật ngay",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
