import 'package:badges/badges.dart';
import 'package:base/src/Widget/input/InputSearchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Common/Constant.dart';
import '../../Utils/BaseResourceUtil.dart';

class SliverBoxSearchWidget extends StatelessWidget {
  final int? countFilter;
  final Function? onFilter;
  final Function? onSort;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChangedDeBouncer;

  const SliverBoxSearchWidget(
      {Key? key,
      this.countFilter,
      this.onFilter,
      this.onSort,
      this.hintText = "",
      this.controller,
      this.onChanged,
      this.onSubmitted,
      this.onChangedDeBouncer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      title: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 0,
          bottom: 5,
          top: 6,
        ),
        child: InputSearchWidget(
          hintText: hintText,
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onChangedDeBouncer: onChangedDeBouncer,
          timeDeBouncer: 500,
          borderRadiusBackground: BorderRadius.circular(24),
          backgroundColor: Constant.kColorBackgroundBack,
          autoFocus: false,
          minHeight: 36,
          maxLines: 1,
          icon: IconButton(
            icon: SvgPicture.asset(
              BaseResourceUtil.icon("ic_search.svg"),
              color: const Color(0xFF5E5873),
              height: 16,
              width: 16,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            highlightColor: const Color(0xFF5E5873).withOpacity(0.3),
          ),
          textInputAction: TextInputAction.search,
        ),
      ),
      titleSpacing: 0,
      centerTitle: true,
      // pinned: true,
      floating: true,
      automaticallyImplyLeading: false,
      elevation: 0.5,
      actions: [
        if (onFilter == null || onSort != null)
          const SizedBox(
            width: 8,
          ),
        if (onFilter != null)
          InkWell(
            onTap: () {
              onFilter?.call();
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 10, 4),
              child: countFilter != null
                  ? Badge(
                      position: const BadgePosition(
                        end: -5,
                        top: 12,
                      ),
                      showBadge: (countFilter != null && countFilter! > 0),
                      badgeContent: Text(
                        countFilter!.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.w500),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: SvgPicture.asset(
                        BaseResourceUtil.icon("ic_filter.svg"),
                        color: const Color(0xFF5E5873),
                        height: 22,
                        width: 22,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(3),
                      child: SvgPicture.asset(
                        BaseResourceUtil.icon("ic_filter.svg"),
                        color: const Color(0xFF5E5873),
                        height: 22,
                        width: 22,
                      ),
                    ),
            ),
          ),
        //if (onSort != null) SizedBox(width: 4),
        // if (onFilter != null && onSort != null)
        //   SizedBox(
        //     width: 12,
        //   ),
        if (onSort != null)
          InkWell(
            onTap: () {
              onSort?.call();
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 16, 4),
              child: SvgPicture.asset(
                BaseResourceUtil.icon("ic_sort.svg"),
                height: 15,
                width: 15,
                color: const Color(0xFF5E5873),
              ),
            ),
          ),
        if (onFilter != null || onSort == null)
          const SizedBox(
            width: 4,
          ),
        if (onFilter != null || onSort != null)
          const SizedBox(
            width: 4,
          ),
        if (onFilter == null && onSort == null) const SizedBox(width: 16),
      ],
    );
  }
}
