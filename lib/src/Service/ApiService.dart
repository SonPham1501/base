import 'package:base/src/AppBase.dart';
import 'package:base/src/Helper/HttpHepler.dart';
import 'package:dio/dio.dart' as Dio;

class ApiService {
  static String baseUrl = "https://cenhome-api-sandbox.cenpush.com/";

  static Future<Dio.Response> getUserInfo(String baseUrlCenID) async {
    var action = "connect/userinfo";
    final url = baseUrlCenID + action;
    var params = <String, dynamic>{};
    return HttpHelper.requestApi(url, params, HttpMethod.post, true);
  }
  // static Future<QueryResult> postRegister({Map<String, dynamic>? variables, String? operationName}) async {
  //   return await GraphQLHelper.fetchData(link: CenBase.baseUrWSSRegister, variables: variables, repository: Constant.queries, method: GraphQlMethod.Mutations, operationName: operationName );
  // }

  static getListUpdate(String baseUpdateUrl) async {
    var action = "apps/v1/versions/list";
    final url = baseUpdateUrl + action;
    var params = <String, dynamic>{};
    params["appId"] = AppBase.appId;
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

  // static tracking(Map<String, dynamic> params) async {
  //   var action = "tracking/visitors/collect";
  //   final url = AppBase.baseUrlTracking + action;
  //   return HttpHelper.requestApi(url, params, HttpMethod.get, false, body: true);
  // }
}
