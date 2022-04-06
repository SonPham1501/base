import 'package:CenBase/Base/BaseController.dart';

class BaseWebViewController extends BaseController {
//region -------- VALUES --------
  final Function? onSuccess;

  BaseWebViewController({this.onSuccess});

//region -------- ACTION FROM VIEW --------
  bool isBack = true;

  void onPageFinished(String url) {
    viewState = ViewState.Loaded;
    notifyListeners();
  }
  void onPageStarted(String url) {

  }
//endregion

//region -------- ON CHANGE --------

//endregion

//region -------- FUNCTION --------

//endregion
}
