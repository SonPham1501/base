import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Utils/BaseResourceUtil.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CheckboxWidget extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final bool value;
  final EdgeInsets paddingContent;
  final double fontSize;
  final bool isRadio,isExpanded;
  final double sizeIcon;

  CheckboxWidget({
    @required this.title,
    this.value = false,
    this.onTap,
    this.paddingContent = EdgeInsets.zero,
    this.fontSize = 15,
    this.isRadio = false,
    this.isExpanded = false,
    this.sizeIcon = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: paddingContent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isRadio
                  ? Icon(
                      value ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded,
                      color: Constant.kColorOrangePrimary,
                      size: sizeIcon,
                    )
                  : SvgPicture.asset(
                      value ? BaseResourceUtil.icon("ic_check_mark") : BaseResourceUtil.icon("ic_uncheck_mark"),
                    ),
              SizedBox(
                width: 10,
              ),
              isExpanded?Expanded(child: Text(
                title ?? '',
                style: TextStyle(fontFamily: FontUtil.regular, fontSize: fontSize, color: Constant.kColorBlackPrimary),
              )):Text(
                title ?? '',
                style: TextStyle(fontFamily: FontUtil.regular, fontSize: fontSize, color: Constant.kColorBlackPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
