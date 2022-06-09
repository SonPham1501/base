import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Common/Constant.dart';
import '../Utils/BaseResourceUtil.dart';

class CheckboxWidget extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final bool value;
  final EdgeInsets paddingContent;
  final double fontSize;
  final bool isRadio,isExpanded;
  final double sizeIcon;

  const CheckboxWidget({Key? key, 
    @required this.title,
    this.value = false,
    this.onTap,
    this.paddingContent = EdgeInsets.zero,
    this.fontSize = 15,
    this.isRadio = false,
    this.isExpanded = false,
    this.sizeIcon = 18,
  }) : super(key: key);

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
              const SizedBox(
                width: 10,
              ),
              isExpanded?Expanded(child: Text(
                title ?? '',
                style: TextStyle(fontSize: fontSize, color: Constant.kColorBlackPrimary),
              )):Text(
                title ?? '',
                style: TextStyle(fontSize: fontSize, color: Constant.kColorBlackPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
