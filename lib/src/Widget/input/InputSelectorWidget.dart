import 'package:base/base.dart';
import 'package:flutter/material.dart';


class InputSelectorWidget extends StatelessWidget {
  final Widget? icon;
  final Widget? suffixIcon;
  final String? title;
  final BoxDecoration? decoratedBox;
  final String? content;
  final Function()? onTap;
  final bool enable;
  final Stream<InputOptionObject>? inputOptionObject;
  final String colorInputText;
  final FontWeight fontWeight;
  final bool isShowHintTitle;
  final int maxLines;
  final bool autofocus;
  final FocusNode? focusNode;

  const InputSelectorWidget({
    Key? key,
    this.maxLines = 1,
    this.icon,
    this.suffixIcon,
    this.title,
    this.decoratedBox,
    this.content,
    this.onTap,
    this.inputOptionObject,
    this.enable = true,
    this.colorInputText = '4F4F4F',
    this.fontWeight = FontWeight.w400,
    this.isShowHintTitle = true,
    this.autofocus = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (content == null || content!.isEmpty) {
      return StreamBuilder<InputOptionObject?>(
        stream: inputOptionObject,
        builder: (context, snapshot) {
          bool? isShowError;
          String? message;
          if (snapshot.data != null) {
            isShowError = snapshot.data?.isError;
            message = snapshot.data?.message;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: enable ? onTap : null,
                canRequestFocus: enable,
                focusNode: focusNode,
                autofocus: autofocus,
                child: Container(
                  decoration: decoratedBox ?? BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Constant.kColorBorderD9DBE9, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 48,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      if (icon != null) ...[
                        icon!,
                        const SizedBox(width: 10),
                      ],
                      Expanded(
                        child: Text(
                          title ?? "",
                          maxLines: maxLines,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: ColorExtends(colorInputText),
                            fontWeight: fontWeight,
                          ),
                        ),
                      ),
                      if (suffixIcon != null) ...[
                        const SizedBox(width: 10),
                        suffixIcon!,
                      ],
                    ],
                  ),
                ),
              ),
              if (isShowError != null && message != null && isShowError)
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Constant.kRedColor,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          );
        }
      );
    }
    return InkWell(
      onTap: enable ? onTap : null,
      canRequestFocus: enable,
      focusNode: focusNode,
      autofocus: autofocus,
      child: Container(
        decoration: decoratedBox ?? BoxDecoration(
          color: enable ? Colors.transparent : Constant.kColorInputDisable,
          border: Border.all(color: Constant.kColorBorderD9DBE9, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 48,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isShowHintTitle) ...[
                    Text(
                      title ?? "",
                      style: TextStyle(
                        fontSize: 11,
                        color: ColorExtends(colorInputText),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                  Text(
                    content ?? "",
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 10),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
