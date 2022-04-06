import 'package:CenBase/CenBase.dart';
import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Common/Enum.dart';
import 'package:CenBase/Utils/FontUtil.dart';
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
