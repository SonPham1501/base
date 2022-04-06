class LoadMorePageBase {
  int maxPerPage = 30;

  int currentOffset = 0;

  bool canNext = true;

  LoadMorePageBase({
    this.currentOffset = 0,
    this.canNext = true,
  });

  void addData(List newData) {
    final array = newData;
    canNext = array.length >= maxPerPage;
    currentOffset += maxPerPage;
    // if()
  }
}