// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DisplayGesture extends StatefulWidget {
  final Widget? child;

  const DisplayGesture({this.child});

  @override
  _DisplayGestureState createState() => _DisplayGestureState();
}

class _DisplayGestureState extends State<DisplayGesture> {
  List<PointerEvent> displayModelList = [];

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        displayModelList.add(event);
        setState(() {});
      },
      onPointerMove: (PointerMoveEvent event) {
        for (int i = 0; i < displayModelList.length; i++) {
          if (displayModelList[i].pointer == event.pointer) {
            displayModelList[i] = event;
            setState(() {});
            return;
          }
        }
      },
      onPointerUp: (PointerUpEvent event) {
        for (int i = 0; i < displayModelList.length; i++) {
          if (displayModelList[i].pointer == event.pointer) {
            displayModelList.removeAt(i);
            setState(() {});
            return;
          }
        }
      },
      child: Stack(
        children: [
          widget.child!,
          ...displayModelList.map((PointerEvent e) {
            return Positioned(
              left: e.position.dx - 15,
              top: e.position.dy - 15,
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0x99ffffff),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                // child: Icon(
                //   Icons.adjust,
                //   size: 40,
                //   color: Colors.greenAccent,
                // ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
