import 'package:base/src/CenBase.dart';
import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Common/Enum.dart';
import 'package:base/src/Utils/FontUtil.dart';
import 'package:flutter/material.dart';

class VersionInfoWidget extends StatelessWidget {
  const VersionInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (CenBase.buildType == CenBuildType.test)
            Column(
              children: [
                Text(
                  "Môi trường Test",
                  style: TextStyle(
                    color: Constant.kGreyColor,
                    fontFamily: FontUtil.regular,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          Text(
            "Phiên bản: ${CenBase.version} - ${CenBase.buildVersion}",
            style: TextStyle(
              color: Constant.kGreyColor,
              fontFamily: FontUtil.regular,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
