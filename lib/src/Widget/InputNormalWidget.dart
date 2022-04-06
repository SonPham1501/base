import 'package:CenBase/Model/InputOptionObject.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:FlutterBase/Utils/DeBouncerDuration.dart';
import 'package:FlutterBase/Utils/TextFormatUtil.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../Common/Constant.dart';

class InputNormalWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String title;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChangedDeBouncer;
  final Stream<InputOptionObject>? inputOptionObject;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final double scrollPaddingBottom;
  final FocusNode? focusNode;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool isCusor;
  final BorderRadius? borderRadiusBackground;
  final TextAlign textAlign;
  final Alignment? alignment;
  final Color? backgroundColor;
  final double minHeight;
  final bool enable;
  final Function? onTap;
  final TextInputAction textInputAction;
  final Border? border;
  final List<TextInputFormatter>? formatter;
  final Color? textColor;
  final bool obscureText;
  final String? fontFamily;
  final bool autoFocus;
  final int timeDeBouncer;

  InputNormalWidget({
    this.controller,
    this.hintText = "",
    this.title = "",
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    this.border,
    this.obscureText = false,
    this.inputOptionObject,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.scrollPaddingBottom = 80,
    this.focusNode,
    this.fontFamily,
    this.icon,
    this.suffixIcon,
    this.isCusor = true,
    this.enable = true,
    this.borderRadiusBackground,
    this.textAlign = TextAlign.left,
    this.alignment,
    this.onChangedDeBouncer,
    this.backgroundColor,
    this.minHeight = 40,
    this.onTap,
    this.textInputAction = TextInputAction.done,
    this.formatter,
    this.textColor,
    this.autoFocus = false,
    this.timeDeBouncer = 500,
  });

  @override
  _InputNormalWidgetState createState() => _InputNormalWidgetState();
}

class _InputNormalWidgetState extends State<InputNormalWidget> {
  CancelableOperation? cancelableOperation;
  late DeBouncerDuration onSearchDeBouncer;
  bool focusScope = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onSearchDeBouncer= DeBouncerDuration(delay: new Duration(milliseconds: widget.timeDeBouncer));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    debugPrint("InputInfoWidget dispose");
    super.dispose();
  }

  void _onChanged(String value) {
    widget.onChanged?.call(value);
    if (widget.onChangedDeBouncer != null) {
      this.onSearchDeBouncer.debounce(() {
        widget.onChangedDeBouncer!(value);
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextEdit();
  }

  Widget _buildTextEdit() {

    return StreamBuilder<InputOptionObject?>(
      stream: widget.inputOptionObject,
      builder: (context, snapshot) {

        return _buildBody(snapshot.data);
      },
    );
  }

  Widget _buildBody(InputOptionObject? option) {

    var isShowError;
    var message;
    if (option != null) {
      isShowError = option.isError;
      message = option.message;
    }
    final finalFormatter = widget.formatter ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.transparent,
            border: widget.border ??
                Border.all(color: Constant.kColorBorderD9DBE9, width: 1),
            borderRadius: widget.borderRadiusBackground == null
                ? BorderRadius.circular(8)
                : widget.borderRadiusBackground,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: widget.icon,
                  ),
                ),
              Expanded(
                child: ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: widget.minHeight,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      widget.onTap?.call();
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          widget.icon != null ? 0 : 16, 0, 0, 0),
                      alignment: widget.minHeight == 40
                          ? Alignment.centerLeft
                          : Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FocusScope(
                              onFocusChange: (value) {
                                setState(() {
                                  focusScope = value;
                                });
                              },
                              child: TextField(
                                autofocus: widget.autoFocus,
                                focusNode: widget.focusNode,
                                maxLines: widget.maxLines,
                                minLines: widget.minLines,
                                showCursor: widget.isCusor,
                                maxLength: widget.maxLength,
                                obscureText: widget.obscureText,
                                controller: widget.controller,
                                enabled: widget.enable,
                                onChanged: _onChanged,
                                onSubmitted: widget.onSubmitted,
                                textInputAction: widget.textInputAction,
                                inputFormatters: finalFormatter
                                  ..add(LengthLimitingTextFieldFormatterFixed(
                                      widget.maxLength)),
                                style: TextStyle(
                                  color: widget.textColor ??
                                      Constant.kColorBlackPrimary,
                                  fontSize: 14,
                                  fontFamily:
                                  widget.fontFamily ?? FontUtil.regular,
                                ),
                                keyboardType: widget.keyboardType,
                                scrollPadding: EdgeInsets.only(
                                    bottom: widget.scrollPaddingBottom,
                                    top: 40),
                                textAlign: widget.textAlign,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  counterText: "",
                                  hintText: widget.hintText,
                                  contentPadding:
                                  EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  isDense: true,
                                  hintStyle: TextStyle(
                                    color: Constant.kColorBlackPrimary
                                        .withOpacity(0.7),
                                    fontSize: 14,
                                    fontFamily: FontUtil.regular,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (!focusScope) ...[
                SizedBox(
                  width: 16,
                )
              ] else if (widget.controller?.text.length == 0) ...[
                SizedBox(
                  width: 16,
                )
              ] else ...[
                InkWell(
                  onTap: () {
                    widget.controller?.text = "";
                    widget.onChanged?.call("");
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.highlight_remove_outlined,
                      color: Constant.kColorBlackPrimary,
                      size: 16,
                    ),
                  ),
                )
              ],
              if (widget.suffixIcon != null)
                Container(
                  height: 40,
                  padding: const EdgeInsets.only(right: 12),
                  child: widget.suffixIcon,
                ),
            ],
          ),
        ),
        //lỗi
        if (isShowError != null && message != null && isShowError)
          Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            alignment: widget.alignment,
            child: Text(
              message,
              style: TextStyle(
                color: Constant.kRedColor,
                fontSize: 12,
                fontFamily: FontUtil.regular,
              ),
            ),
          ),
      ],
    );
  }
}

