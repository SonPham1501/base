import 'package:flutter/material.dart';

class DashLineWidget extends StatelessWidget {
  final Color color;

   const DashLineWidget({Key? key, this.color = Colors.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(color: color),
    );
  }
}

class DashedLinePainter extends CustomPainter {

  final Color color;

  DashedLinePainter({Key? key,required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 2, dashSpace = 1, startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;
    while (startX < size.width - dashSpace) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
