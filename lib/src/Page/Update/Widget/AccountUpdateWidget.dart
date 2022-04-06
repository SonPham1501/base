import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Helper/UpdateHelper.dart';
import 'package:base/src/Model/UpdateModel.dart';
import 'package:base/src/Page/Update/NotiUpdatePage.dart';
import 'package:base/src/Utils/FontUtil.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';
import 'package:base/src/Widget/LineBaseWidget.dart';
import 'package:flutter/material.dart';
class AccountUpdateWidget extends StatefulWidget {
  const AccountUpdateWidget({Key? key}) : super(key: key);

  @override
  _AccountUpdateWidgetState createState() => _AccountUpdateWidgetState();
}

class _AccountUpdateWidgetState extends State<AccountUpdateWidget> {
  // final Function? onTap;
  // final String? title;
  // final String? content;
  // final Widget icon;
  // final Color? titleColor;
  // final bool isCheckLogin;
  // final bool isShowLine;
  // final bool isHaveUpdate;

  // const AccountUpdateWidget(
  //     {Key? key,
  //     this.title,
  //     this.onTap,
  //     required this.icon,
  //     this.titleColor,
  //     this.content,
  //     this.isCheckLogin = false,
  //     this.isShowLine = true,
  //     this.isHaveUpdate = true})
  //     : super(key: key);
  UpdateItemModel? _updateItemModel;
  String? packageName;
  var isHaveUpdate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateItemModel = UpdateHelper.latestUpdateItem;
    packageName = UpdateHelper.packageName;
    isHaveUpdate = _updateItemModel != null;
  }

  @override
  Widget build(BuildContext context) {
    bool isEnable = true;
    return InkWell(
      onTap: () {
        if (_updateItemModel != null) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NotiUpdatePage(
              updateItemModel: _updateItemModel!,
              packageName: packageName!,
            ),
          ));
        } else {
          Util.showToast("Ứng dụng không có phiên bản mới");
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 1,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: Constant.kColorOrangePrimary, borderRadius: BorderRadius.circular(6)),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.system_update_rounded,
                      //color: Constant.kColorBlackPrimary.withOpacity(0.7),
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
                      child: Text(
                        "Kiểm tra cập nhật",
                        style: TextStyle(
                          color: Constant.kColorBlackPrimary,
                          fontFamily: FontUtil.regular,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
                    child: Text(
                      "",
                      style: TextStyle(
                        color: Constant.kColorOrangePrimary,
                        fontFamily: FontUtil.regular,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  isHaveUpdate
                      ? const Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 20,
                        )
                      : const Icon(
                          Icons.check_circle_outline_rounded,
                          color: Constant.kColorOrangePrimary,
                          size: 20,
                        ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            //if (isShowLine)
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: LineBaseWidget(
                color: Color(0xFFDDDEE6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
