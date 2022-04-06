import 'package:flutter/material.dart';

class ContainerShadowWidget extends StatelessWidget {
  final Widget? child;
  final double height;

  const ContainerShadowWidget({this.child,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, offset: Offset(1.1, 1.1), blurRadius: 4.0),
        ],
      ),
      child: child ?? const SizedBox(),
      height: height,
    );
  }
}
