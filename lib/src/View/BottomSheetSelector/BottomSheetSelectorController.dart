// import 'package:base/src/Base/BaseController.dart';
// import 'package:base/src/Model/SelectorModel.dart';
// import 'package:base/src/Utils/flutter_base/Util.dart';
// import 'package:flutter/cupertino.dart';

// class BottomSheetSelectorController extends BaseController {
// //region -------- VALUES --------
//   final bool isMultiSelect;
//   final Function(List<SelectorModel> list)? onSuccess;
//   final List<SelectorModel> list;
//   var listSelector = <SelectorModel>[];
//   var textSearchController = TextEditingController();
//   BuildContext context;

//   BottomSheetSelectorController(this.context,
//       {required this.isMultiSelect, this.onSuccess, required this.list}) {
//     print("Fucl");
//     viewState = ViewState.Loading;
//     for (var item in list) {
//       listSelector.add(item);
//     }
//     notifyListeners();
//   }

// //endregion

// //endregion

// //region -------- SERVICE --------

// //endregion

// //region -------- ACTION FROM VIEW --------

//   void onSelect(SelectorModel selectorModel) {
//     if (isMultiSelect) {
//       Util.onHideKeyboard(context);
//       selectorModel.isCheck = !selectorModel.isCheck;
//       // listSelector.refesh();
//     } else {
//       for (var element in listSelector) {
//         element.isCheck = false;
//       }
//       selectorModel.isCheck = !selectorModel.isCheck;
//       Util.onHideKeyboard(context);
//       onSuccess?.call(list);
//       Navigator.of(context).pop();
//     }
//     notifyListeners();
//   }

//   void onResetValue() {
//     for (var item in listSelector) {
//       item.isCheck = false;
//     }
//     notifyListeners();
//   }

//   void onSubmit() {
//     onSuccess?.call(listSelector);
//     Navigator.of(context).pop();
//   }

// //endregion

// //region -------- ON CHANGE --------
//   void onChangeTextSearch(String value) {
//     listSelector.clear();
//     if (textSearchController.text.isEmpty) {
//       for (var item in list) {
//         listSelector.add(item);
//       }
//     } else {
//       var textSearch = Util.nonUnicode(textSearchController.text.trim()).toLowerCase();
//       for (var item in list) {
//         if (Util.nonUnicode(item.title).toLowerCase().contains(textSearch)) {
//           listSelector.add(item);
//         }
//       }
//     }
//     // listSelector.refresh();
//     notifyListeners();
//   }
// //endregion

// //region -------- FUNCTION --------

// //endregion
// }
