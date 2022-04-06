import 'package:base/src/Base/BaseController.dart';
import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Utils/BaseProjectUtil.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';
import 'package:base/src/Widget/BaseAppBarWidget.dart';
import 'package:base/src/Widget/LineBaseWidget.dart';
import 'package:base/src/Widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'BaseWebViewController.dart';

// ignore: must_be_immutable
class BaseWebViewPage extends StatelessWidget {
  final String url;
  final String? title;
  final bool isShowShare;
  final Function? onSuccess;
  late BaseWebViewController controller;
  final ScrollController _scrollController = ScrollController();

  BaseWebViewPage({Key? key, required this.url, this.onSuccess, this.title, this.isShowShare = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("PaymentMethodPage");
    controller = Provider.of<BaseWebViewController>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: Constant.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => controller.onHideKeyboard(context),
        child: Column(
          children: [
            BaseAppBarWidget(
              context: context,
              textTitle: title ?? "",
              actions: [
                if (isShowShare)
                  PopupMenuButton(
                      offset: const Offset(0, 50),
                      onSelected: (value) {
                        if (value == 1) {
                          BaseProjectUtil.share(title: url);
                        }
                        if (value == 2) {
                          Util.launchURL(url);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.more_vert_rounded,
                          color: Constant.kColorBlackPrimary,
                        ),
                      ),
                      itemBuilder: (context) => [
                            const PopupMenuItem(
                              child: Text("Chia sẻ"),
                              value: 1,
                            ),
                            const PopupMenuItem(
                              child: Text("Mở trong trình duyệt"),
                              value: 2,
                            )
                          ])
              ],
            ),
            const LineBaseWidget(),
            Consumer<BaseWebViewController>(
              builder: (context, value, child) {
                return Expanded(
                  child: Stack(
                    children: [
                      ClipRect(
                        child: WebView(
                          javascriptMode: JavascriptMode.unrestricted,
                          initialUrl: url,
                          onPageFinished: (value) {
                            controller.onHideKeyboard(context);
                            controller.setViewState(
                              ViewState.Loaded,
                            );
                          },
                          onProgress: (value) {
                            controller.setViewState(
                              ViewState.Loading,
                            );
                          },
                        ),
                      ),
                      if (value.viewState == ViewState.Loading)
                        const Positioned(
                          child: Center(
                            child: LoadingWidget(),
                          ),
                        )
                      else
                        const SizedBox()
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
