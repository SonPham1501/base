import 'dart:io';

import 'package:CenBase/CenBase.dart';
import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Helper/GraphQLHelper.dart';
import 'package:CenBase/Helper/HttpHepler.dart';
import 'package:CenBase/Utils/BaseProjectUtil.dart';
import 'package:FlutterBase/Utils/Util.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiService {
  static String baseUrl = "https://cenhome-api-sandbox.cenpush.com/";

  static Future<Dio.Response> getUserInfo() async {
    var action = "connect/userinfo";
    final url = CenBase.baseUrlCenID + action;
    var params = Map<String, dynamic>();
    return HttpHelper.requestApi(url, params, HttpMethod.post, true);
  }
  // static Future<QueryResult> postRegister({Map<String, dynamic>? variables, String? operationName}) async {
  //   return await GraphQLHelper.fetchData(link: CenBase.baseUrWSSRegister, variables: variables, repository: Constant.queries, method: GraphQlMethod.Mutations, operationName: operationName );
  // }

  static getListUpdate() async {
    var action = "apps/v1/versions/list";
    final url = CenBase.baseUpdateUrl + action;
    var params = new Map<String, dynamic>();
    params["appId"] = CenBase.appId;
    params["page"] = 1;
    params["limit"] = 1000;
    return HttpHelper.requestApi(url, params, HttpMethod.post, false, body: true);
  }
  // static uploadFile({
  //   required List<File> listFile,
  // }) async {
  //   var action = "common/v1/upload-files";
  //   final url = ApiService.baseUrl + action;
  //   return HttpHelper.uploadMultiImage(url: url, listFile: listFile);
  // }

  static tracking(Map<String, dynamic> params) async {
    var action = "tracking/visitors/collect";
    final url = CenBase.baseUrlTracking + action;
    return HttpHelper.requestApi(url, params, HttpMethod.get, false, body: true);
  }
}
