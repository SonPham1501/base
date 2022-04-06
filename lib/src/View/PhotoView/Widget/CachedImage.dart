import 'package:CenBase/CenBase.dart';
import 'package:CenBase/Utils/BaseProjectUtil.dart';
import 'package:CenBase/Utils/BaseResourceUtil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  String? imageUrl;
  BoxFit? fit;
  double? width;
  double? scale;

  CachedImage(this.imageUrl, {this.fit, this.width, this.scale});

  @override
  Widget build(BuildContext context) {
    var urlNew = imageUrl;
    if (width != null && scale != null && imageUrl != null) {
      urlNew = BaseProjectUtil.resizeUrlImage(url: imageUrl!, width: width!, height: width! / scale!);
    }
    if (urlNew != null && urlNew.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: urlNew,
        fit: fit ?? BoxFit.contain,
        errorWidget: (context, url, error) {
          return Image.asset(
            BaseResourceUtil.icon("img_placeholder.png"),
            fit: BoxFit.cover,
          );
        },
        placeholder: (context, url) => Image.asset(
          BaseResourceUtil.icon("img_placeholder.png"),
          fit: BoxFit.cover,
        ),
        httpHeaders: {"Authorization": CenBase.accessToken ?? CenBase.systemToken ?? ""},
      );
    } else {
      return Image.asset(
        BaseResourceUtil.icon("img_placeholder.png"),
        fit: BoxFit.cover,
      );
    }
  }
}
