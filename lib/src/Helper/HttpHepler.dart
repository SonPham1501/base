import 'dart:io';

import 'package:base/src/AppBase.dart';
import 'package:base/src/Helper/LogHelper.dart';
import 'package:base/src/Helper/TrackingHelper.dart';
import 'package:base/src/Utils/export_utils.dart';
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
    Map<String, dynamic>? headers,
  }) async {
    Response? response;
    Options options;
    var dio = Dio();
    dio.options.connectTimeout = timeOut; //5s
    dio.options.receiveTimeout = timeOut;
    dio.interceptors.add(
      InterceptorsWrapper(
        // handle onRequest
        onRequest: (
          RequestOptions requestOptions,
          RequestInterceptorHandler handler,
        ) async {
          dio.interceptors.requestLock.lock();
          if (auth) {
            String token =
              await SecureStorageUtil.getString(SecureStorageUtil.Token);
            if (token != '') {
              requestOptions.headers[HttpHeaders.authorizationHeader] =
                  'Bearer ' + token;
              if (AppBase.finger != null) {
                requestOptions.headers['Finger'] = AppBase.finger;
              }
              dio.interceptors.requestLock.unlock();
              return handler.next(requestOptions);
            }
          }
          dio.interceptors.requestLock.unlock();
          return handler.next(requestOptions);
        },
        // handle onResponse
        onResponse: (
          Response response,
          ResponseInterceptorHandler handler,
        ) async {
          // Do something with response data
          bool isValidData = response.data != null;
          if (isValidData) {
            return handler.next(response);
          }
          return handler.next(response); // continue
        },
        // handle onError
        onError: (
          DioError error,
          ErrorInterceptorHandler handler,
        ) async {
          // print(error.toString());
          // await DialogBuilder.showSimpleDialog(error.toString());
          //SnackbarBuilder.showSnackbar(content: 'Máy chủ đang bảo trì');
          switch (error.type) {
            case DioErrorType.cancel:
              print('requestCancelled');
              break;
            case DioErrorType.connectTimeout:
              print('requestTimeout');
              break;
            case DioErrorType.receiveTimeout:
              print('sendTimeout');
              break;
            case DioErrorType.response:
              print(
                  'response error ${error.response?.realUri} ${error.response?.statusCode}');
              if (error.response?.statusCode == 401 ||
                  error.response?.statusCode == 403) {
                if (error.response!.realUri.toString().contains('user/login')) {
                  return handler.next(error);
                }
                // await handleEventAuthError(error);  // code removed to fix case: only 1 device can be used at a time
                // remove code below when backend fix bug use token on multiple devices
                if (!error.response!.realUri
                    .toString()
                    .contains('firebase/unsubscribe-device')) {
                  //UserService.unRegisterFirebase();
                }
                await SecureStorageUtil.removeString(SecureStorageUtil.Token);
              }
              break;
            case DioErrorType.sendTimeout:
              break;
            case DioErrorType.other:
              print('Dio onError DioErrorType.other');
              break;
          }
          return handler.next(error);
        },
      ),
    );

    // creatFile
    headers ??= <String, dynamic>{};
    headers["client"] = "mobile_app";
    headers["platform"] = TrackingHelper.platform;
    headers["appVersion"] = TrackingHelper.appVersion;
    headers["deviceInfo"] = TrackingHelper.deviceInfo;

    if (body) {
      options = Options(
        headers: headers,
        contentType: Headers.jsonContentType,
        followRedirects: false,
        responseType: ResponseType.json,
        validateStatus: (status) {
          return status! <= 500;
        },
      );
    } else {
      options = Options(
        headers: headers,
        contentType: Headers.formUrlEncodedContentType,
        followRedirects: false,
        responseType: ResponseType.json,
        validateStatus: (status) {
          return status! <= 500;
        },
      );
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
    if (response == null || response.statusCode == null) {
      Util.showToast("Lỗi mạng, Vui lòng thực hiện lại");
      response = Response(requestOptions: RequestOptions(path: ""), statusCode: 696969);
    }
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
      var dio = Dio();
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        request: true,
      ));
      var headers = <String, String>{};
      if (auth) {
        headers["Authorization"] = await SecureStorageUtil.getString(
          SecureStorageUtil.Token,
        );
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
      var dio = Dio();
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        request: true,
      ));
      var headers = <String, String>{};
      if (auth) {
        headers["Authorization"] = await SecureStorageUtil.getString(
          SecureStorageUtil.Token,
        );
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
