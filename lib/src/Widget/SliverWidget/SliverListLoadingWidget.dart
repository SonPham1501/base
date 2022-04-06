import 'package:flutter/material.dart';

import '../LoadingWidget.dart';

class SliverListLoadingWidget extends StatelessWidget {
  const SliverListLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: LoadingWidget(),
      ),
    );
  }
}
