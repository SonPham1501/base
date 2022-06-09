import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Model/SelectorModel.dart';
import 'package:base/src/Utils/BaseResourceUtil.dart';
import 'package:base/src/Widget/ButtonWidget.dart';
import 'package:base/src/Widget/LineBaseWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CupertinoSelectorPopup {
  static show(
    BuildContext context, {
    required List<SelectorModel> listSelector,
    String? title,
    SelectorModel? valueSelector,
    Function(SelectorModel itemSelector)? onSelect,
  }) {
    var indexSelector = 0;
    if (valueSelector != null) {
      for (var i = 0; i < listSelector.length; i++) {
        if (listSelector[i].valueString == valueSelector.valueString) {
          indexSelector = i;
        }
      }
    }
    var scrollController =
        FixedExtentScrollController(initialItem: indexSelector);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.fromLTRB(20, 5, 0, 20),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Constant.kColorBlackPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: Padding(
                        padding: const EdgeInsets.all(3),
                        child: SvgPicture.asset(
                            BaseResourceUtil.icon("ic_close_bottomsheet")),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 8),
                        child: LineBaseWidget(),
                      ),
                      SizedBox(
                        height: 200,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          scrollController: scrollController,
                          onSelectedItemChanged: (int index) {
                            print(listSelector[index].title);
                            indexSelector = index;
                          },
                          children: List<Widget>.generate(listSelector.length,
                              (int index) {
                            return Center(
                              child: Text(
                                listSelector[index].title,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Constant.kColorBlackPrimary,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ButtonWidget(
                          height: 44,
                          buttonType: ButtonType.Normal,
                          onTap: () {
                           Navigator.of(context).pop();
                            //onButtonAction?.call();
                            onSelect?.call(listSelector[indexSelector]);
                          },
                          title: "Chọn",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
