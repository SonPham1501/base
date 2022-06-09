import 'package:base/base.dart';
import 'package:flutter/material.dart';


class InputSelectorWidget extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? content;
  final Function()? onTap;
  final bool enable;
  final Stream<InputOptionObject>? inputOptionObject;
  final String colorInputText;
  final FontWeight fontWeight;

  const InputSelectorWidget({
    Key? key,
    this.icon,
    this.title,
    this.content,
    this.onTap,
    this.inputOptionObject,
    this.enable = true,
    this.colorInputText = '4F4F4F',
    this.fontWeight = FontWeight.w400,
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
                child: Container(
                  decoration: BoxDecoration(
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
                          style: TextStyle(
                            fontSize: 13,
                            color: ColorExtends(colorInputText),
                            fontWeight: fontWeight,
                          ),
                        ),
                      ),
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
      child: Container(
        decoration: BoxDecoration(
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
                  Text(
                    content ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
