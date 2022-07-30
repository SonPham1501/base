import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Common/Enum.dart';
import 'package:base/src/Model/SelectorModel.dart';
import 'package:base/src/Utils/BaseResourceUtil.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';
import 'package:base/src/Widget/BaseAppBarBottomSheetWidget.dart';
import 'package:base/src/Widget/ButtonWidget.dart';
import 'package:base/src/Widget/LineBaseWidget.dart';
import 'package:base/src/Widget/input/InputSearchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class BottomSheetSelector extends StatefulWidget {
  static show(
    BuildContext context, {
    required String title,
    required List<SelectorModel> listSelector,
    bool isMultiSelect = false,
    Function(List<SelectorModel> list)? onSuccess,
  }) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheetSelector(
            title: title,
            list: SelectorModel.copyList(listSelector: listSelector),
            isMultiSelect: isMultiSelect,
            onSuccess: onSuccess,
          );
        });
  }

  final List<SelectorModel> list;
  final String? title;
  final bool isMultiSelect;
  final Function(List<SelectorModel> list)? onSuccess;

  const BottomSheetSelector({
    Key? key,
    this.onSuccess,
    required this.list,
    this.title,
    this.isMultiSelect = true,
  }) : super(key: key);

  @override
  State<BottomSheetSelector> createState() => _BottomSheetSelectorState();
}

class _BottomSheetSelectorState extends State<BottomSheetSelector> {
  final textSearchController = TextEditingController();
  var listSelector = <SelectorModel>[];
  final List<SelectorModel> list = [];
  ViewState viewState = ViewState.Loading;
  final bool isMultiSelect = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      viewState = ViewState.Loading;
      for (var item in list) {
        listSelector.add(item);
      }
      setState(() {});
    });
  }

  void onChangeTextSearch(String value) {
    listSelector.clear();
    if (textSearchController.text.isEmpty) {
      for (var item in list) {
        listSelector.add(item);
      }
    } else {
      var textSearch = Util.nonUnicode(textSearchController.text.trim()).toLowerCase();
      for (var item in list) {
        if (Util.nonUnicode(item.title).toLowerCase().contains(textSearch)) {
          listSelector.add(item);
        }
      }
    }
    setState(() {});
  }

  void onResetValue() {
    for (var item in listSelector) {
      item.isCheck = false;
    }
    setState(() {});
  }

  void onSubmit() {
    widget.onSuccess?.call(listSelector);
    Navigator.of(context).pop();
  }

  void onSelect(SelectorModel selectorModel) {
    if (isMultiSelect) {
      Util.onHideKeyboard(context);
      selectorModel.isCheck = !selectorModel.isCheck;
    } else {
      for (var element in listSelector) {
        element.isCheck = false;
      }
      selectorModel.isCheck = !selectorModel.isCheck;
      Util.onHideKeyboard(context);
      widget.onSuccess?.call(list);
      Navigator.of(context).pop();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: Navigator.of(context).pop,
          child: SafeArea(
            child: Container(
              height: 60,
            ),
            bottom: false,
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseAppBarBottomSheetWidget(
                  title: widget.title,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: InputSearchWidget(
                    hintText: "Tìm kiếm",
                    controller: textSearchController,
                    onChanged: onChangeTextSearch,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listSelector.length,
                    itemBuilder: (context, index) {
                      return _childWidget(listSelector[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.isMultiSelect) ...[
          SafeArea(
            bottom: false,
            child: Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 0),
                    blurRadius: 4.0),
              ], color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        title: "Bỏ chọn",
                        buttonType: ButtonType.Cancel,
                        onTap: onResetValue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ButtonWidget(
                        title: "Áp dụng",
                        onTap: onSubmit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ] else
          ...[]
      ],
    );
  }

  Widget _childWidget(SelectorModel selectorModel) {
    bool isCheck = selectorModel.isCheck;
    if (isMultiSelect) {
      return InkWell(
        onTap: () {
          onSelect(selectorModel);
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectorModel.title,
                      style: TextStyle(
                        fontSize: 13,
                        color: isCheck
                            ? Constant.kColorOrangePrimary
                            : Constant.kColorBlackPrimary,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    isCheck
                        ? BaseResourceUtil.icon("ic_check_mark")
                        : BaseResourceUtil.icon("ic_uncheck_mark"),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: LineBaseWidget(),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          onSelect(selectorModel);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Text(
                  selectorModel.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: isCheck
                        ? Constant.kColorOrangePrimary
                        : Constant.kColorBlackPrimary,
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  isCheck
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: Constant.kColorOrangePrimary,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
