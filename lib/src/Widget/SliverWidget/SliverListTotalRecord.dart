import 'package:flutter/material.dart';

import '../../Common/Constant.dart';
import '../../Utils/flutter_base/Util.dart';

class SliverListTotalRecord extends StatelessWidget {
  final int total;
  final String? contentName;

  const SliverListTotalRecord({Key? key, this.total = 0, this.contentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: RichText(
                      text: TextSpan(text: "", style: const TextStyle(color: Constant.kGreyColor4E, fontSize: 13), children: [
                        TextSpan(
                          text: "${Util.intToPriceDouble(total)} ",
                          style: const TextStyle(color: Constant.kGreyColor4E, fontSize: 13),
                        ),
                        TextSpan(
                          text: contentName ?? "dữ liệu",
                          style: const TextStyle(color: Constant.kGreyColor4E, fontSize: 13),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            //Divider(height: 1,)
          ],
        ),
      ),
    );
  }
}
