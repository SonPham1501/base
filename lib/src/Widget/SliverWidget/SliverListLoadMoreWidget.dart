
import 'package:flutter/material.dart';

import '../LoadingWidget.dart';

class SliverListLoadMoreWidget extends StatelessWidget {
  final bool loadMore;

  const SliverListLoadMoreWidget({Key? key, required this.loadMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadMore) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
              child: LoadingWidget(
            size: 24,
            strokeWidth: 1,
          )),
        ),
      );
    }
    return const SliverToBoxAdapter();
  }
}
