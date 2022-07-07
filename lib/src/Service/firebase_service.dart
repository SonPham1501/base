import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';

import '../../base.dart';

class FirebaseService {
  static final _db = FirebaseDatabase.instance.ref();

  static Future insert({required String userName, required LogError logError}) async {
    try {
      String date = DateTimeUtil.dateTimeToString(DateTime.now(), 'dd-MM-yyyy') ?? 'No DATE';
      String time = DateTime.now().toString().split(' ').last;
      await _db.child(userName).child(date).child(time).set(logError.toJson());
    } catch (e) {
      log("--------------- Error insert firebase: ${e.toString()} -----------------------");
    }
  }

}