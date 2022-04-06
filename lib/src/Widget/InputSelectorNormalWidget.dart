import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Model/InputOptionObject.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:flutter/material.dart';

class InputSelectorNormalWidget extends StatelessWidget {
  final String? hintText;
  final String? content;
  final Function()? onTap;
  final Function()? onClearData;
  final bool enable;
  final bool showDropDown;
  final double height;
  final bool isHaveSmallClose;
  final Stream<InputOptionObject>? inputOptionObject;

  const InputSelectorNormalWidget({
    Key? key,
    this.hintText,
    this.content,
    this.showDropDown = true,
    this.onTap,
    this.onClearData,
    this.enable = true,
    this.isHaveSmallClose = false,
    this.inputOptionObject,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((content == null || content!.isEmpty)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color:
                    enable ? Colors.transparent : Constant.kColorInputDisable,
                border:
                    Border.all(color: Constant.kColorBorderD9DBE9, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              height: height,
              padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hintText ?? "",
                      style: TextStyle(
                        fontFamily: FontUtil.regular,
                        fontSize: 13,
                        color: Constant.kColorBlackPrimary.withOpacity(0.7),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  if (enable && showDropDown)
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Constant.kGreyColor,
                      size: 18,
                    ),
                ],
              ),
            ),
          ),
          StreamBuilder<InputOptionObject?>(
            stream: inputOptionObject,
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data!.isError) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(
                    snapshot.data?.message ?? "",
                    style: TextStyle(
                      color: Constant.kRedColor,
                      fontSize: 12,
                      fontFamily: FontUtil.regular,
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          )
        ],
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
        height: height,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                content ?? "",
                style: TextStyle(
                  fontFamily: FontUtil.regular,
                  fontSize: 13,
                  color: Constant.kColorBlackPrimary,
                ),
              ),
            ),
            if (onClearData != null)
              if (isHaveSmallClose) ...[
                InkWell(
                  onTap: () {
                    onClearData?.call();
                  },
                  child: Icon(
                    Icons.close,
                    color: Constant.kGreyColor,
                    size: 16,
                  ),
                )
              ] else ...[
                IconButton(
                    onPressed: () {
                      onClearData?.call();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Constant.kGreyColor,
                      size: 18,
                    ))
              ],
            if (enable && showDropDown)
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Constant.kGreyColor,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
