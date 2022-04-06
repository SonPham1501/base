import 'package:flutter/material.dart';

import '../../Base/BaseController.dart';
import '../../Common/Constant.dart';
import '../../Utils/BaseResourceUtil.dart';
import '../../Utils/FontUtil.dart';

class SliverListMessageWidget extends StatelessWidget {
  final String? title;
  final ViewState viewState;
  final Size? size;

  const SliverListMessageWidget({Key? key, this.title, this.viewState = ViewState.None, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Center(
                child: Text(
              title ?? "Không có dữ liệu",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: FontUtil.regular, color: Constant.kColorText141),
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Image.asset(
              BaseResourceUtil.icon("bg_error.png"),
              width: (size?.width ?? 0) * 0.7,
              height: (size?.height ?? 0) * 0.4,
            ),
          )
        ],
      ),
    );
  }
}
