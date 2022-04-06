import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Utils/FontUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FlutterCupertinoDatePicker/src/date_picker.dart';
import 'FlutterCupertinoDatePicker/src/date_picker_constants.dart';
import 'FlutterCupertinoDatePicker/src/date_picker_theme.dart';
import 'FlutterCupertinoDatePicker/src/i18n/date_picker_i18n.dart';

class DateTimePicker {
  final Function(DateTime dateTime)? onChooseDateTime;

  final bool _showTitle = true;

  final _locale = DateTimePickerLocale.vi;
  final List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;

  final String _format = 'dd-MMMM-yyyy';
  final TextEditingController _formatCtrl = TextEditingController();

  late DateTime dateTime;
  late BuildContext context;
  DateTime? minDate;
  DateTime? maxDate;
  String? title;

  DateTimePicker({
    required BuildContext contextValue,
    required this.onChooseDateTime,
    required this.dateTime,
    required String titleValue,
    this.minDate,
  }) {
    context = contextValue;
    title = titleValue;
  }

  void show() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        itemTextStyle: TextStyle(
          fontSize: 18,
          color: Constant.kColorBlackPrimary,
          fontFamily: FontUtil.semiBold,
        ),
        title: Text(
          title ?? "",
          textScaleFactor: 1,
          style: TextStyle(
            fontSize: 16,
            color: Constant.kColorBlackPrimary,
            fontFamily: FontUtil.bold,
          ),
        ),
      ),
      minDateTime: minDate ?? DateTime.parse(DATE_PICKER_MIN_DATETIME),
      maxDateTime: maxDate ?? DateTime.parse(DATE_PICKER_MAX_DATETIME),
      initialDateTime: dateTime,
      dateFormat: _format,
      locale: _locale,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        //_dateTime = dateTime;
        //onChooseDateTime(_dateTime);
      },
      onConfirm: (dateTime, List<int> index) {
        this.dateTime = dateTime;
        onChooseDateTime?.call(dateTime);
      },
    );
  }

  void showTimePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        itemTextStyle: TextStyle(
          fontSize: 18,
          color: Constant.kColorBlackPrimary,
          fontFamily: FontUtil.semiBold,
        ),
        title: Text(
          title ?? "",
          textScaleFactor: 1,
          style: TextStyle(
            fontSize: 16,
            color: Constant.kColorBlackPrimary,
            fontFamily: FontUtil.bold,
          ),
        ),
      ),
      minDateTime: minDate ?? DateTime.parse(DATE_PICKER_MIN_DATETIME),
      initialDateTime: dateTime,
      dateFormat: 'HH:mm',
      pickerMode: DateTimePickerMode.time,
      locale: _locale,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        //_dateTime = dateTime;
        //onChooseDateTime(_dateTime);
      },
      onConfirm: (dateTime, List<int> index) {
        this.dateTime = dateTime;
        onChooseDateTime?.call(dateTime);
      },
    );
  }

  void showDateTimePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        itemTextStyle: TextStyle(
          fontSize: 18,
          color: Constant.kColorBlackPrimary,
          fontFamily: FontUtil.semiBold,
        ),
        title: Text(
          title ?? "",
          textScaleFactor: 1,
          style: TextStyle(
            fontSize: 16,
            color: Constant.kColorBlackPrimary,
            fontFamily: FontUtil.bold,
          ),
        ),
      ),
      initialDateTime: dateTime,
      dateFormat: 'HH:mm',
      pickerMode: DateTimePickerMode.datetime,
      locale: _locale,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        //_dateTime = dateTime;
        //onChooseDateTime(_dateTime);
      },
      onConfirm: (dateTime, List<int> index) {
        this.dateTime = dateTime;
        onChooseDateTime?.call(dateTime);
      },
    );
  }
}
