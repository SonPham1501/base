class GetProjectModel {
  Error? error;
  List<ProjectModel>? data;

  GetProjectModel({this.error, this.data});

  GetProjectModel.fromJson(dynamic json) {
    error = json["error"] != null ? Error.fromJson(json["error"]) : null;
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(ProjectModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (error != null) {
      map["error"] = error?.toJson();
    }
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProjectModel {
  String? key;
  int? docCount;
  int? provinceId;
  int? districtId;
  String? districtName;
  String? provinceName;
  String? streetName;
  String? wardName;
  int? wardId;
  int? streetId;
  String? address;
  int? projectId;
  String? projectName;
  dynamic? locationCenter;

  ProjectModel(
      {this.key,
        this.docCount,
        this.provinceId,
        this.districtId,
        this.wardId,
        this.streetId,
        this.projectId,
        this.projectName,
        this.locationCenter});

  ProjectModel.fromJson(dynamic json) {
    key = json["key"];
    docCount = json["docCount"];
    provinceId = json["provinceId"];
    districtId = json["districtId"];
    wardId = json["wardId"];
    streetId = json["streetId"];
    address = json["address"];
    projectId = json["projectId"];
    projectName = json["projectName"];
    locationCenter = json["locationCenter"];
    districtName = json["districtName"];
    provinceName = json["provinceName"];
    streetName = json["streetName"];
    wardName = json["wardName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["key"] = key;
    map["docCount"] = docCount;
    map["provinceId"] = provinceId;
    map["districtId"] = districtId;
    map["wardId"] = wardId;
    map["streetId"] = streetId;
    map["address"] = address;
    map["projectId"] = projectId;
    map["projectName"] = projectName;
    map["locationCenter"] = locationCenter;
    map["districtName"] = districtName;
    map["provinceName"] = provinceName;
    map["streetName"] = streetName;
    map["wardName"] = wardName;
    return map;
  }
}

class Error {
  bool? status;
  String? message;

  Error({this.status, this.message});

  Error.fromJson(dynamic json) {
    status = json["status"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["message"] = message;
    return map;
  }
}
