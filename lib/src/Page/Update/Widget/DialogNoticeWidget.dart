import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Model/UpdateModel.dart';
import 'package:base/src/Widget/LineBaseWidget.dart';
import 'package:flutter/material.dart';

class DialogNoticeWidget extends StatelessWidget {
  final Function()? onTapUpdate;
  final Function()? onTapSeeMore;
  final UpdateItemModel? updateItemModel;

  const DialogNoticeWidget({Key? key, this.onTapUpdate, this.onTapSeeMore, this.updateItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Thông báo",
              style: TextStyle( fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Đã có phiên bản mới: ${updateItemModel!.version}",
                textAlign: TextAlign.center,
                style: const TextStyle( fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () {
                onTapSeeMore?.call();
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Đọc thêm",
                  textAlign: TextAlign.center,
                  style: TextStyle( fontSize: 15, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const LineBaseWidget(),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  onTapUpdate?.call();
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Cập nhật ngay",
                        style: TextStyle(fontSize: 20, color: Constant.kColorOrangePrimary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const LineBaseWidget(),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: Navigator.of(context).pop,
                child: const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Nhắc tôi sau",
                        style: TextStyle(fontSize: 20, color: Constant.kColorOrangePrimary),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
