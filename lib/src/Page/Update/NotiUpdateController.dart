import 'package:base/src/Base/BaseController.dart';

class NotiUpdateController extends BaseController {
  var isAgree = true;

  void setIsAgree(var isAgree) {
    this.isAgree = isAgree;
    notifyListeners();
  }
}