import 'package:base/base.dart';
import 'package:flutter/material.dart';


final NavigationService navigationService = locator<NavigationService>();
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void pop({Object? result}) => navigatorKey.currentState!.pop(result);

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigatePushAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  BuildContext get context {
    return navigatorKey.currentState!.overlay!.context;
  }
}