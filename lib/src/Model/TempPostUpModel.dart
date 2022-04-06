import 'dart:convert';

import '../Extends/SqliteExtend.dart';
import 'GroupSelectorModel.dart';
import 'ProjectModel.dart';

const String columnId = '_id';
const String columnCreatedDate = 'createdDate';
const String columnCurrentStep = 'currentStep';
const String columnStep2 = 'step2';
const String columnTypePostUp = 'type';
const String columnStep3 = 'step3';
const String columnStep4 = 'step4';
const String columnStep5 = 'step5';
const String columnStep6 = 'step5_2';
const String columnStep7 = 'step5_3';
const String columnStep8 = 'step6';
const String columnStep9 = 'step7';
const String columnStep10 = 'step8';
const String columnStep11 = 'step9';

class TempPostUpModel {
  int? id;
  String? createdDate;
  int? currentStep;
  int? typePost;
  List<GroupSelectorModel>? groupSelectorModel;
  ProjectModel? projectModel;
  List<double>? latlng;
  Step5_1Model? step5_1model;
  Step5_2Model? step5_2model;
  List<FloorDetail>? listFloor;
  List<MediaImage>? mediaList;
  List<String>? step7Content;
  Step8Model? step8model;
  Step9Model? step9model;

  TempPostUpModel(
      {this.id,
      this.createdDate,
      this.currentStep,
      this.groupSelectorModel,
      this.typePost,
      this.projectModel,
      this.latlng,
      this.step5_1model,
      this.step5_2model,
      this.step7Content,
      this.step8model, this.step9model});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnCreatedDate: createdDate,
      columnCurrentStep: currentStep,
      columnTypePostUp: typePost,
      columnStep2:
          groupSelectorModel == null ? null : json.encode(groupSelectorModel),
      columnStep3: projectModel == null ? null : json.encode(projectModel),
      columnStep4: latlng,
      columnStep5: step5_1model == null ? null : jsonEncode(step5_1model),
      columnStep6: step5_2model == null ? null : jsonEncode(step5_2model),
      columnStep7: listFloor == null ? null : json.encode(listFloor),
      columnStep8: mediaList == null ? null : json.encode(mediaList),
      columnStep9: step7Content == null ? null : json.encode(step7Content),
      columnStep10: step8model == null ? null : json.encode(step8model),
      columnStep11: step9model == null ? null : json.encode(step9model),
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  TempPostUpModel.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    createdDate = map[columnCreatedDate];
    currentStep = map[columnCurrentStep];
    typePost = map[columnTypePostUp];
    if (map[columnStep2] != null) {
      Iterable l = json.decode(map[columnStep2]);

      groupSelectorModel = map[columnStep2] == null
          ? null
          : List<GroupSelectorModel>.from(
          l.map((model) => GroupSelectorModel.fromJson(model)));
    }
    projectModel = map[columnStep3] == null
        ? null
        : (ProjectModel.fromJson(jsonDecode(map[columnStep3])));

    latlng = map[columnStep4] == null ? null : map[columnStep4].cast<double>();

    step5_1model = map[columnStep5] == null
        ? null
        : (Step5_1Model.fromJson(jsonDecode(map[columnStep5])));

    step5_2model = map[columnStep6] == null
        ? null
        : (Step5_2Model.fromJson(jsonDecode(map[columnStep6])));

    if (map[columnStep7] != null) {
      Iterable lStep7 = json.decode(map[columnStep7]);
      listFloor = map[columnStep7] == null
          ? null
          : List<FloorDetail>.from(
              lStep7.map((model) => FloorDetail.fromJson(model)));
    }
    if (map[columnStep8] != null) {
      Iterable lStep8 = json.decode(map[columnStep8]);
      mediaList = map[columnStep8] == null
          ? null
          : List<MediaImage>.from(
              lStep8.map((model) => MediaImage.fromJson(model)));
    }
    step7Content = map[columnStep9] == null
        ? null
        : (jsonDecode(map[columnStep9]) as List<dynamic>).cast<String>();

    step8model = map[columnStep10] == null
        ? null
        : (Step8Model.fromJson(jsonDecode(map[columnStep10])));

    step9model = map[columnStep11] == null
        ? null
        : (Step9Model.fromJson(jsonDecode(map[columnStep11])));
  }

  static List<SqliteColumn> generateListColumnDb() {
    var list = <SqliteColumn>[];
    list.add(SqliteColumn(
        columnName: columnId,
        dataType: SqliteDataType.int,
        primaryKey: true,
        autoincrement: true));
    list.add(SqliteColumn(
        columnName: columnCreatedDate, dataType: SqliteDataType.text));
    list.add(SqliteColumn(
        columnName: columnTypePostUp, dataType: SqliteDataType.int));
    list.add(SqliteColumn(
        columnName: columnCurrentStep, dataType: SqliteDataType.int));
    list.add(
        SqliteColumn(columnName: columnStep2, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep3, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep4, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep5, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep6, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep7, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep8, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep9, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep10, dataType: SqliteDataType.text));
    list.add(
        SqliteColumn(columnName: columnStep11, dataType: SqliteDataType.text));
    return list;
  }

  @override
  String toString() {
    return 'TempPostUpModel{id: $id, createdDate: $createdDate, currentStep: $currentStep, groupSelectorModel: $groupSelectorModel}';
  }

  Object? myDateSerializer(object) {
    if (object is DateTime) {
      return object.toIso8601String();
    }
    return object;
  }
}

