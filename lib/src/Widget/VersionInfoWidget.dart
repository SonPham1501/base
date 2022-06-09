import 'package:base/src/AppBase.dart';
import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Common/Enum.dart';
import 'package:flutter/material.dart';

class VersionInfoWidget extends StatelessWidget {
  const VersionInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (AppBase.buildType == Environment.DEV)
            Column(
              children: const [
                Text(
                  "Môi trường Test",
                  style: TextStyle(
                    color: Constant.kGreyColor,
                    // fontFamily: FontUtil.regular,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          Text(
            "Phiên bản: ${AppBase.version} - ${AppBase.buildVersion}",
            style: const TextStyle(
              color: Constant.kGreyColor,
              // fontFamily: FontUtil.regular,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
