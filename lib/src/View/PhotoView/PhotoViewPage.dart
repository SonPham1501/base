import 'package:CenBase/Base/BaseController.dart';
import 'package:CenBase/Utils/BaseResourceUtil.dart';
import 'package:CenBase/Widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';
import 'package:provider/provider.dart';

import 'PhotoController.dart';
import 'Widget/CachedImage.dart';
import 'Widget/DisplayGesture.dart';

// ignore: must_be_immutable
class PhotoViewPage extends StatelessWidget {
  List<String>? medias;

  String? tagHero;
  int index;
  String? tag;

  PhotoViewPage({this.medias, this.tagHero, required this.index, this.tag});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => PhotoController(medias: medias), child: Consumer<PhotoController>(builder: (context, value, child) {
      return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          DisplayGesture(
            child: InteractiveviewerGallery<String>(
              sources: medias!,
              initIndex: index,
              itemBuilder: (BuildContext context, int index, bool isFocus) {
                return _buildItemWidget(index, value);
              },
              onPageChanged: (int pageIndex) {
                value.setIndexSelector(pageIndex);
              },
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 0,
                ),
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${value.indexSelector + 1}/${medias?.length ?? ""}",
                          style: TextStyle(color: Colors.white),
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
    },),);
  }

  _buildItemWidget(int index, PhotoController controller) {
    if (controller.viewState == ViewState.Loading) {
      return LoadingWidget();
    } else {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        // onTap: () => Get.back(),
        child: Center(
          child: Hero(
            tag: controller.mediasRx[index],
            // child: CachedImage(
            //   ProjectUtil.getUrlImageWithGuild(guid: controller.mediasRx[index].guid ?? ""),
            //   fit: BoxFit.contain,
            // ),
            child: CachedImage(
              controller.mediasRx[index],
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
      //}
    }
  }
}
