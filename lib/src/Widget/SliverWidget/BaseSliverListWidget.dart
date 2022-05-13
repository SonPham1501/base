import 'package:base/src/Common/Enum.dart';
import 'package:base/src/Model/BaseLoadMoreModel.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Common/Constant.dart';
import 'SliverListLoadMoreWidget.dart';
import 'SliverListLoadingWidget.dart';
import 'SliverListMessageWidget.dart';
import 'SliverListTotalRecord.dart';

class BaseSliverListWidget extends StatefulWidget {
  final Function? onLoadMore;
  final Function? onRefresh;
  final Widget? childHeader;
  final Widget? childList;
  final ViewState viewState;
  final bool isBottomSafeArea;
  final bool isShowTotalRecord;
  final String? contentTotalRecord;
  final BaseLoadMoreModel baseLoadMoreModel;

  const BaseSliverListWidget({
    Key? key,
    required this.baseLoadMoreModel,
    this.onLoadMore,
    this.onRefresh,
    this.childHeader,
    this.childList,
    this.viewState = ViewState.Loading,
    this.isBottomSafeArea = true,
    this.isShowTotalRecord = false,
    this.contentTotalRecord,
  }) : super(key: key);

  @override
  State<BaseSliverListWidget> createState() => _BaseSliverListWidgetState();
}

class _BaseSliverListWidgetState extends State<BaseSliverListWidget> {
  var refreshController = RefreshController(initialRefresh: false);
  var scrollController = ScrollController();

  String errorMessage = '';

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    //var controller = Get.find<BaseSliverListController>(tag: tag);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          print("--onLoadMore");
          widget.onLoadMore?.call();
        }
        return true;
      },
      child: SmartRefresher(
        header: const MaterialClassicHeader(
          color: Constant.kColorOrangePrimary,
        ),
        controller: refreshController,
        onRefresh: () {
          widget.onRefresh?.call();
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            if (widget.childHeader != null) widget.childHeader!,
            if (widget.viewState == ViewState.Loading) ...[
              const SliverListLoadingWidget(),
            ],
            if (widget.viewState == ViewState.Loaded ||
                widget.viewState == ViewState.Complete) ...[
              if (widget.isShowTotalRecord)
                SliverListTotalRecord(
                  total: widget.baseLoadMoreModel.numberLoad,
                  contentName: widget.contentTotalRecord,
                ),
              if (widget.childList != null) widget.childList!,
              SliverListLoadMoreWidget(
                loadMore: widget.baseLoadMoreModel.isLoad,
              ),
            ],
            if (widget.viewState == ViewState.Error) ...[
              SliverListMessageWidget(
                title: errorMessage,
              ),
            ],
            if (widget.viewState == ViewState.DataNull) ...[
              const SliverListMessageWidget(
                title: "Không có dữ liệu",
              ),
            ],
            if (widget.isBottomSafeArea)
              const SliverToBoxAdapter(
                child: SafeArea(
                  top: false,
                  child: SizedBox(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
