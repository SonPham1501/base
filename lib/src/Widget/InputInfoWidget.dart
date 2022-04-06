import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Model/InputOptionObject.dart';
import 'package:CenBase/Utils/BaseResourceUtil.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:FlutterBase/Utils/DeBouncerDuration.dart';
import 'package:FlutterBase/Utils/TextFormatUtil.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputInfoWidget extends StatefulWidget {
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
  final bool isShowHintTitle;
  final double fontSize;
  final bool isEnableMultiLine;
  final bool isHasExtend;

  InputInfoWidget({
    this.controller,
    this.hintText = "",
    this.title = "",
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    this.border,
    this.obscureText = false,
    this.isHasExtend = false,
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
    this.isEnableMultiLine = false,
    this.borderRadiusBackground,
    this.textAlign = TextAlign.left,
    this.alignment,
    this.onChangedDeBouncer,
    this.backgroundColor = Colors.white,
    this.minHeight = 44,
    this.onTap,
    this.textInputAction = TextInputAction.done,
    this.formatter,
    this.textColor,
    this.autoFocus = false,
    this.timeDeBouncer = 500,
    this.isShowHintTitle = true,
    this.fontSize = 14,
  });

  @override
  _InputInfoWidgetState createState() => _InputInfoWidgetState();
}

