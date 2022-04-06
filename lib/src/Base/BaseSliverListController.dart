import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'BaseController.dart';

class BaseSliverListController extends BaseController {
  var refreshController = RefreshController(initialRefresh: false);
  var scrollController = ScrollController();
  bool isLoadMore = false;
  bool isLoad = false; //đang load api không load thêm
  bool isEnd = false; //đã hết bản ghi
  int page = 1; //trang
  var countFilter = 0; //số lượng filter
  var countRecord = 0; //số lượng bản ghi

  void setIsLoadMore(bool isLoadMore) {
    this.isLoadMore = isLoadMore;
    notifyListeners();
  }

  void setCountRecord(var countRecord) {
    this.countRecord = countRecord;
    notifyListeners();
  }

  void clearData() {
    isLoad = false;
    isEnd = false;
    page = 1;
  }

  void checkData({required List listShow, required List listDataApi, int? totalRecord}) {
    if (totalRecord != null) {
      countRecord = totalRecord;
    }
    if (listShow.isEmpty) {
      viewState = ViewState.DataNull;
    } else {
      viewState = ViewState.Loaded;
    }
    if (listDataApi.isEmpty || totalRecord == listShow.length) {
      isEnd = true;
      isLoadMore = false;
    }
    notifyListeners();
  }
}
