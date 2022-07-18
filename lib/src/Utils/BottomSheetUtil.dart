import 'package:base/src/Helper/navigator.dart';
import 'package:flutter/material.dart';

abstract class BottomSheetUtil {
  static Future<T?> buildBaseButtonSheet<T>({
    required Widget child,
    bool isScroll = true,
    Color? color,
  }) async {
    BuildContext _context = navigationService.context;
    final T? _res = await showModalBottomSheet(
      context: _context,
      useRootNavigator: true,
      isScrollControlled: isScroll,
      backgroundColor: color,
      builder: (c) => child,
    );
    return _res;
  }

  static Future<T?> buildRatioButtonSheet<T>({
    required Widget child,
    double ratio = 0.9,
    bool isScroll = true,
    Color? color,
  }) async {
    BuildContext _context = navigationService.context;
    final T? _res = await showModalBottomSheet(
      context: _context,
      useRootNavigator: true,
      isScrollControlled: isScroll,
      backgroundColor: color,
      builder: (c) => SizedBox(
        height: MediaQuery.of(_context).size.height * ratio,
        width: double.infinity,
        child: child,
      ),
    );
    return _res;
  }
}