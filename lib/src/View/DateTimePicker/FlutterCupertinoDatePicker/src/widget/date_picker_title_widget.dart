import 'package:flutter/material.dart';

import '../date_picker_theme.dart';
import '../i18n/date_picker_i18n.dart';

/// DatePicker's title widget.
///
/// @author dylan wu
/// @since 2019-05-16
class DatePickerTitleWidget extends StatelessWidget {
  const DatePickerTitleWidget({
    Key? key,
    required this.pickerTheme,
    required this.locale,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  final DateTimePickerTheme pickerTheme;
  final DateTimePickerLocale locale;
  final Function()? onCancel, onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: pickerTheme.titleHeight,
      decoration: BoxDecoration(
        color: pickerTheme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: _renderTitleWidget(context),
          ),
        ],
      ),
    );
  }

  /// render cancel button widget
  Widget _renderCancelWidget(BuildContext context) {
    var cancelWidget = pickerTheme.cancel;
    if (cancelWidget == null) {
      TextStyle textStyle = pickerTheme.cancelTextStyle ?? TextStyle(color: Theme.of(context).unselectedWidgetColor, fontSize: 16.0);
      cancelWidget = Text(DatePickerI18n.getLocaleCancel(locale) ?? "", textScaleFactor: 1, style: textStyle);
    }
    return cancelWidget;
  }

  /// render confirm button widget
  Widget _renderConfirmWidget(BuildContext context) {
    var confirmWidget = pickerTheme.confirm;
    if (confirmWidget == null) {
      TextStyle textStyle = pickerTheme.confirmTextStyle ?? TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0);
      confirmWidget = Text(DatePickerI18n.getLocaleDone(locale) ?? "", textScaleFactor: 1, style: textStyle);
    }
    return confirmWidget;
  }

  Widget _renderTitleWidget(BuildContext context) {
    var confirmWidget = pickerTheme.title;
    if (confirmWidget == null) {
      TextStyle textStyle = pickerTheme.confirmTextStyle ?? TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0);
      confirmWidget = Text(DatePickerI18n.getLocaleDone(locale) ?? "", textScaleFactor: 1, style: textStyle);
    }
    return confirmWidget;
  }
}
