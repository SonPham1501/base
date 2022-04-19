import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final Widget child;
  final AsyncCallback? onPress;

  const CommonButton({Key? key, required this.onPress, required this.child}) : super(key: key);

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  bool _condition = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: widget.key,
      onTap: widget.onPress == null ? null : checkCondition,
      child: widget.child,
    );
  }

  void checkCondition() async {
    if (!_condition) return;
    FocusScope.of(context).requestFocus(FocusNode());
    _condition = false;
    widget.onPress!().then((value) {
      _condition = true;
    });
  }
}
