// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);

import 'dart:convert';

import 'UserModel.dart';


LoginModel loginModelFromMap(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.idToken,
    this.accessToken,
    this.expiresIn,
    this.tokenType,
    this.refreshToken,
    this.scope,
    this.user
  });

  String? idToken;
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? refreshToken;
  String? scope;
  UserModel? user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    idToken: json["id_token"] ?? null,
    accessToken: json["access_token"] ?? null,
    expiresIn: json["expires_in"] ?? null,
    tokenType: json["token_type"] ?? null,
    refreshToken: json["refresh_token"] ?? null,
    scope: json["scope"] ?? null,
    user : json['user'] != null ? UserModel.fromJson(json['user']) : null,
  );

  Map<String, dynamic> toJson() => {
    "id_token": idToken ?? null,
    "access_token": accessToken ?? null,
    "expires_in": expiresIn ?? null,
    "token_type": tokenType ?? null,
    "refresh_token": refreshToken ?? null,
    "scope": scope ?? null,
    "user": user ?? null,
  };
}
