import 'package:flutter/material.dart';

class ContainerShadowWidget extends StatelessWidget {
  final Widget? child;
  final double height;

  // ignore: use_key_in_widget_constructors
  const ContainerShadowWidget({this.child,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Theme.of(context).shadowColor, offset: const Offset(1.1, 1.1), blurRadius: 4.0),
        ],
      ),
      child: child ?? const SizedBox(),
      height: height,
    );
  }
}
