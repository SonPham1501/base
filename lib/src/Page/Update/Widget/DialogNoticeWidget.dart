import 'package:CenBase/Model/UpdateModel.dart';
import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:CenBase/Widget/LineBaseWidget.dart';
import 'package:flutter/material.dart';

class DialogNoticeWidget extends StatelessWidget {
  Function()? onTapUpdate;
  Function()? onTapSeeMore;
  UpdateItemModel? updateItemModel;

  DialogNoticeWidget({this.onTapUpdate, this.onTapSeeMore, this.updateItemModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Thông báo",
              style: TextStyle(fontFamily: FontUtil.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Đã có phiên bản mới: ${updateItemModel!.version}",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: FontUtil.regular, fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () {
                onTapSeeMore?.call();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Đọc thêm",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: FontUtil.regular, fontSize: 15, color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LineBaseWidget(),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  onTapUpdate?.call();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Cập nhật ngay",
                        style: TextStyle(fontFamily: FontUtil.regular, fontSize: 20, color: Constant.kColorOrangePrimary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            LineBaseWidget(),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: Navigator.of(context).pop,
                child: Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Nhắc tôi sau",
                        style: TextStyle(fontFamily: FontUtil.regular, fontSize: 20, color: Constant.kColorOrangePrimary),
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
