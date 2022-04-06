import 'package:base/src/Extends/StringExtend.dart';
import 'package:encrypt/encrypt.dart' as en;

class BaseCryptoUtil {
  static String passwordCryptor = "";

  static String encrypt({required String plainText, String? password}) {
    final key = en.Key.fromUtf8(password ?? passwordCryptor);
    final iv = en.IV.fromLength(16);
    final encryptor = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
    final encrypted = encryptor.encrypt(plainText.base64Encode(), iv: iv);
    return encrypted.base64;
  }

  static String decrypt({required String plainText, String? password}) {
    final key = en.Key.fromUtf8(password ?? passwordCryptor);
    final iv = en.IV.fromLength(16);
    final encryptor = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
    return encryptor.decrypt64(plainText, iv: iv);
  }
}
