import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CryptoUtil.dart';

class PreferUtil {
  static String keySecure = "p@123";

  static Future<bool> checkKey(String key, {bool isSecure = false, String? userId}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  //Int

  static Future createInt(String key, int intValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setInt(key, intValue);
    }
  }

  static Future setInt(String key, int intValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, intValue);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key);
    return value;
  }

  //remove
  static Future remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  //Double
  static Future createDouble(String key, double doubleValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setDouble(key, doubleValue);
    }
  }

  static Future setDouble(String key, double doubleValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, doubleValue);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getDouble(key);
    return value;
  }

  //Double
  static Future createBool(String key, bool boolValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setBool(key, boolValue);
    }
  }

  static Future setBool(String key, bool boolValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, boolValue);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(key);
    return value;
  }

  //String
  static Future createString(String key, String stringValue, {bool isSecure = false, String? userId}) async {
    var keyNew = _getKey(key, isSecure: isSecure, userId: userId);
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(keyNew)) {
      var valueNew = _valueEncrypt(key, stringValue, isSecure: isSecure, userId: userId);
      prefs.setString(keyNew, valueNew ?? "");
    }
  }

  static Future setString(String key, String stringValue, {bool isSecure = false, String? userId}) async {
    var keyNew = _getKey(key, isSecure: isSecure, userId: userId);
    final prefs = await SharedPreferences.getInstance();
    var valueNew = _valueEncrypt(key, stringValue, isSecure: isSecure, userId: userId);
    prefs.setString(keyNew, valueNew ?? "");
  }

  static Future<String> getString(String key, {bool isSecure = false, String? userId}) async {
    var keyNew = _getKey(key, isSecure: isSecure, userId: userId);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(keyNew) ?? "";
    var valueNew = _valueDecrypt(key, value, isSecure: isSecure, userId: userId);
    return valueNew ?? "";
  }

  //List String
  static Future createListString(String key, List<String> listStringValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setStringList(key, listStringValue);
    }
  }

  static Future setListString(String key, List<String> listStringValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, listStringValue);
  }

  static Future<List<String>> getListString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getStringList(key) ?? <String>[];
    return value;
  }

  static String _getKey(String key, {bool isSecure = false, String? userId}) {
    if (isSecure) {
      var keyString = "k_$keySecure${userId ?? ""}$key";
      return "s_" + md5.convert(utf8.encode(keyString)).toString();
    }
    return key;
  }

  static String _getKeyCrypt(String key, {String? userId = ""}) {
    var keyString = "$keySecure${userId ?? ""}$key";
    return "k_" + md5.convert(utf8.encode(keyString)).toString();
  }

  static String? _valueEncrypt(String key, String stringValue, {bool isSecure = false, String? userId}) {
    if (isSecure) {
      return CryptoUtil.encryptAESCryptoJS(stringValue, _getKeyCrypt(key, userId: userId));
    }
    return stringValue;
  }

  static String? _valueDecrypt(String key, String stringValue, {bool isSecure = false, String? userId}) {
    if (isSecure) {
      return CryptoUtil.decryptAESCryptoJS(stringValue, _getKeyCrypt(key, userId: userId));
    }
    return stringValue;
  }
}
