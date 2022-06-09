
import 'package:base/src/Model/InputOptionObject.dart';
import 'package:base/src/Model/SelectorModel.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';
import 'package:flutter/material.dart';

import 'Source/OptionsInputWidget.dart';

class DropDownSearchWidget<T> extends StatefulWidget {
  final String? title;
  final Function(SelectorModel? value)? onSelector;
  final Function(bool status)? onFocus;
  final List<SelectorModel> items;
  final bool isPersonal;
  final bool isRequired;
  final bool enable;
  final double maxHeight;
  final String hint;
  final Stream<InputOptionObject>? inputOptionObject;
  final TextEditingController textEditingController;

  const DropDownSearchWidget({
    Key? key,
    this.onSelector,
    this.onFocus,
    required this.items,
    this.hint = '',
    this.title,
    this.isPersonal = true,
    this.isRequired = false,
    this.enable = true,
    this.maxHeight = 200,
    this.inputOptionObject,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropDownSearchWidget<T>();
}

class _DropDownSearchWidget<T> extends State<DropDownSearchWidget> {
  //late TextEditingController _textEditingController;
  final FocusNode _focusNode = FocusNode();

  List<SelectorModel> get _items => widget.items;
  SelectorModel? _selectedItem;

  @override
  void initState() {
    //_textEditingController = widget.textEditingController ?? TextEditingController();
    _focusNode.addListener(() {
      widget.onFocus?.call(_focusNode.hasFocus);
      if (!_focusNode.hasFocus) {
        widget.onSelector?.call(_selectedItem);
      }
    });
    widget.textEditingController.addListener(_textListener);
    _updateValue();
    super.initState();
  }

  @override
  void didUpdateWidget(DropDownSearchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _updateValue();
    }
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_textListener);
    //_focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateValue();
    return Visibility(
      child: OptionsInputWidget<SelectorModel>(
        title: widget.title,
        onChanged: _setSelectedItem,
        textEditingController: widget.textEditingController,
        focusNode: _focusNode,
        items: widget.items,
        hint: widget.hint,
        enable: widget.enable,
        maxHeight: widget.maxHeight,
        inputOptionObject: widget.inputOptionObject,
        findSuggestions: (String query) {
          if (query.isNotEmpty) {
            return _items.where((profile) {
              return Util.nonUnicode(profile.title).toLowerCase().contains(Util.nonUnicode(query).toLowerCase());
            }).toList(growable: false);
          }
          return _items;
        },
        suggestionBuilder: (_, __, profile) => Text(
          _getDescription(profile),
          style: const TextStyle(fontSize: 13),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      visible: widget.isPersonal,
    );
  }

  void _setSelectedItem(SelectorModel value) {
    _selectedItem = value;
    setState(() {
      widget.textEditingController.text = _getDescription(value);
      widget.textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: widget.textEditingController.text.length));
    });
    widget.onSelector?.call(_selectedItem);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String _getDescription(SelectorModel value) {
    if (value == null) return '';
    if (value is SelectorModel) {
      return value.title;
    }
    return '';
  }

  void _textListener() {
    if (_selectedItem != null && widget.textEditingController.text != _selectedItem!.title && !widget.isRequired) {
      _selectedItem = null;
    }
  }

  void _updateValue() {
    final items = _items;
    // final selected =
    //     items.firstWhere((element) => element.isCheck, orElse: () => items.isNotEmpty && widget.isRequired ? items[0] : SelectorModel());
    // widget.textEditingController.text = selected.title;
    for (var obj in _items) {
      if (obj.isCheck) {
        _selectedItem = obj;
      }
    }

    if (_selectedItem?.title.isEmpty ?? true) {
      for (var obj in _items) {
        if (obj.title == widget.textEditingController.text) {
          _selectedItem = obj;
        }
      }
    }

    //_selectedItem = selected;
    return;
  }
}
