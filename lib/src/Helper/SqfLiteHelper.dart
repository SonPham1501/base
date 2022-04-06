import 'dart:io';
import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Model/SqliteColumn.dart';
import 'package:CenBase/Model/TempPostUpModel.dart';
import 'package:sqflite/sqflite.dart';

class APiLogModel {
  int? id;
  int? type;
  String? userId;
  String? url;
  String? httpMethod;
  String? param;
  String? timeStartRequest;
  String? timeEndRequest;
  String? responseStatusCode;
  String? response;
  String? header;
  String? contentType;
  String? operationName;
  String? repository;

  APiLogModel(
      {this.userId,
      this.url,
      this.type,
      this.operationName,
      this.repository,
      this.httpMethod,
      this.param,
      this.timeStartRequest,
      this.timeEndRequest,
      this.responseStatusCode,
      this.header,
      this.contentType,
      this.id,
      this.response});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "userId": userId,
      "url": url,
      "type": type,
      "httpMethod": httpMethod,
      "param": param,
      "timeStartRequest": timeStartRequest,
      "timeEndRequest": timeEndRequest,
      "responseStatusCode": responseStatusCode,
      "response": response,
      "header": header,
      "contentType": contentType,
      "operationName": operationName,
      "repository": repository,
    };
    if (id != null) {
      map["rowid"] = id;
    }
    return map;
  }

  APiLogModel.fromMap(Map<String, Object?> map) {
    id = map["rowid"] as int?;
    userId = map["userId"] as String?;
    url = map["url"] as String?;
    type = map["type"] as int?;
    httpMethod = map["httpMethod"] as String?;
    param = map["param"] as String?;
    timeStartRequest = map["timeStartRequest"] as String?;
    timeEndRequest = map["timeEndRequest"] as String?;
    responseStatusCode = map["responseStatusCode"] as String?;
    response = map["response"] as String?;
    header = map["header"] as String?;
    contentType = map["contentType"] as String?;
    operationName = map["operationName"] as String?;
    repository = map["repository"] as String?;
  }

  @override
  String toString() {
//    return type == 1
////        ? ' userId: $userId,\n url: $url,\n httpMethod: $httpMethod,\n header: $header,\n contentType: $contentType,\n param: $param,\n timeStartRequest: $timeStartRequest,\n timeEndRequest: $timeEndRequest,\n '
////            'responseStatusCode: $responseStatusCode,\n response: $response\n ---------------------------------------------------------------------------\n'
////        : " userId: $userId,\n url: $url,\n header: $header,\n token: $contentType,\n operationName: $operationName,\n repository: $repository,\n method: $httpMethod,\n variables: $param,\n timeStartRequest: $timeStartRequest,\n timeEndRequest: $timeEndRequest,\n response: $response\n ---------------------------------------------------------------------------\n";
    return "$url$repository$httpMethod$param$timeStartRequest$timeEndRequest$response";
  }
}

class SqfLiteHelper {
  static Database? db;
  static Database? postUpDb;

