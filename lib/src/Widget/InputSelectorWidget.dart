import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Model/InputOptionObject.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:flutter/material.dart';

class InputSelectorWidget extends StatelessWidget {
  final String? title;
  final String? content;
  final Function()? onTap;
  final bool enable;
  final Stream<InputOptionObject>? inputOptionObject;

  const InputSelectorWidget({
    Key? key,
    this.title,
    this.content,
    this.onTap,
    this.inputOptionObject,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (content == null || content!.isEmpty) {
      return StreamBuilder<InputOptionObject?>(
        stream: inputOptionObject,
        builder: (context, snapshot) {
          var isShowError;
          var message;
          if (snapshot.data != null) {
            isShowError = snapshot.data?.isError;
            message = snapshot.data?.message;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Constant.kColorBorderD9DBE9, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 48,
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title ?? "",
                    style: TextStyle(
                      fontFamily: FontUtil.regular,
                      fontSize: 13,
                      color: Constant.kColorBlackPrimary.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              if (isShowError != null && message != null && isShowError)
                Container(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Constant.kRedColor,
                      fontSize: 12,
                      fontFamily: FontUtil.regular,
                    ),
                  ),
                ),
            ],
          );
        }
      );
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: enable ? Colors.transparent : Constant.kColorInputDisable,
          border: Border.all(color: Constant.kColorBorderD9DBE9, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 48,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? "",
              style: TextStyle(
                fontFamily: FontUtil.regular,
                fontSize: 11,
                color: Constant.kColorBlackPrimary.withOpacity(0.7),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              content ?? "",
              style: TextStyle(
                fontFamily: FontUtil.regular,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
