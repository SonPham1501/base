import 'package:base/src/Common/Enum.dart';
import 'package:base/src/Utils/BaseResourceUtil.dart';
import 'package:base/src/Widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';

import 'Widget/CachedImage.dart';
import 'Widget/DisplayGesture.dart';

// ignore: must_be_immutable
class PhotoViewPage extends StatefulWidget {
  final List<String>? medias;
  final String? tagHero;
  final int index;
  final String? tag;
  final imgPlaceholder;

  const PhotoViewPage(
      {Key? key, this.medias, this.tagHero, required this.index, this.tag, required this.imgPlaceholder})
      : super(
          key: key,
        );

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {

  int indexSelector = 0;
  ViewState viewState = ViewState.Loading;

  var mediasRx = <String>[];

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      viewState = ViewState.Loading;
      if (widget.medias != null && widget.medias!.isNotEmpty) {
        mediasRx = widget.medias!;

      }
      viewState = ViewState.Loaded;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          DisplayGesture(
            child: InteractiveviewerGallery<String>(
              sources: widget.medias!,
              initIndex: widget.index,
              itemBuilder: (BuildContext context, int index, bool isFocus) {
                return _buildItemWidget(index);
              },
              onPageChanged: (int pageIndex) {
                indexSelector = pageIndex;
                setState(() {});
              },
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${indexSelector + 1}/${widget.medias?.length ?? ""}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        BaseResourceUtil.icon("ic_close_x.svg"),
                        color: Colors.white,
                      ),
                      onPressed: Navigator.of(context).pop,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildItemWidget(int index) {
    if (viewState == ViewState.Loading) {
      return const LoadingWidget();
    } else {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        // onTap: () => Get.back(),
        child: Center(
          child: Hero(
            tag: mediasRx[index],
            // child: CachedImage(
            //   ProjectUtil.getUrlImageWithGuild(guid: controller.mediasRx[index].guid ?? ""),
            //   fit: BoxFit.contain,
            // ),
            child: CachedImage(
              mediasRx[index],
              fit: BoxFit.contain,
              imgPlaceholder: widget.imgPlaceholder,
            ),
          ),
        ),
      );
      //}
    }
  }
}