class _InputInfoWidgetState extends State<InputInfoWidget>
    with SingleTickerProviderStateMixin {
  CancelableOperation? cancelableOperation;
  late DeBouncerDuration onSearchDeBouncer;
  bool focusScope = false;
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  late bool _isShowPass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isShowPass = !widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _textEditingController = widget.controller ?? TextEditingController();
    onSearchDeBouncer = DeBouncerDuration(
        delay: new Duration(milliseconds: widget.timeDeBouncer));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    debugPrint("InputInfoWidget dispose");
    _focusNode.dispose();
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

  void _onShowPass() {
    setState(() {
      _isShowPass = !_isShowPass;
    });
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
                Border.all(
                  color: focusScope
                      ? Constant.kColorBorderInputSelector
                      : Constant.kColorBorderInput,
                  width: 1,
                ),
            borderRadius: widget.borderRadiusBackground == null
                ? BorderRadius.circular(8)
                : widget.borderRadiusBackground,
          ),
          child: Row(
            children: [
              Expanded(
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
                        child: InkWell(
                          onTap: () {
                            widget.onTap?.call();
                            FocusScope.of(context).requestFocus(_focusNode);
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                widget.icon != null ? 0 : 16, 8, 0, 8),
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: FocusScope(
                                    onFocusChange: (value) {
                                      setState(() {
                                        focusScope = value;
                                      });
                                    },
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          splashColor: Colors.transparent),
                                      child: TextFormField(
                                        autofocus: widget.autoFocus,
                                        focusNode: _focusNode,
                                        maxLines: widget.obscureText
                                            ? 1
                                            : widget.maxLines,
                                        minLines: widget.minLines,
                                        showCursor: widget.isCusor,
                                        maxLength: widget.maxLength,
                                        obscureText: !_isShowPass,
                                        controller: widget.controller ??
                                            _textEditingController,
                                        enabled: widget.enable,
                                        onChanged: _onChanged,
                                        onFieldSubmitted: widget.onSubmitted,
                                        textInputAction: widget.isEnableMultiLine ? null : widget.textInputAction,
                                        inputFormatters: finalFormatter
                                          ..add(
                                              LengthLimitingTextFieldFormatterFixed(
                                                  widget.maxLength)),
                                        keyboardType: widget.keyboardType,
                                        scrollPadding: EdgeInsets.only(
                                            bottom: widget.scrollPaddingBottom,
                                            top: 40),
                                        cursorColor: Colors.transparent,
                                        decoration: InputDecoration(
                                            hintText: !widget.isShowHintTitle
                                                ? widget.hintText
                                                : null,
                                            labelText: widget.isShowHintTitle
                                                ? widget.hintText
                                                : null,
                                            labelStyle: TextStyle(
                                              color: Constant.kColorBlackPrimary
                                                  .withOpacity(0.7),
                                              fontSize: widget.fontSize,
                                              fontFamily: FontUtil.regular,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            counterText: "",
                                            focusColor: Colors.transparent,
                                            fillColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            isDense: true),
                                        style: TextStyle(
                                          color: widget.textColor ??
                                              Constant.kColorBlackPrimary,
                                          fontSize: widget.fontSize,
                                          fontFamily: widget.fontFamily ??
                                              FontUtil.regular,
                                        ),
                                      ),
                                    ),
                                    // child: TextField(
                                    //   autofocus: widget.autoFocus,
                                    //   focusNode: _focusNode,
                                    //   maxLines: widget.maxLines,
                                    //   minLines: widget.minLines,
                                    //   showCursor: widget.isCusor,
                                    //   maxLength: widget.maxLength,
                                    //   obscureText: widget.obscureText,
                                    //   controller: _textEditingController,
                                    //   enabled: widget.enable,
                                    //   onChanged: _onChanged,
                                    //   onSubmitted: widget.onSubmitted,
                                    //   textInputAction: widget.textInputAction,
                                    //   inputFormatters: finalFormatter..add(LengthLimitingTextFieldFormatterFixed(widget.maxLength)),
                                    //   style: TextStyle(
                                    //     color: widget.textColor ?? Constant.kColorBlackPrimary,
                                    //     fontSize: 16,
                                    //     fontFamily: widget.fontFamily ?? FontUtil.regular,
                                    //   ),
                                    //   keyboardType: widget.keyboardType,
                                    //   scrollPadding: EdgeInsets.only(bottom: widget.scrollPaddingBottom, top: 40),
                                    //   textAlign: widget.textAlign,
                                    //   decoration: InputDecoration(
                                    //     enabledBorder: UnderlineInputBorder(
                                    //       borderSide: BorderSide(color: Colors.transparent),
                                    //     ),
                                    //     disabledBorder: UnderlineInputBorder(
                                    //       borderSide: BorderSide(color: Colors.transparent),
                                    //     ),
                                    //     focusedBorder: UnderlineInputBorder(
                                    //       borderSide: BorderSide(color: Colors.transparent),
                                    //     ),
                                    //     counterText: "",
                                    //     hintText: widget.hintText,
                                    //     contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    //     isDense: true,
                                    //     hintStyle: TextStyle(
                                    //       color: Constant.kColorBlackPrimary.withOpacity(0.7),
                                    //       fontSize: 14,
                                    //       fontFamily: FontUtil.regular,
                                    //     ),
                                    //   ),
                                    // ),
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
                    ] else if ((widget.controller != null &&
                            widget.controller!.text.length == 0) ||
                        (widget.controller == null &&
                            _textEditingController.text.length == 0)) ...[
                      SizedBox(
                        width: 16,
                      )
                    ] else ...[
                      InkWell(
                        onTap: () {
                          if (widget.controller == null) {
                            _textEditingController.clear();
                          } else {
                            widget.controller?.clear();
                          }
                          if (widget.onChanged != null) {
                            widget.onChanged?.call("");
                          }
                          setState(() {});
                        },
                        child: SizedBox(
                          height: widget.minHeight,
                          width: 40,
                          child: Center(
                              child: SvgPicture.asset(
                            BaseResourceUtil.icon("ic_close"),
                            height: 16,
                            width: 16,
                          )),
                        ),
                      )
                    ],
                    if (widget.obscureText)
                      InkWell(
                        onTap: _onShowPass,
                        child: _isShowPass
                            ? Container(
                                height: widget.minHeight,
                                width: 34,
                                //color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                              )
                            : Container(
                                height: widget.minHeight,
                                width: 34,
                                //color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                              ),
                      ),
                    if (widget.suffixIcon != null)
                      Container(
                        height: 40,
                        padding: const EdgeInsets.only(right: 12),
                        child: widget.suffixIcon,
                      ),
                  ],
                ),
              ),
              if (widget.isHasExtend) ...[
                Container(
                  height: 46,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                          width: 1, color: Constant.kColorBorderInput),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "/${DateTime.now().year}/HĐDV-CENHOMES",
                      style: TextStyle(
                          fontFamily: FontUtil.semiBold, fontSize: 13),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
        //lỗi
        if (isShowError != null && message != null && isShowError)
          Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
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
