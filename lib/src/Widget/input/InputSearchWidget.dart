import 'package:async/async.dart';
import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class InputSearchWidget extends StatefulWidget {
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
  final FontWeight fontWeight;

  const InputSearchWidget({Key? key, 
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
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  _InputInfoWidgetState createState() => _InputInfoWidgetState();
}

class _InputInfoWidgetState extends State<InputSearchWidget> {
  CancelableOperation? cancelableOperation;
  late DeBouncerDuration onSearchDeBouncer;
  bool focusScope = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onSearchDeBouncer = DeBouncerDuration(delay: Duration(milliseconds: widget.timeDeBouncer));
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
      onSearchDeBouncer.debounce(() {
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
    bool? isShowError;
    String? message;
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
            border: widget.border ?? Border.all(color: const Color(0xffF4F4F5), width: 1),
            borderRadius: widget.borderRadiusBackground ?? BorderRadius.circular(8),
          ),
          height: 38,
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
                  constraints: BoxConstraints(
                    minHeight: widget.minHeight,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      widget.onTap?.call();
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(widget.icon != null ? 0 : 16, 0, 0, 0),
                      alignment: widget.minHeight == 40 ? Alignment.centerLeft : Alignment.topLeft,
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
                                inputFormatters: finalFormatter..add(LengthLimitingTextFieldFormatterFixed(widget.maxLength)),
                                style: TextStyle(
                                  color: widget.textColor ?? ColorExtends('4F4F4F'),
                                  fontSize: 14,
                                  fontWeight: widget.fontWeight,
                                ),
                                keyboardType: widget.keyboardType,
                                scrollPadding: EdgeInsets.only(bottom: widget.scrollPaddingBottom, top: 40),
                                textAlign: widget.textAlign,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  counterText: "",
                                  hintText: widget.hintText,
                                  contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  isDense: true,
                                  hintStyle: const TextStyle(
                                    color: Color(0xffA0A3BD),
                                    fontSize: 14,
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
                const SizedBox(
                  width: 16,
                )
              ] else if (widget.controller?.text.isEmpty == true) ...[
                const SizedBox(
                  width: 16,
                )
              ] else ...[
                IconButton(
                  onPressed: () {
                    widget.controller?.text = "";
                    widget.onChanged?.call("");
                    widget.onChangedDeBouncer?.call("");
                    setState(() {});
                  },
                  icon: SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                      child: SvgPicture.asset(
                        BaseResourceUtil.icon("ic_close_x.svg"),
                        height: 24,
                        width: 24,
                        color: const Color(0xFF5E5873),
                      ),
                    ),
                  ),
                  highlightColor: const Color(0xffF4F4F5).withOpacity(0.3),
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
        if (message != null && isShowError == true)
          Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            alignment: widget.alignment,
            child: Text(
              message,
              style: const TextStyle(
                color: Constant.kRedColor,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
