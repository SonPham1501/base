// ignore_for_file: constant_identifier_names

import 'package:base/src/Helper/LogHelper.dart';
import 'package:base/src/Utils/flutter_base/DateTimeUtil.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../AppBase.dart';
import '../Common/Enum.dart';
import '../Utils/BaseProjectUtil.dart';
import '../Utils/DialogUtil.dart';
import 'SqfLiteHelper.dart';
import 'TokenHelper.dart';

enum GraphQlMethod { Queries, Mutations }

class GraphQLHelper {
  static ValueNotifier<GraphQLClient> socketClient(String? linkSocket) {
    final _authLink = AuthLink(
      getToken: () => '${AppBase.accessToken}',
      headerKey: 'Authorization',
    );

    final WebSocketLink webSocketLink = WebSocketLink(
      '$linkSocket',
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: const Duration(seconds: 30),
        initialPayload: {
          "headers": {"Authorization": '${AppBase.accessToken}'}
        },
      ),
    );
    final link = _authLink.concat(webSocketLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: link,
      ),
    );
    return client;
  }

  static getSocketClient(String? linkSocket) {
    final WebSocketLink webSocketLink = WebSocketLink(
      '$linkSocket',
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: const Duration(seconds: 30),
        initialPayload: {
          "headers": {"Authorization": '${AppBase.accessToken}'}
        },
      ),
    );
    GraphQLClient client = GraphQLClient(
      link: webSocketLink,
      cache: GraphQLCache(),
    );
    return client;
  }

  static Future<Stream<QueryResult>> getSocketData(
      {String? linkSocket,
      String? repository,
      Map<dynamic, dynamic>? variables,
      APiLogModel? aPiLogModel}) async {
    SubscriptionOptions subscriptionOptions = SubscriptionOptions(
        document: gql(repository!), variables: {"where": variables});
    var time = DateTimeUtil.getFullDateAndTimeSecond(DateTime.now());
    GraphQLClient client = getSocketClient(linkSocket);
    if (AppBase.buildType == CenBuildType.test) {
      if (aPiLogModel != null) {
        aPiLogModel..url = "url: $linkSocket \n"
        ..repository = "repository: $repository \n"
        ..httpMethod = "method: GraphQlMethod.subscription \n"
        ..param = "variables: ${variables.toString()} \n";
      }
    }
    Stream<QueryResult> response = client.subscribe(subscriptionOptions);
    return response;
  }

  static Future<QueryResult> fetchData(
    BuildContext context,{
    required String link,
    GraphQlMethod method = GraphQlMethod.Queries,
    Map<String, dynamic>? variables,
    String? operationName,
    String? repository,
    bool isLoading = false,
    int countRequest = 1,
  }) async {
    var time = DateTimeUtil.getFullDateAndTimeSecond(DateTime.now());
    var timeStart = DateTime.now();
    if (AppBase.buildType == CenBuildType.test) {}
    QueryResult result;
    final _authLink = AuthLink(
      getToken: () => '${AppBase.accessToken}',
      headerKey: 'Authorization',
    );
    final _httpLink = HttpLink(
      link,
    );
    final Link _link = _authLink.concat(_httpLink);
    final client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
    if (isLoading && countRequest == 1) {
      DialogUtil.showLoading();
    }
    if (method == GraphQlMethod.Queries) {
      final WatchQueryOptions _options = WatchQueryOptions(
        document: gql(repository ?? ""),
        variables: variables ?? {},
        pollInterval: const Duration(seconds: 10),
        fetchResults: true,
      );
      result = await client.query(_options);
    } else {
      final MutationOptions _options = MutationOptions(
        operationName: operationName,
        document: gql(repository ?? ""),
        variables: variables!,
      );
      result = await client.mutate(_options);
    }
    if (AppBase.buildType == CenBuildType.test) {
      var token = await _authLink.getToken();
      var timeEnd = DateTime.now();
      // lưu log
//      APiLogModel aPiLogModel = APiLogModel(
//          userId: CenBase.user?.username ?? "",
//          url: link,
//          type: 2,
//          header: _authLink.headerKey.toString(),
//          contentType: token,
//          operationName: operationName,
//          repository: repository,
//          httpMethod: method.toString(),
//          param: variables.toString(),
//          timeStartRequest: time,
//          timeEndRequest: timeEnd,
//          response: result.toString());
      var text = "";
      text += "url: $link \n";
      text += "header: ${_authLink.headerKey.toString()} \n";
      text += "token: $token\n";
      text += "operationName: $operationName \n";
      text += "repository: $repository \n";
      text += "method: ${method.toString()} \n";
      text += "variables: ${variables.toString()} \n";
      text += "timeStartRequest: $time \n";
      final difference = timeEnd.difference(timeStart).inMilliseconds;
      text += "RequestTime: $difference \n";
      text += "result: ${result.toString()}";
      LogHelper.saveLog(text, timeStart: timeStart, logType: EnumLogType.api);
//      var insert = await SqfLiteHelper.insert(aPiLogModel);
    }
    debugPrint("result $result");
    if (result.hasException) {
      debugPrint("lỗi ${result.exception.toString()}");
      bool checkAccessToken =
          BaseProjectUtil.compareCodeErrorGraphQL(result, "access-denied");

      if (checkAccessToken) {
        var isGetAccessTokenSuccess =
            await TokenHelper.getAccessTokenInRefreshToken();
        if (isGetAccessTokenSuccess) {
          if (countRequest < 2) {
            var data = await fetchData(
                context,
                link: link,
                method: method,
                variables: variables,
                repository: repository,
                isLoading: isLoading,
                countRequest: countRequest + 1);
            return data;
          }
        } else {
          AppBase.accessToken = null;
          AppBase.refreshToken = null;
          AppBase.systemToken = null;
          if (AppBase.accessToken != null) {
            AppBase.logout?.call();
          }
          if (isLoading) Navigator.of(context).pop();
          return result;
        }
      }
    }

    if (isLoading && countRequest == 1) Navigator.of(context).pop();

    return result;
  }
}
