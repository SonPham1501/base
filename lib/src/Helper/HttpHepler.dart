import 'dart:io';
import 'package:CenBase/Helper/LogHelper.dart';
import 'package:CenBase/Helper/TrackingHelper.dart';

import 'package:CenBase/CenBase.dart';
import 'package:CenBase/Helper/TokenHelper.dart';
import 'package:CenBase/Utils/DialogUtil.dart';
import 'package:FlutterBase/Utils/Util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart' as mime;

enum HttpMethod { get, post, delete, put, patch }

int timeOut = 30000;

class HttpHelper {
  static Future<Response> requestApi(
    String url,
    dynamic params,
    HttpMethod httpMethod,
    bool auth, {
    bool body = true,
    int countRequest = 1,
    bool isLoading = false,
    Map<String, dynamic>? headers,
    bool isTokenSystem = false,
  }) async {
    Response? response;
    Options options;
    var dio = new Dio();
    dio.options.connectTimeout = timeOut; //5s
    dio.options.receiveTimeout = timeOut;
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }

    // creatFile
    var text = "";
    var time = DateTimeUtil.getFullDateAndTimeSecond(DateTime.now());
    var timeStart = DateTime.now();
    if (headers == null) {
      headers = new Map<String, dynamic>();
    }

    if (auth) {
      if (url.contains("https://srv.cenhomes.vn/12312323")) {
        headers["Authorization"] = "Bearer 334EE83061B6B5237ED12E11960BCC3F9D2000B214185161AE1B5CFFBF1DBCA5";
      } else {
        headers["Authorization"] = CenBase.accessToken;
      }
    } else if (isTokenSystem) {
      if (CenBase.systemToken == null) {
        var isGetAccessTokenSuccess = await TokenHelper.getSystemToken();
        if (!isGetAccessTokenSuccess) {
          Util.showToast("Lỗi mạng, Vui lòng thực hiện lại");
          response = Response(requestOptions: RequestOptions(path: ""), statusCode: 696969);
          return Future.value(response);
        }
      }
      headers["Authorization"] = CenBase.systemToken;
      //headers["typeeeeee"] = 'client_credentials';
    } else {}
    //header
    headers["client"] = "mobile_app";
    headers["platform"] = TrackingHelper.platform;
    headers["appVersion"] = TrackingHelper.appVersion;
    headers["deviceInfo"] = TrackingHelper.deviceInfo;

    if (body) {
      options = Options(
        headers: headers,
        contentType: Headers.jsonContentType,
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      );
    } else {
      options = Options(
        headers: headers,
        contentType: Headers.formUrlEncodedContentType,
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      );
    }
    if (isLoading) {
      DialogUtil.showLoading();
    }

