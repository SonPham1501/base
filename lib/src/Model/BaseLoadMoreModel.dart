class BaseLoadMoreModel{
  bool isLoad = false;//đang load api không load thêm
  bool isEnd = false;//đã hết bản ghi
  int totalRecord = 0;// tổng số lượng bản ghi
  int page = 0;//số lượng page load
  int numberLoad = 30;//số lượng bản ghi 1 lần load
  bool isLoadMore = false;//số lượng bản ghi 1 lần load
}