class Step5_1Model {
  String? area;
  int? bedroom;
  int? bathroom;
  String? furnitureStatus;
  String? direction;
  String? facadeCount;
  String? balconyDirection;
  String? legalPaper;
  String? road;
  String? width;
  String? depth;
  String? shape;
  String? propertyType;

  Step5_1Model(
      {this.area,
      this.bedroom,
      this.bathroom,
      this.furnitureStatus,
      this.direction,
      this.facadeCount,
      this.balconyDirection,
      this.legalPaper,
      this.road,
      this.width,
      this.depth,
      this.shape,
      this.propertyType});

  Step5_1Model.fromJson(dynamic json) {
    area = json["area"];
    bedroom = json["bedroom"];
    bathroom = json["bathroom"];
    furnitureStatus = json["furnitureStatus"];
    direction = json["direction"];
    facadeCount = json["facadeCount"];
    balconyDirection = json["balconyDirection"];
    legalPaper = json["legalPaper"];
    road = json["road"];
    width = json["width"];
    depth = json["depth"];
    shape = json["shape"];
    propertyType = json["propertyType"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["area"] = area;
    map["bedroom"] = bedroom;
    map["bathroom"] = bathroom;
    map["furnitureStatus"] = furnitureStatus;
    map["direction"] = direction;
    map["facadeCount"] = facadeCount;
    map["balconyDirection"] = balconyDirection;
    map["legalPaper"] = legalPaper;
    map["road"] = road;
    map["width"] = width;
    map["depth"] = depth;
    map["shape"] = shape;
    map["propertyType"] = propertyType;
    return map;
  }
}

class Step5_2Model {
  String? propertyArea;
  String? propertyScope;
  String? propertyWidth;
  String? propertyDepth;
  int? floorCount;
  String? buildTime;
  String? quality;
  String? propertyDirection;
  String? floorUnderGround;

  Step5_2Model(
      {this.propertyArea,
      this.propertyScope,
      this.propertyWidth,
      this.propertyDepth,
      this.floorCount,
      this.buildTime,
      this.quality,
      this.propertyDirection,
      this.floorUnderGround});

  Step5_2Model.fromJson(dynamic json) {
    propertyArea = json["propertyArea"];
    propertyScope = json["propertyScope"];
    propertyWidth = json["propertyWidth"];
    propertyDepth = json["propertyDepth"];
    floorCount = json["floorCount"];
    buildTime = json["buildTime"];
    quality = json["quality"];
    propertyDirection = json["propertyDirection"];
    floorUnderGround = json["floorUnderGround"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["propertyArea"] = propertyArea;
    map["propertyScope"] = propertyScope;
    map["propertyWidth"] = propertyWidth;
    map["propertyDepth"] = propertyDepth;
    map["floorCount"] = floorCount;
    map["buildTime"] = buildTime;
    map["quality"] = quality;
    map["propertyDirection"] = propertyDirection;
    map["floorUnderGround"] = floorUnderGround;
    return map;
  }
}

class FloorDetail {
  int? floorNumber;
  int? living;
  int? kitchen;
  int? bedroom;
  int? bathroom;
  int? dryingYard;
  bool isExpand = false;

  FloorDetail(
      {this.floorNumber,
      this.living,
      this.kitchen,
      this.bedroom,
      this.bathroom,
      this.dryingYard});

  FloorDetail.fromJson(dynamic json) {
    floorNumber = json["floorNumber"];
    living = json["living"];
    kitchen = json["kitchen"];
    bedroom = json["bedroom"];
    bathroom = json["bathroom"];
    dryingYard = json["dryingYard"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["floorNumber"] = floorNumber;
    map["living"] = living;
    map["kitchen"] = kitchen;
    map["bedroom"] = bedroom;
    map["bathroom"] = bathroom;
    map["dryingYard"] = dryingYard;
    return map;
  }
}

class MediaImage {
  MediaImage({this.url, this.note, this.type});

  String? url;
  String? note;
  int? type;

  factory MediaImage.fromJson(Map<String, dynamic> json) => MediaImage(
        url: json["url"],
        note: json["note"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "note": note,
        "type": type,
      };
}

class Step8Model {
  double? price;
  String? unitPrice;
  String? negotiate;
  String? feeBearer;
  String? period;
  String? payFrequency;
  String? urgentScope;

  Step8Model(
      {this.price,
      this.unitPrice,
      this.negotiate,
      this.feeBearer,
      this.period,
      this.payFrequency,
      this.urgentScope});

  Map<String, dynamic> toJson() => {
        "price": price,
        "unitPrice": unitPrice,
        "negotiate": negotiate,
        "feeBearer": feeBearer,
        "period": period,
        "payFrequency": payFrequency,
        "urgentScope": urgentScope,
      };

  Step8Model.fromJson(dynamic json) {
    price = json["price"];
    unitPrice = json["unitPrice"];
    negotiate = json["negotiate"];
    feeBearer = json["feeBearer"];
    period = json["period"];
    payFrequency = json["payFrequency"];
    urgentScope = json["urgentScope"];
  }
}

class Step9Model {
  String? contactFullName;
  String? contactPhone;
  String? contactAppointment;

  Step9Model({this.contactFullName, this.contactPhone, this.contactAppointment});

  Map<String, dynamic> toJson() => {
        "contactFullName": contactFullName,
        "contactPhone": contactPhone,
        "contactAppointment":
            contactAppointment,
      };

  Step9Model.fromJson(dynamic json) {
    contactFullName = json["contactFullName"];
    contactPhone = json["contactPhone"];
    contactAppointment = json["contactAppointment"] == null
        ? null
        : (json["contactAppointment"]);
  }
}
