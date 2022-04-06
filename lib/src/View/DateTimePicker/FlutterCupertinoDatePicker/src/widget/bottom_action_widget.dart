import 'package:CenBase/Widget/ButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomActionWidget extends StatelessWidget {
  BottomActionWidget({
    Key? key,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  final Function()? onCancel, onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ButtonWidget(
              title: "Hủy",
              buttonType: ButtonType.Cancel,
              onTap: this.onCancel,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: ButtonWidget(
              title: "Chọn",
              onTap: this.onConfirm,
            ),
          )
        ],
      ),
    );
  }
}
