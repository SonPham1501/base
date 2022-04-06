import 'package:flutter/material.dart';

class BaseResourceUtil {
  static var pathResource = "assets/";

  static image(String name) {
    if (name.contains(".")) {
      return pathResource + "images/" + name;
    }
    return pathResource + "images/" + name + ".png";
  }

  static icon(String name) {
    if (name.contains(".")) {
      return pathResource + "icons/" + name;
    }
    return pathResource + "icons/" + name + ".svg";
  }
}