    try {
      ///GET
      if (httpMethod == HttpMethod.get) {
        response = await dio.get(
          url,
          queryParameters: params,
          options: options,
        );
      }

      ///POST
      if (httpMethod == HttpMethod.post) {
        response = await dio.post(
          url,
          data: params,
          options: options,
        );
      }

      ///PUT
      if (httpMethod == HttpMethod.put) {
        response = await dio.put(
          url,
          data: params,
          options: options,
        );
      }

      ///DELETE
      if (httpMethod == HttpMethod.delete) {
        response = await dio.delete(
          url,
          data: params,
          options: options,
        );
      }

      ///PATCH
      if (httpMethod == HttpMethod.patch) {
        response = await dio.patch(
          url,
          data: params,
          options: options,
        );
      }
    } catch (ex) {
      debugPrint("=======Lỗi try catch api=====");
      debugPrint(ex.toString());
      response = Response(requestOptions: RequestOptions(path: ""), statusCode: 696969);
    }
    // text += "url: $url \n";
    // text += "httpMethod: $httpMethod \n";
    // text += "param: $params \n";
    // text += "header: ${options.headers.toString()} \n";
    // text += "contentType: ${options.contentType} \n";
    // text += "timeStartRequest: $time \n";
    // var timeEnd = DateTime.now();
    // final difference = timeEnd.difference(timeStart).inMilliseconds;
    // text += "RequestTime: $difference \n";
    // text += "responseStatusCode: ${response?.statusCode.toString()} \n";
    // text += "response: $response";
    // LogHelper.saveLog(text, timeStart: timeStart, logType: EnumLogType.api);
    if (response == null || response.statusCode == null) {
      Util.showToast("Lỗi mạng, Vui lòng thực hiện lại");
      response = Response(requestOptions: RequestOptions(path: ""), statusCode: 696969);
    }
    if (response.statusCode != null && response.statusCode == 401 && auth) {
      var isGetAccessTokenSuccess = false;
      if (auth) {
        isGetAccessTokenSuccess = await TokenHelper.getAccessTokenInRefreshToken();
      } // } else {
      //   isGetAccessTokenSuccess = await TokenHelper.getSystemToken();
      // }
      if (isGetAccessTokenSuccess) {
        if (countRequest < 2) {
          response = await requestApi(url, params, httpMethod, auth, body: body, countRequest: countRequest + 1);
        }
      } else {
        CenBase.accessToken = null;
        CenBase.refreshToken = null;
        CenBase.systemToken = null;
        CenBase.logout?.call();
      }
    } else if (response.statusCode != null && response.statusCode == 401 && isTokenSystem) {
      var isGetAccessTokenSuccess = await TokenHelper.getSystemToken();
      if (isGetAccessTokenSuccess) {
        if (countRequest < 2) {
          response = await requestApi(url, params, httpMethod, auth, body: body, countRequest: countRequest + 1, isTokenSystem: isTokenSystem);
        } else {
          response = Response(requestOptions: RequestOptions(path: ""), statusCode: 696969);
        }
      } else {
        response = Response(requestOptions: RequestOptions(path: ""), statusCode: 696969);
      }
    }

