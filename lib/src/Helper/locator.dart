import 'package:base/base.dart';
import 'package:base/src/Helper/GraphQLHelper.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GraphQLApiClient(uri: AppBase.apiUrl));
}
