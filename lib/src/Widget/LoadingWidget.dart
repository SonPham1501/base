import 'package:base/src/Common/Constant.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double size,padding;
  final double strokeWidth;

  const LoadingWidget({Key? key, this.color, this.size = 32,this.padding = 3, this.strokeWidth = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Constant.kColorOrangePrimary),
      ),
    );
  }
}