  static Future<String> get localPath async {
    var databasesPath = await getDatabasesPath();
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}
    String path = ("$databasesPath${Constant.kDatabase}");
    return path;
  }

  static Future<String> get postUpPath async {
    var databasesPath = await getDatabasesPath();
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}
    String path = ("$databasesPath${Constant.kPostUpDatabase}");
    return path;
  }

  static Future<int> creatTable() async {
    try {
      var path = await localPath;
      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE ${Constant.kTableDatabase} (rowid INTEGER PRIMARY KEY autoincrement, userId TEXT, url TEXT, httpMethod TEXT, param TEXT, timeStartRequest TEXT, timeEndRequest TEXT, responseStatusCode TEXT, response TEXT, type INTEGER, header TEXT, contentType TEXT, operationName TEXT, repository TEXT)');
      });
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrr  creat ' + e.toString());
    }
    return 0;
  }

  static Future<bool> insert(APiLogModel aPiLogModel) async {
    try {
      aPiLogModel.id =
          await db?.insert(Constant.kTableDatabase, aPiLogModel.toMap());
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrr  ' + e.toString());

      return false;
    }
    return true;
  }

  static Future<List<APiLogModel>> getListApiLog() async {
    List<APiLogModel> list = [];
    List<Map<String, Object?>> maps = await db!.query(
      Constant.kTableDatabase,
//
    );
    if (maps.length > 0) {
      list = maps.map((e) => APiLogModel.fromMap(e)).toList();
    }

    return list;
  }

  static Future<List<APiLogModel>> getListLogByType(int id) async {
    List<APiLogModel> list = [];
    if (db!.isOpen) {
      List<Map<String, Object?>> maps = await db!.query(
        Constant.kTableDatabase,
        where: 'type = $id',
//
      );
      if (maps.length > 0) {
        list = maps.map((e) => APiLogModel.fromMap(e)).toList();
      }
    }
    return list;
  }

  static Future<int?> delete() async {
    return await db?.delete(Constant.kTableDatabase);
  }

  static Future<bool> openDB() async {
    try {
      var path = await localPath;
      db = await openDatabase(path);
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future close() async => db?.close();

  static Future closePostUp() async => postUpDb?.close();

  static Future<int> creatPostUpTable() async {
    try {
      var path = await postUpPath;
      postUpDb = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        var listQuey = TempPostUpModel.generateListColumnDb();
        String query = SqliteColumn.generateCrateTable(
            Constant.kPostUpTableDatabase, listQuey);
        await db.execute(query);
      });
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrr  creat ' + e.toString());
    }
    return 0;
  }

  static Future<bool> insertPostUp(TempPostUpModel tempPostUpModel) async {
    try {
      tempPostUpModel.id = await postUpDb?.insert(
          Constant.kPostUpTableDatabase, tempPostUpModel.toMap());
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrr insert ' + e.toString());
      return false;
    }
    return true;
  }

  static Future<List<TempPostUpModel>> getListSavePostUp() async {
    await creatPostUpTable();
    List<TempPostUpModel> list = [];
    List<Map<String, dynamic>> maps = await postUpDb!
        .query(Constant.kPostUpTableDatabase, orderBy: "$columnCreatedDate DESC"
//
            );
    if (maps.length > 0) {
      list = maps.map((e) => TempPostUpModel.fromMap(e)).toList();
    }
    return list;
  }

  static Future<TempPostUpModel?> getRecentPostUp() async {
    TempPostUpModel tempPostUpModel;
    try {
      List<Map<String, dynamic>> maps = await postUpDb!.query(
        Constant.kPostUpTableDatabase,
        //
      );
      if (maps.length > 0) {
        tempPostUpModel =
            maps.map((e) => TempPostUpModel.fromMap(e)).toList().last;
        return tempPostUpModel;
      }
    } on Exception catch (e) {
      print('errrrrrrrrrrrrrrrrrr get ' + e.toString());
    }
    return null;
  }

  static Future<TempPostUpModel?> getRecentPostUpByType(int type) async {
    TempPostUpModel tempPostUpModel;
    try {
      List<Map<String, dynamic>> maps = await postUpDb!.query(
          Constant.kPostUpTableDatabase,
          where: '$columnTypePostUp = $type'
          //
          );
      if (maps.length > 0) {
        tempPostUpModel =
            maps.map((e) => TempPostUpModel.fromMap(e)).toList().last;
        return tempPostUpModel;
      }
    } on Exception catch (e) {
      print('errrrrrrrrrrrrrrrrrr get ' + e.toString());
    }
    return null;
  }

  static deleteRecentPostUp(int id) async {
    try {
      var count = await postUpDb?.rawDelete(
          'DELETE FROM ${Constant.kPostUpTableDatabase} WHERE $columnId = $id');
    } on Exception catch (e) {
      print('errrrrrrrrrrrrrrrrrr del ' + e.toString());
    }
  }

  static Future<void> updatePostUp(TempPostUpModel tempPostUpModel) async {
    try {
      await postUpDb!.update(
          Constant.kPostUpTableDatabase, tempPostUpModel.toMap(),
          where: '$columnId = ${tempPostUpModel.id}');
    } on Exception catch (e) {
      print('errrrrrrrrrr update ' + e.toString());
    }
  }

  static Future<int> getCountSavedPostUp() async {
    try {
      int? count = Sqflite.firstIntValue(await postUpDb!
          .rawQuery('SELECT COUNT(*) FROM ${Constant.kPostUpTableDatabase}'));
      return count!;
    } on Exception catch (e) {
      print('errrrrrrrrrrrrrrrrrr getCount ' + e.toString());
      return 0;
    }
  }
}
