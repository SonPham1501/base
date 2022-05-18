import 'package:base/src/Helper/navigator.dart';
import 'package:flutter/material.dart';

abstract class BottomSheetUtil {
  static Future<bool> buildBaseButtonSheet({
    required Widget child,
    bool isScroll = true,
  }) async {
    BuildContext _context = navigationService.context;
    bool? _res = await showModalBottomSheet(
      context: _context,
      useRootNavigator: true,
      isScrollControlled: isScroll,
      builder: (c) => child,
    );
    return _res ?? false;
  }

  static Future<bool> buildRatioButtonSheet({
    required Widget child,
    double ratio = 0.9,
    bool isScroll = true,
  }) async {
    BuildContext _context = navigationService.context;
    bool? _res = await showModalBottomSheet(
      context: _context,
      useRootNavigator: true,
      isScrollControlled: isScroll,
      builder: (c) => SizedBox(
        height: MediaQuery.of(_context).size.height * ratio,
        width: double.infinity,
        child: child,
      ),
    );
    return _res ?? false;
  }
}