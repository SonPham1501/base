import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonType { Normal, NormalBorder, Cancel, CancelDisable, Disable, DisableNoBackground, Back, Success , DisableDarkBackground}

class ButtonWidget extends StatelessWidget {
  String? title;
  Function? onTap;
  Function? onDisableTap;
  double height, borderRadius;
  ButtonType buttonType;
  TextStyle? textStyle;
  EdgeInsets? paddingContent;

  ButtonWidget({
    this.title,
    this.onTap,
    this.onDisableTap,
    this.height = 44,
    this.buttonType = ButtonType.Normal,
    this.borderRadius = 8,
    this.textStyle,
    this.paddingContent,
  });

  Color getBackground() {
    switch (buttonType) {
      case ButtonType.Cancel:
        return Constant.kColorWhite;
      case ButtonType.CancelDisable:
        return Constant.kColorWhite;
      case ButtonType.NormalBorder:
        return Constant.kColorWhite;
      case ButtonType.Disable:
        return Color(0xffF9EEE3);
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
        return TextStyle(fontFamily: FontUtil.medium, color: Constant.kColorBlackPrimary, fontSize: 16);
      case ButtonType.CancelDisable:
        return TextStyle(fontFamily: FontUtil.medium, color: Constant.kColorBlackPrimary.withOpacity(0.5), fontSize: 16);
      case ButtonType.NormalBorder:
        return TextStyle(fontFamily: FontUtil.medium, color: Constant.kColorOrangePrimary, fontSize: 16);
      case ButtonType.Disable:
        return TextStyle(fontFamily: FontUtil.medium, color: Color(0xffF8D0A8), fontSize: 16);
      case ButtonType.DisableNoBackground:
        return TextStyle(fontFamily: FontUtil.medium, color: Constant.kColorBlackPrimary.withOpacity(0.5), fontSize: 16);
      case ButtonType.Back:
        return TextStyle(fontFamily: FontUtil.medium, color: Constant.kColorBlackPrimary, fontSize: 16);
      default:
        return TextStyle(fontFamily: FontUtil.medium, color: Constant.kColorWhite, fontSize: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          onPrimary: Colors.white,
          primary: this.getBackground(),
          padding: paddingContent ?? EdgeInsets.symmetric(horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            side: BorderSide(
              width: 1,
              color: getColorBorder(),
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
          "${title ?? ""}",
          style: textStyle ?? getStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
