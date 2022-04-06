import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
