import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Model/InputOptionObject.dart';
import 'package:base/src/Model/SelectorModel.dart';
import 'package:flutter/material.dart';

import 'OptionsInput.dart';

class OptionsInputWidget<T> extends StatelessWidget {
  final String? title;
  final OptionsInputSuggestions<SelectorModel> findSuggestions;
  final ValueChanged<SelectorModel>? onChanged;
  final OptionsBuilder<SelectorModel> suggestionBuilder;
  final List<SelectorModel> items;
  final TextEditingController? textEditingController;
  final FocusNode focusNode;
  final bool enable;
  final InputDecoration? inputDecoration;
  final double maxHeight;
  final String hint;
  final Stream<InputOptionObject>? inputOptionObject;

  const OptionsInputWidget({
    Key? key,
    required this.findSuggestions,
    this.onChanged,
    required this.suggestionBuilder,
    this.title,
    this.hint = '',
    required this.items,
    this.textEditingController,
    required this.focusNode,
    this.inputDecoration,
    this.enable = true,
    this.maxHeight = 300,
    this.inputOptionObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionsInput<SelectorModel>(
        initOptions: items,
        focusNode: focusNode,
        enabled: enable,
        textEditingController: textEditingController,
        textStyle: TextStyle(
          fontSize: 13,
          color: (enable) ? Constant.kColorBlackPrimary : Constant.kColorBlackPrimary.withOpacity(0.2),
        ),
        hintText: hint,
        inputOptionObject: inputOptionObject,
        inputDecoration: inputDecoration ??
            InputDecoration(
                hintText: hint,
                //change by font size and height of text field
                contentPadding: const EdgeInsets.fromLTRB(8, 12, 0, 12),
                isDense: true,
                border: InputBorder.none,
                suffixIconConstraints: const BoxConstraints(minHeight: 20),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12, left: 8),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 24,
                    color: (enable) ? Constant.kColorBlackPrimary : Constant.kColorBlackPrimary.withOpacity(0.2),
                  ),
                )),
        onChanged: (value) {
          onChanged?.call(value);
        },
        suggestionsBoxMaxHeight: maxHeight,
        borderRadius: 8,
        findSuggestions: findSuggestions,
        suggestionBuilder: (context, state, profile) {
          return InkWell(
            key: ObjectKey(profile),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                  alignment: Alignment.centerLeft,
                  child: suggestionBuilder(context, state, profile),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Divider(
                    height: 1,
                    color: Constant.kLineColor,
                  ),
                )
              ],
            ),
            onTap: () => state.selectSuggestion(profile),
          );
        });
  }
}
