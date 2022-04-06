import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CycleProgressWidget extends StatelessWidget {
  Color? lineColor;
  Color? completeColor;
  double completePercent;
  double width;

  CycleProgressWidget({Key? key, this.lineColor, this.completeColor,required this.completePercent, this.width = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          foregroundPainter: CycleProgressWidgetPainter(
            lineColor: lineColor,
            completeColor: completeColor,
            completePercent: completePercent,
            width: width,
          ),
        ),
      ),
    );
  }
}

class CycleProgressWidgetPainter extends CustomPainter {
  Color? lineColor;
  Color? completeColor;
  double completePercent;
  double width;

  CycleProgressWidgetPainter({this.lineColor, this.completeColor,required this.completePercent,required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor ?? const Color(0xff27AE60)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = Paint()
      ..color = completeColor ?? const Color(0xff808080)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
