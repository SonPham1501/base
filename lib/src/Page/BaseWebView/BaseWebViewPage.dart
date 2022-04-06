import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Common/Enum.dart';
import 'package:base/src/Utils/BaseProjectUtil.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';
import 'package:base/src/Widget/BaseAppBarWidget.dart';
import 'package:base/src/Widget/LineBaseWidget.dart';
import 'package:base/src/Widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class BaseWebViewPage extends StatefulWidget {
  final String url;
  final String? title;
  final bool isShowShare;
  final Function? onSuccess;

  const BaseWebViewPage({Key? key, required this.url, this.onSuccess, this.title, this.isShowShare = false}) : super(key: key);

  @override
  State<BaseWebViewPage> createState() => _BaseWebViewPageState();
}

class _BaseWebViewPageState extends State<BaseWebViewPage> {
  final ScrollController _scrollController = ScrollController();

  ViewState _viewState = ViewState.Loading;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => Util.onHideKeyboard(context),
        child: Column(
          children: [
            BaseAppBarWidget(
              context: context,
              textTitle: widget.title ?? "",
              actions: [
                if (widget.isShowShare)
                  PopupMenuButton(
                      offset: const Offset(0, 50),
                      onSelected: (value) {
                        if (value == 1) {
                          BaseProjectUtil.share(title: widget.url);
                        }
                        if (value == 2) {
                          Util.launchURL(widget.url);
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
            Expanded(
              child: Stack(
                children: [
                  ClipRect(
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: widget.url,
                      onPageFinished: (value) {
                        Util.onHideKeyboard(context);
                        _viewState = ViewState.Loaded;
                      },
                      onProgress: (value) {
                        _viewState = ViewState.Loading;
                      },
                    ),
                  ),
                  if (_viewState == ViewState.Loading)
                    const Positioned(
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    )
                  else
                    const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
