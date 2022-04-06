import 'dart:math';

extension DoubleExtend on double {
    /// Làm tròn tới bao nhiêu số thập phân
   double toRound(int places) {
    var mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
  /// Làm tròn từ 5.2000 -> 5.2
  String toStringRound() {
     return toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
   }

}