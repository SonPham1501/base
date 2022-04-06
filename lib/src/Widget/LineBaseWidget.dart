import 'package:base/src/Common/Constant.dart';
import 'package:flutter/material.dart';

class LineBaseWidget extends StatelessWidget {
  final Color? color;
  final double thickness;

  const LineBaseWidget({Key? key, this.color, this.thickness = 0.7}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thickness,
      child: Divider(
        color: color ?? Constant.kLineColor,
        height: 0,
        thickness: thickness,
      ),
    );
  }
}
