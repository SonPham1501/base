// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../Common/Constant.dart';

enum ButtonType { Normal, NormalBorder, Cancel, CancelDisable, Disable, DisableNoBackground, Back, Success , DisableDarkBackground}

class ButtonWidget extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final Function? onDisableTap;
  final double height, borderRadius;
  final ButtonType buttonType;
  final TextStyle? textStyle;
  final EdgeInsets? paddingContent;
  final Color? backgroundColor;
  final Color? borderColor;

  const ButtonWidget({Key? key, 
    this.title,
    this.onTap,
    this.onDisableTap,
    this.height = 44,
    this.buttonType = ButtonType.Normal,
    this.borderRadius = 8,
    this.textStyle,
    this.paddingContent,
    this.borderColor,
    this.backgroundColor,
  }) : super(key: key);

  Color getBackground() {
    switch (buttonType) {
      case ButtonType.Cancel:
        return Constant.kColorWhite;
      case ButtonType.CancelDisable:
        return Constant.kColorWhite;
      case ButtonType.NormalBorder:
        return Constant.kColorWhite;
      case ButtonType.Disable:
        return const Color(0xffF9EEE3);
      case ButtonType.DisableDarkBackground:
        return Colors.grey.withOpacity(0.5);
      case ButtonType.DisableNoBackground:
        return Constant.kColorWhite;
      case ButtonType.Back:
        return Constant.kColorBackgroundBack;
      case ButtonType.Success:
        return Constant.kColorButtonSuccess;
      default:
        return Constant.kColorOrangePrimary;
    }
  }

  Color getColorBorder() {
    switch (buttonType) {
      case ButtonType.Cancel:
        return Constant.kColorBlackPrimary;
      case ButtonType.CancelDisable:
        return Constant.kColorBlackPrimary.withOpacity(0.5);
      case ButtonType.NormalBorder:
        return Constant.kColorOrangePrimary;
      case ButtonType.Disable:
        return Constant.kColorTransparent;
      case ButtonType.DisableNoBackground:
        return Constant.kColorBlackPrimary.withOpacity(0.5);
      case ButtonType.Success:
        return Constant.kColorWhite;
      default:
        return Constant.kColorTransparent;
    }
  }

  TextStyle getStyle() {
    switch (buttonType) {
      case ButtonType.Cancel:
        return const TextStyle(color: Constant.kColorBlackPrimary, fontSize: 16);
      case ButtonType.CancelDisable:
        return TextStyle(color: Constant.kColorBlackPrimary.withOpacity(0.5), fontSize: 16);
      case ButtonType.NormalBorder:
        return const TextStyle(color: Constant.kColorOrangePrimary, fontSize: 16);
      case ButtonType.Disable:
        return const TextStyle(color: Color(0xffF8D0A8), fontSize: 16);
      case ButtonType.DisableNoBackground:
        return TextStyle(color: Constant.kColorBlackPrimary.withOpacity(0.5), fontSize: 16);
      case ButtonType.Back:
        return const TextStyle(color: Constant.kColorBlackPrimary, fontSize: 16);
      default:
        return const TextStyle(color: Constant.kColorWhite, fontSize: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          onPrimary: Colors.white,
          primary: backgroundColor ?? getBackground(),
          padding: paddingContent ?? const EdgeInsets.symmetric(horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            side: BorderSide(
              width: 1,
              color: borderColor ?? getColorBorder(),
            ),
          ),
        ),
        onPressed: () {
          if (buttonType != ButtonType.Disable && buttonType != ButtonType.DisableNoBackground) {
            onTap?.call();
          } else {
            onDisableTap?.call();
          }
        },
        child: Text(
          title ?? "",
          style: textStyle ?? getStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
