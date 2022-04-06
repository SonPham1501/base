import 'package:CenBase/CenBase.dart';
import 'package:dio/dio.dart';

class TokenHelper {
  static Future<bool> getAccessTokenInRefreshToken() async {
    var dio = new Dio();
    var headers = Map<String, dynamic>();
    var url = "${CenBase.baseUrlCenID}connect/token";
    Response response;
    Options options = Options(
      headers: headers,
      followRedirects: false,
      contentType: Headers.formUrlEncodedContentType,
      validateStatus: (status) {
        return true;
      },
    );

    dio.options.connectTimeout = 30000; //5s
    dio.options.receiveTimeout = 30000;
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
    response = await dio.post(
      url,
      data: {
        "grant_type": "refresh_token",
        "client_id": CenBase.clientID,
        "client_secret": CenBase.clientSecret,
        "refresh_token": CenBase.refreshToken,
      },
      options: options,
    );
    if (response.statusCode == 200) {
      String? accessToken = response.data["access_token"];
      if (accessToken != null && accessToken.isNotEmpty) {
        accessToken = "Bearer $accessToken";
        CenBase.accessToken = accessToken;
        CenBase.onAccessTokenNew?.call();
        return Future.value(true);
      }
    }
    return Future.value(false);
  }

  static Future<bool> getSystemToken() async {
    var dio = new Dio();
    var headers = Map<String, dynamic>();
    var url = "${CenBase.baseUrlCenID}connect/token";
    Response response;
    Options options = Options(
      headers: headers,
      followRedirects: false,
      contentType: Headers.formUrlEncodedContentType,
      validateStatus: (status) {
        return true;
      },
    );

    dio.options.connectTimeout = 30000; //5s
    dio.options.receiveTimeout = 30000;
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
    response = await dio.post(
      url,
      data: {
        "grant_type": "client_credentials",
        "client_id": CenBase.clientID,
        "client_secret": CenBase.clientSecret,
      },
      options: options,
    );
    if (response.statusCode == 200) {
      String? accessToken = response.data["access_token"];
      if (accessToken != null && accessToken.isNotEmpty) {
        accessToken = "Bearer $accessToken";
        CenBase.systemToken = accessToken;
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
}
