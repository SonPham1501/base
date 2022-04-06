import 'package:base/src/Common/Enum.dart';
import 'package:base/src/Widget/LoadingWidget.dart';
import 'package:flutter/material.dart';

class LoadingWithViewStateWidget extends StatelessWidget {
  final Stream<ViewState> viewState;
  final double size;

  const LoadingWithViewStateWidget({Key? key, required this.viewState, this.size = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ViewState?>(
      stream: viewState,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data == ViewState.Loading) {
          return LoadingWidget(size: size,);
        }
        return const SizedBox();
      },
    );
  }
}
