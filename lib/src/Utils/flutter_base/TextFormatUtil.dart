import 'package:base/src/Extends/StringExtend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Util.dart';

//Format nhận số thập phân đổi tất cả dấu phẩy thành dấu chấm
class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    TextSelection newSelection = newValue.selection;

    if (newValue.text.contains(",")) {
      truncated = newValue.text.replaceFirst(RegExp(','), '.');
    }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}

//Chỉ nhận số nguyên dương
//WhitelistingTextInputFormatter.digitsOnly
TextInputFormatter NumberTextInputFormatter() {
  return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
}

//Chỉ nhận số có 1 dấu .
TextInputFormatter NumberTextInputFormatterDoubleOnly() {
//  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"));
  return TextInputFormatter.withFunction((oldValue, newValue) {
    try {
      final text = newValue.text.replaceAll(",", ".");
      TextSelection newSelection = newValue.selection;
      if (text.isNotEmpty) double.parse(text);
      return TextEditingValue(text: text, selection: newSelection);
    } catch (e) {}
    return oldValue;
  });
}
// class NumberTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     String truncated = newValue.text;
//     TextSelection newSelection = newValue.selection;
//
//     if (newValue.text.contains(",")) {
//       truncated = newValue.text.replaceFirst(RegExp(','), '');
//     }
//     if (newValue.text.contains(".")) {
//       truncated = newValue.text.replaceFirst(RegExp('.'), '');
//     }
//     return TextEditingValue(
//       text: truncated,
//       selection: newSelection,
//     );
//     WhitelistingTextInputFormatter.digitsOnly
//   }
// }

//Giới hạn ký tự MaxLenght
class LengthLimitingTextFieldFormatterFixed
    extends LengthLimitingTextInputFormatter {
  LengthLimitingTextFieldFormatterFixed(int? maxLength) : super(maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength != null &&
        maxLength! > 0 &&
        newValue.text.characters.length > maxLength!) {
      // If already at the maximum and tried to enter even more, keep the old
      // value.
      if (oldValue.text.characters.length == maxLength) {
        return oldValue;
      }
      // ignore: invalid_use_of_visible_for_testing_member
      return LengthLimitingTextInputFormatter.truncate(newValue, maxLength!);
    }
    return newValue;
  }
}

//định dạng tiền
class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // remove characters to convert the value to double (because one of those may appear in the keyboard)
    String newText = newValue.text
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('_', '')
        .replaceAll('-', '');
    String value = newText;
    int cursorPosition = newText.length;
    if (newText.isNotEmpty) {
      value = Util.intToPriceDouble(newText.toInt());
      cursorPosition = value.length;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: cursorPosition));
  }
}

//Định dạng số dương
class PositiveNumbersTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // remove characters to convert the value to double (because one of those may appear in the keyboard)
    String newText = newValue.text
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('_', '')
        .replaceAll('-', '');
    String value = newText;
    int cursorPosition = newText.length;

    if (newText.isNotEmpty) {
      if (newValue.text.contains(",")) {
        newText = newValue.text.replaceFirst(RegExp(','), '.');
      }
      value = newText.toDouble() == null
          ? ""
          : Util.doubleToString(newText.toDouble()!);
      cursorPosition = value.length;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: cursorPosition));
  }
}
