import 'dart:convert';

import 'SelectorModel.dart';

class GroupSelectorModel {
  late String title;
  late String valueString;
  late int valueInt;
  bool isExpand = false;
  bool isCheck = false;
  var listSelector = <SelectorModel>[];

  GroupSelectorModel(
      {required this.title,
      this.valueString = "",
      this.valueInt = 0,
      this.isCheck = false,
      this.isExpand = false,});

  GroupSelectorModel.fromJson(Map<String, dynamic> json) {
    try {
      title = json["title"];
      valueString = json["valueString"];
      valueInt = json["valueInt"];
      isCheck = json["isCheck"];
      isExpand = json["isExpand"];
      if (json['listSelector'] != null) {
        listSelector = [];
        json['listSelector'].forEach((v) {
          listSelector.add(SelectorModel.fromJson(v));
        });
      }
    } on Exception catch (e) {
      print('eexxxxxxxxx  ' + e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["valueString"] = valueString;
    map["valueInt"] = valueInt;
    map["isCheck"] = isCheck;
    map["isExpand"] = isExpand;
    map["isExpand"] = isExpand;
    map['listSelector'] = listSelector.map((v) => v.toJson()).toList();

    return map;
  }

  static List<GroupSelectorModel> copyList(
      {required List<GroupSelectorModel> listGroupSelector}) {
    var list = <GroupSelectorModel>[];
    // for (var item in listGroupSelector) {
    //   var json = jsonEncode(item.toJson());
    //   var map = jsonDecode(json);
    //   var groupNew = GroupSelectorModel.fromJson(map);
    //   groupNew.listSelector =
    //       SelectorModel.copyList(listSelector: item.listSelector);
    //   list.add(groupNew);
    // }
    var jsonData = jsonEncode(listGroupSelector);
    print('jsonData   ' + jsonData);
    list = (json.decode(jsonData) as List)
        .map((data) => GroupSelectorModel.fromJson(data))
        .toList();
    print('jsonData   ' + jsonEncode(list));

    return list;
  }

  static List<String> getListValueStringGroupSelector(
      {required List<GroupSelectorModel> listGroupSelector}) {
    var list = <String>[];
    for (var group in listGroupSelector) {
      if (group.isCheck) {
        list.add(group.valueString);
      }
      for (var selector in group.listSelector) {
        if (selector.isCheck) {
          list.add(selector.valueString);
        }
      }
    }
    return list;
  }

  static List<String> getListTitleStringGroupSelector(
      {required List<GroupSelectorModel> listGroupSelector}) {
    var list = <String>[];
    for (var group in listGroupSelector) {
      if (group.isCheck) {
        list.add(group.title);
      }
      for (var selector in group.listSelector) {
        if (selector.isCheck) {
          list.add(selector.title);
        }
      }
    }
    return list;
  }
}
