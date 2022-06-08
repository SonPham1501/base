// ignore_for_file: file_names

import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatefulWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? scale;
  final String imgPlaceholder;

  const CachedImage(this.imageUrl, {Key? key, this.fit, this.width, this.scale, required this.imgPlaceholder}) : super(key: key);

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  String access_token = '';

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      access_token = await SecureStorageUtil.getString(SecureStorageUtil.Token);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var urlNew = widget.imageUrl;
    if (widget.width != null && widget.scale != null && widget.imageUrl != null) {
      urlNew = BaseProjectUtil.resizeUrlImage(url: widget.imageUrl!, width: widget.width!, height: widget.width! / widget.scale!);
    }
    if (urlNew != null && urlNew.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: urlNew,
        fit: widget.fit ?? BoxFit.contain,
        errorWidget: (context, url, error) {
          return Image.asset(
            widget.imgPlaceholder,
            fit: BoxFit.cover,
          );
        },
        placeholder: (context, url) => Image.asset(
          widget.imgPlaceholder,
          fit: BoxFit.cover,
        ),
        httpHeaders: {"Authorization": access_token},
      );
    } else {
      return Image.asset(
        widget.imgPlaceholder,
        fit: BoxFit.cover,
      );
    }
  }
}
