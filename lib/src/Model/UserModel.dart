// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromJson(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.gender,
    this.picture,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.phoneCode,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.rc,
    this.vc,
    this.version,
    this.versionUid,
    this.role,
    this.sub,
  });

  String? gender;
  String? picture;
  String? username;
  String? fullName;
  String? phoneNumber;
  String? phoneCode;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  String? rc;
  String? vc;
  String? version;
  String? versionUid;
  List<String>? role;
  String? sub;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var roleObj = json["role"];
    var role = <String>[];
    if (roleObj != null && roleObj is String) {
      role.add(roleObj);
    }
    if (roleObj != null && roleObj is List) {
      for (var item in roleObj) {
        role.add(item.toString());
      }
    }

    return UserModel(
      gender: json["gender"] == null ? null : json["gender"],
      picture: json["picture"] == null ? null : json["picture"],
      username: json["username"] == null ? null : json["username"],
      fullName: json["fullName"] == null ? null : json["fullName"],
      phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
      phoneCode: json["phoneCode"] == null ? null : json["phoneCode"],
      email: json["email"] == null ? null : json["email"],
      firstName: json["firstName"] == null ? null : json["firstName"],
      lastName: json["lastName"] == null ? null : json["lastName"],
      avatar: json["avatar"] == null ? null : json["avatar"],
      rc: json["rc"] == null ? null : json["rc"],
      vc: json["vc"] == null ? null : json["vc"],
      version: json["version"] == null ? null : json["version"],
      versionUid: json["version_uid"] == null ? null : json["version_uid"],
      role: role,
      sub: json["sub"] == null ? null : json["sub"],
    );
  }

  Map<String, dynamic> toJson() => {
        "gender": gender == null ? null : gender,
        "picture": picture == null ? null : picture,
        "username": username == null ? null : username,
        "fullName": fullName == null ? null : fullName,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "phoneCode": phoneCode == null ? null : phoneCode,
        "email": email == null ? null : email,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "avatar": avatar == null ? null : avatar,
        "rc": rc == null ? null : rc,
        "vc": vc == null ? null : vc,
        "version": version == null ? null : version,
        "version_uid": versionUid == null ? null : versionUid,
        "role": role == null ? null : role,
        "sub": sub == null ? null : sub,
      };
}
