import 'package:CenBase/Base/BaseController.dart';
//import 'package:CenHomesListing/Page/ProjectDetail/Widget/Slider/SliderDetailController.dart';

class PhotoController extends BaseController {
  int index;

  List<String>? medias;

  var mediasRx = <String>[];
  var indexSelector = 0;

  void setIndexSelector(int indexSelector) {
    this.indexSelector = indexSelector;
    notifyListeners();
  }

  PhotoController({required this.medias, this.index = 0}) {
    viewState = ViewState.Loading;
    if (medias != null && medias!.length > 0) {
      mediasRx = medias!;

    }
    viewState = ViewState.Loaded;
    notifyListeners();
  }
}
