import 'package:base/base.dart';
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
  final String colorInputText;
  final FontWeight fontWeight;

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
    this.colorInputText = '4F4F4F',
    this.fontWeight = FontWeight.w400,
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
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hintText ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        color: ColorExtends(colorInputText),
                        fontWeight: fontWeight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (enable && showDropDown)
                    const Icon(
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
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(
                    snapshot.data?.message ?? "",
                    style: const TextStyle(
                      color: Constant.kRedColor,
                      fontSize: 12,
                    ),
                  ),
                );
              }
              return const SizedBox();
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
        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                content ?? "",
                style: TextStyle(
                  fontSize: 13,
                  color: ColorExtends(colorInputText),
                ),
              ),
            ),
            if (onClearData != null)
              if (isHaveSmallClose) ...[
                InkWell(
                  onTap: () {
                    onClearData?.call();
                  },
                  child: const Icon(
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
                    icon: const Icon(
                      Icons.close,
                      color: Constant.kGreyColor,
                      size: 18,
                    ))
              ],
            if (enable && showDropDown)
              const Icon(
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
