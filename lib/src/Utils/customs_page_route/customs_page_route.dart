import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CustomMaterialPageRoute extends MaterialPageRoute {

  final AsyncCallback? willPopScopeCallBack;

  @override
  @protected
  bool get hasScopedWillPopCallback {
    if (willPopScopeCallBack != null) willPopScopeCallBack!();
    return true;
  }

  CustomMaterialPageRoute({
    this.willPopScopeCallBack,
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false
  }) : super(
    builder: builder,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  );
}
