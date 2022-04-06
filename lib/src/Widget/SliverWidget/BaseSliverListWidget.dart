import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Base/BaseController.dart';
import '../../Base/BaseSliverListController.dart';
import '../../Common/Constant.dart';
import 'SliverListLoadMoreWidget.dart';
import 'SliverListLoadingWidget.dart';
import 'SliverListMessageWidget.dart';
import 'SliverListTotalRecord.dart';

class BaseSliverListWidget extends StatelessWidget {
  final Function? onLoadMore;
  final Function? onRefresh;
  final Widget? childHeader;
  final Widget? childList;
  final BaseSliverListController controller;
  final bool isBottomSafeArea;
  final bool isShowTotalRecord;
  final String? contentTotalRecord;

  const BaseSliverListWidget({
    Key? key,
    required this.controller,
    this.onLoadMore,
    this.onRefresh,
    this.childHeader,
    this.childList,
    this.isBottomSafeArea = true,
    this.isShowTotalRecord = false,
    this.contentTotalRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var controller = Get.find<BaseSliverListController>(tag: tag);
    return Consumer<BaseSliverListController>(builder: (context, value, child) {
      return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              print("--onLoadMore");
              onLoadMore?.call();
            }
            return true;
          },
          child: SmartRefresher(
            header: const MaterialClassicHeader(
              color: Constant.kColorOrangePrimary,
            ),
            controller: controller.refreshController,
            onRefresh: () {
              onRefresh?.call();
            },
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                if (childHeader != null) childHeader!,
                if (value.viewState == ViewState.Loading) ...[
                  const SliverListLoadingWidget(),
                ],
                if (value.viewState == ViewState.Loaded ||
                    value.viewState == ViewState.Complete) ...[
                  if (isShowTotalRecord)
                    Consumer<BaseSliverListController>(
                      builder: (context, value, child) {
                        return SliverListTotalRecord(
                          total: value.countRecord,
                          contentName: contentTotalRecord,
                        );
                      },
                    ),
                  if (childList != null) childList!,
                  SliverListLoadMoreWidget(
                    loadMore: controller.isLoadMore,
                  ),
                ],
                if (value.viewState == ViewState.Error) ...[
                  SliverListMessageWidget(
                    title: value.errorMessage,
                  ),
                ],
                if (value.viewState == ViewState.DataNull) ...[
                  const SliverListMessageWidget(
                    title: "Không có dữ liệu",
                  ),
                ],
                if (isBottomSafeArea)
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
      },
    );
  }
}
