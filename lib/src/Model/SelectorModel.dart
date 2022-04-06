import 'dart:convert';

enum EnumsFilterType { LOAINHADAT, DIENTICH, SOPHONGNGU, SOPHONGTAM, HUONG }

class SelectorModel {
  late String title;
  late String content;
  late bool isCheck;
  dynamic data;
  EnumsFilterType? enumsFilterType;
  late String valueString;
  late int valueInt;
  int? id;
  String? description;

  SelectorModel({this.title = "", this.content = "", this.isCheck = false, this.data, this.valueString = "", this.valueInt = 0, this.id, this.enumsFilterType, this.description});

  SelectorModel.fromJson(dynamic json) {
    title = json["title"];
    content = json["content"];
    isCheck = json["isCheck"];
    data = json["data"];
    valueString = json["valueString"];
    valueInt = json["valueInt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["content"] = content;
    map["isCheck"] = isCheck;
    map["data"] = data;
    map["valueString"] = valueString;
    map["valueInt"] = valueInt;
    return map;
  }

  static selectRadioButton({required List<SelectorModel> listSelector, required SelectorModel selectorModel}) {
    for (var item in listSelector) {
      item.isCheck = item == selectorModel;
    }
  }

  static List<SelectorModel> copyList({required List<SelectorModel> listSelector}) {
    var list = <SelectorModel>[];
    for (var item in listSelector) {
      var json = jsonEncode(item.toJson());
      var map = jsonDecode(json);
      list.add(SelectorModel.fromJson(map));
    }
    return list;
  }

  static List<String> getListValueStringSelector({required List<SelectorModel> listSelector}) {
    var list = <String>[];
    for (var item in listSelector) {
      if (item.isCheck) {
        list.add(item.valueString);
      }
    }
    return list;
  }

  static List<SelectorModel> getListSelected({required List<SelectorModel> listSelector}) {
    var list = <SelectorModel>[];
    for (var item in listSelector) {
      if (item.isCheck) {
        list.add(item);
      }
    }
    return list;
  }

  static List<int> getListValueIntSelector({required List<SelectorModel> listSelector}) {
    var list = <int>[];
    for (var item in listSelector) {
      if (item.isCheck) {
        list.add(item.valueInt);
      }
    }
    return list;
  }

  static SelectorModel? getSelector({required List<SelectorModel> listSelector, required String valueString}) {
    for (var item in listSelector) {
      if (item.valueString == valueString) {
        return item;
      }
    }
    return null;
  }


  static void resetChecked({required List<SelectorModel> listSelector}) {
    for (var item in listSelector) {
      item.isCheck = false;
    }
  }

}
