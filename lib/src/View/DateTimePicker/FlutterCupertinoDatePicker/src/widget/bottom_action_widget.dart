import 'package:base/src/Widget/ButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomActionWidget extends StatelessWidget {
  const BottomActionWidget({
    Key? key,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  final Function()? onCancel, onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ButtonWidget(
              title: "Hủy",
              buttonType: ButtonType.Cancel,
              onTap: onCancel,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: ButtonWidget(
              title: "Chọn",
              onTap: onConfirm,
            ),
          )
        ],
      ),
    );
  }
}
