import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Model/SelectorModel.dart';
import 'package:CenBase/Utils/BaseResourceUtil.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:CenBase/Widget/BaseAppBarBottomSheetWidget.dart';
import 'package:CenBase/Widget/ButtonWidget.dart';
import 'package:CenBase/Widget/InputSearchWidget.dart';
import 'package:CenBase/Widget/LineBaseWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'BottomSheetSelectorController.dart';

// ignore: must_be_immutable
class BottomSheetSelector extends StatelessWidget {
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
    // Get.bottomSheet(
    //   BottomSheetSelector(
    //     title: title,
    //     list: SelectorModel.copyList(listSelector: listSelector),
    //     isMultiSelect: isMultiSelect,
    //     onSuccess: onSuccess,
    //   ),
    //   isScrollControlled: true,
    // );
  }

  late BottomSheetSelectorController controller;
  final List<SelectorModel> list;
  final String? title;
  final bool isMultiSelect;
  final Function(List<SelectorModel> list)? onSuccess;

  BottomSheetSelector({
    Key? key,
    this.onSuccess,
    required this.list,
    this.title,
    this.isMultiSelect = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomSheetSelectorController(
        context,
        isMultiSelect: isMultiSelect,
        list: list,
        onSuccess: onSuccess,
      ),
      child: Consumer<BottomSheetSelectorController>(
        builder: (context, value, child) {
          controller = Provider.of<BottomSheetSelectorController>(context);
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
                  decoration: BoxDecoration(
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
                        title: title,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: InputSearchWidget(
                          hintText: "Tìm kiếm",
                          controller: value.textSearchController,
                          onChanged: controller.onChangeTextSearch,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: value.listSelector.length,
                          itemBuilder: (context, index) {
                            return _childWidget(
                                value, value.listSelector[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isMultiSelect) ...[
                SafeArea(
                  bottom: false,
                  child: Container(
                    decoration: BoxDecoration(boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 0),
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
                              onTap: () {
                                controller.onResetValue();
                              },
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: ButtonWidget(
                              title: "Áp dụng",
                              onTap: () {
                                controller.onSubmit();
                              },
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
        },
      ),
    );
  }

  Widget _childWidget(
      BottomSheetSelectorController value, SelectorModel selectorModel) {
    bool isCheck = selectorModel.isCheck;
    if (value.isMultiSelect) {
      return InkWell(
        onTap: () {
          controller.onSelect(selectorModel);
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
                        fontFamily: FontUtil.regular,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: LineBaseWidget(),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          controller.onSelect(selectorModel);
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Text(
                  selectorModel.title,
                  style: TextStyle(
                    fontFamily: FontUtil.regular,
                    fontSize: 14,
                    color: isCheck
                        ? Constant.kColorOrangePrimary
                        : Constant.kColorBlackPrimary,
                  ),
                )),
                SizedBox(
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
