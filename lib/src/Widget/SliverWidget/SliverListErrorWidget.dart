import 'package:flutter/cupertino.dart';

import '../../Common/Constant.dart';
import '../../Utils/BaseResourceUtil.dart';

class SliverListErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final Size? size;

  const SliverListErrorWidget({Key? key, this.errorMessage, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Center(
                child: Text(
                  "$errorMessage",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Constant.kColorText141),
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
