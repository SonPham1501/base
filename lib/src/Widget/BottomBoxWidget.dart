import 'package:flutter/material.dart';

class BottomBoxWidget extends StatelessWidget {
  final Widget? child;

  const BottomBoxWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == null) return SizedBox();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0, 0), blurRadius: 4.0)],
      ),
      child: SafeArea(top: false, child: child!),
    );
  }
}
