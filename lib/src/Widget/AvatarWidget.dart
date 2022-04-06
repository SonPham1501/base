import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Utils/flutter_base/Util.dart';

class AvatarWidget extends StatelessWidget {
  final double size;
  final String? url;
  final String? name;
  final Widget? errorWidget;
  final String? userName;
  final double fontSize;
  final isGetFirstChar;

  const AvatarWidget({
    Key? key,
    this.size = 50,
    this.
    url,
    this.name,
    this.userName,
    this.errorWidget,
    this.fontSize = 18,
    this.isGetFirstChar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var char = "";
    if (isGetFirstChar) {
      char = Util.getAvatarName(name ?? "").toUpperCase();
    } else {
      char = Util.getAvatarName(Util.getFirstLastName(name ?? "").firstName).toUpperCase();
    }
    return SizedBox(
      height: size,
      width: size,
      child: (url == null || url!.isEmpty)
          ? TextAvatarWidget(
              size: size,
              fontSize: fontSize,
              char: char,
            )
          : AvatarImage(
              url: url,
              errorWidget: errorWidget,
              char: char,
              fontSize: fontSize,
            ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  const AvatarImage({this.size = 32, this.url, required this.char, required this.fontSize, this.errorWidget});

  final Widget? errorWidget;
  final double size;
  final String? url;
  final String char;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return cachedNetworkImageCustom(
      imageUrl: url,
      widthBox: size,
      heightBox: size,
      errorWidget: errorWidget,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget cachedNetworkImageCustom({
    Key? key,
    String? imageUrl,
    double? widthBox,
    Widget? errorWidget,
    double? heightBox,
    Function(BuildContext context, ImageProvider imageProvider)? imageBuilder,
  }) {
    if (imageUrl == null) {
      return Container(
        height: heightBox,
        width: widthBox,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.orange.withOpacity(0.2),
        ),
        child: Align(
          alignment: Alignment.center,
          child: TextAvatarWidget(
            size: size,
            char: char,
            fontSize: fontSize,
          ),
        ),
      );
    }
    return CachedNetworkImage(
      key: key,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return imageBuilder!(context, imageProvider);
      },
      placeholder: (context, url) =>
      errorWidget!= null ? const SizedBox() :TextAvatarWidget(
        size: size,
        char: char,
        fontSize: fontSize,
      ),
      fadeInCurve: Curves.easeIn,
      errorWidget: (context, url, error) => errorWidget ?? TextAvatarWidget(
              size: size,
              char: char,
              fontSize: fontSize,
            ),
    );
  }
}

class TextAvatarWidget extends StatelessWidget {
  final double size;
  final String char;
  final double fontSize;

  const TextAvatarWidget({Key? key, required this.size, required this.char, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Util.getColorAvatarRandom(char),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 1),
      child: Text(
        char.trim(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
