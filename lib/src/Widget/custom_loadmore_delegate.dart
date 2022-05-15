import 'package:loadmore/loadmore.dart';
import 'package:flutter/material.dart';

class CustomLoadMoreDelegate extends LoadMoreDelegate {
  const CustomLoadMoreDelegate(this.context, {this.isShowNoMore = true});

  final BuildContext context;
  final bool isShowNoMore;

  @override
  Widget buildChild(LoadMoreStatus status, {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese}) {
    if (status == LoadMoreStatus.idle) {
      return const Text('Đang tải dữ liệu');
    }

    if (status == LoadMoreStatus.nomore) {
      return isShowNoMore
        ? const Text('Hết dữ liệu')
        : const SizedBox();
    }

    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 26,
            height: 26,
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF8F8F8)),
              backgroundColor: Theme.of(context).primaryColor,
              strokeWidth: 2.3,
            ),
          ),
        ],
      ),
    );
  }

}