    if (isLoading) DialogUtil.hideLoading();
    //await new Future.delayed(const Duration(milliseconds: 100));
    return response;
  }

  static Future<Response> uploadMultiImage({
    required String url,
    bool auth = false,
    bool isSocial = false,
    bool isSingleImage = false,
    required List<File> listFile,
    Function(int total, int process, {CancelToken cancelToken})? onCallBackUpload,
  }) async {
    late Response response;
    try {
      var dio = new Dio();
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        request: true,
      ));
      var headers = Map<String, String>();
      if (auth) {
        headers["Authorization"] = CenBase.accessToken ?? "";
      }
      headers["platform"] = TrackingHelper.platform;
      headers["appVersion"] = TrackingHelper.appVersion;
      headers["deviceInfo"] = TrackingHelper.deviceInfo;

      var text = "";
      var time = DateTimeUtil.getFullDateAndTimeSecond(DateTime.now());
      var timeStart = DateTime.now();
      Options options;

      options = Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      );
      options.contentType = Headers.jsonContentType;

      var formData = FormData();
      for (var file in listFile) {
        var mimeType = mime.mime(file.path);
        String mimeeee = "";
        String type = "";
        if (mimeType != null) {
          mimeeee = mimeType.split('/')[0];
          type = mimeType.split('/')[1];
        }
        if (isSingleImage) {
          formData.files.addAll([
            MapEntry("images", await MultipartFile.fromFile(file.path, contentType: MediaType(mimeeee, type))),
          ]);
        } else {
          formData.files.addAll([
            MapEntry(isSocial ? "files[]" : "files", await MultipartFile.fromFile(file.path, contentType: MediaType(mimeeee, type))),
          ]);
        }
      }
      // print(fileName);
      // if (file is File)
      //   data = FormData.fromMap({
      //     "file": await MultipartFile.fromFile(
      //       file.path,
      //       filename: path.basename(file.path),
      //     ),
      //   });
      // else
      //   data = FormData.fromMap({
      //     "file": MultipartFile.fromBytes(
      //       file,
      //       filename: fileName,
      //     ),
      //   });
      CancelToken cancelToken = CancelToken();
      try {
        response = await dio.post(
          url,
          data: formData,
          cancelToken: cancelToken,
          onSendProgress: (int sent, int total) {
            print("$sent $total");
            if (onCallBackUpload != null) onCallBackUpload(sent, total, cancelToken: cancelToken);
          },
          options: options,
        );
      } catch (ex) {
        print("=======Lỗi try catch api=====");
        print(ex.toString());
        response = Response(requestOptions: RequestOptions(path: ""), statusCode: 696969);
      }
      text += "url: $url \n";
      text += "httpMethod: httpMethod.post \n";
      text += "param: ${formData.files} \n";
      text += "header: ${options.headers.toString()} \n";
      text += "contentType: ${options.contentType} \n";
      text += "timeStartRequest: $time \n";
      var timeEnd = DateTime.now();
      final difference = timeEnd.difference(timeStart).inMilliseconds;
      text += "RequestTime: $difference \n";
      text += "responseStatusCode: ${response.statusCode.toString()} \n";
      text += "response: $response";
      LogHelper.saveLog(text, timeStart: timeStart, logType: EnumLogType.api);
      return response;
    } catch (e) {
      print(e);
      return response;
    }
  }

  static Future<Response> uploadMultiFile({
    required String url,
    bool auth = false,
    bool isSingleFile = false,
    required List<File> listFile,
    Function(int total, int process, {CancelToken cancelToken})? onCallBackUpload,
  }) async {
    late Response response;
    try {
      var dio = new Dio();
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        request: true,
      ));
      var headers = Map<String, String>();
      if (auth) {
        headers["Authorization"] = CenBase.accessToken ?? "";
      }
      headers["platform"] = TrackingHelper.platform;
      headers["appVersion"] = TrackingHelper.appVersion;
      headers["deviceInfo"] = TrackingHelper.deviceInfo;

      var text = "";
      var time = DateTimeUtil.getFullDateAndTimeSecond(DateTime.now());
      var timeStart = DateTime.now();
      Options options;

      options = Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      );
      options.contentType = Headers.jsonContentType;

      var formData = FormData();
      for (var file in listFile) {
        var mimeType = mime.mime(file.path);
        String mimeeee = "";
        String type = "";
        if (mimeType != null) {
          mimeeee = mimeType.split('/')[0];
          type = mimeType.split('/')[1];
        }
        formData.files.addAll([
          MapEntry("files", await MultipartFile.fromFile(file.path, contentType: MediaType(mimeeee, type))),
        ]);
      }
      // print(fileName);
      // if (file is File)
      //   data = FormData.fromMap({
      //     "file": await MultipartFile.fromFile(
      //       file.path,
      //       filename: path.basename(file.path),
      //     ),
      //   });
      // else
      //   data = FormData.fromMap({
      //     "file": MultipartFile.fromBytes(
      //       file,
      //       filename: fileName,
      //     ),
      //   });
      CancelToken cancelToken = CancelToken();
      try {
        response = await dio.post(
          url,
          data: formData,
          cancelToken: cancelToken,
          onSendProgress: (int sent, int total) {
            print("$sent $total");
            if (onCallBackUpload != null) onCallBackUpload(sent, total, cancelToken: cancelToken);
          },
          options: options,
        );
      } catch (ex) {
        print("=======Lỗi try catch api=====");
        print(ex.toString());
        response = Response(requestOptions: RequestOptions(path: ""), statusCode: 696969);
      }
      text += "url: $url \n";
      text += "httpMethod: httpMethod.post \n";
      text += "param: ${formData.files} \n";
      text += "header: ${options.headers.toString()} \n";
      text += "contentType: ${options.contentType} \n";
      text += "timeStartRequest: $time \n";
      var timeEnd = DateTime.now();
      final difference = timeEnd.difference(timeStart).inMilliseconds;
      text += "RequestTime: $difference \n";
      text += "responseStatusCode: ${response.statusCode.toString()} \n";
      text += "response: $response";
      LogHelper.saveLog(text, timeStart: timeStart, logType: EnumLogType.api);
      return response;
    } catch (e) {
      print(e);
      return response;
    }
  }
}
