import 'package:base/src/Widget/flutter_base/MeasureSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class MeasureSizeWidget extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSizeWidget({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeWidgetState createState() => _MeasureSizeWidgetState();
}

class _MeasureSizeWidgetState extends State<MeasureSizeWidget> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize!);
  }
}
