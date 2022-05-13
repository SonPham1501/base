class BaseLoadMoreModel{
  BaseLoadMoreModel({
    this.isLoad = false,//đang load api không load thêm
    this.isEnd = false,//đã hết bản ghi
    this.totalRecord = 0,// tổng số lượng bản ghi
    this.page = 0,//số lượng page load
    this.numberLoad = 30,//số lượng bản ghi 1 lần load
    this.isLoadMore = false,//số lượng bản ghi 1 lần load
    this.totalPage = 0,//page hiện tại
  });
  bool isLoad;//đang load api không load thêm
  bool isEnd;//đã hết bản ghi
  int totalRecord;// tổng số lượng bản ghi
  int page;//số lượng page load
  int numberLoad;//số lượng bản ghi 1 lần load
  bool isLoadMore;
  int totalPage;//số lượng bản ghi 1 lần load
}