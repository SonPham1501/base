import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FlutterCupertinoDatePicker/src/date_picker.dart';
import 'FlutterCupertinoDatePicker/src/date_picker_constants.dart';
import 'FlutterCupertinoDatePicker/src/date_picker_theme.dart';
import 'FlutterCupertinoDatePicker/src/i18n/date_picker_i18n.dart';

class DateTimePicker {
  final Function(DateTime dateTime)? onChooseDateTime;

  bool _showTitle = true;

  var _locale = DateTimePickerLocale.vi;
  List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;

  String _format = 'dd-MMMM-yyyy';
  TextEditingController _formatCtrl = TextEditingController();

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
      minDateTime: minDate == null ? DateTime.parse(DATE_PICKER_MIN_DATETIME) : minDate,
      maxDateTime: maxDate == null ? DateTime.parse(DATE_PICKER_MAX_DATETIME) : maxDate,
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
      minDateTime: minDate == null ? DateTime.parse(DATE_PICKER_MIN_DATETIME) : minDate,
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
