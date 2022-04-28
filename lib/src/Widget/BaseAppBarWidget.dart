import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseAppBarWidget extends AppBar {
  final String? textTitle;
  Function()? onback;
  @override
  final List<Widget>? actions;
  @override
  final Color backgroundColor;
  final Color? titleColor;
  final bool isLeadingIcon;
  final Widget? iconLeading;
  @override
  final Widget? title;
  @override
  final bool centerTitle;
  @override
  final double? elevation;
  final BuildContext context;
  final double sizeIcon;

  BaseAppBarWidget(
      {Key? key,
      this.textTitle,
      required this.context,
      this.actions,
      this.isLeadingIcon = true,
      this.centerTitle = false,
      this.backgroundColor = Colors.white,
      this.elevation = 0,
      this.title,
      this.onback,
      this.sizeIcon = 12,
      this.iconLeading,
      this.titleColor})
      : super(
          key: key,
          brightness: Brightness.light,
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: isLeadingIcon
              ? IconButton(
                  icon: iconLeading ??
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: titleColor,
                        size: sizeIcon,
                      ),
                    ),
                  onPressed: () {
                    if (onback == null) {
                      Navigator.of(context).pop();
                    } else {
                      onback.call();
                    }
                  },
                )
              : null,
          title: title,
          actions: actions,
          centerTitle: centerTitle,
          elevation: elevation,
        );
}
