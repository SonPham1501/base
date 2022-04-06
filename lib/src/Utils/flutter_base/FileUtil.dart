import 'package:path_provider/path_provider.dart';

class FileUtil{
  static String? appDocumentPath;
  static void init()async
  {
    var appDocDir = await getApplicationDocumentsDirectory();
    appDocumentPath = appDocDir.path + "/";
  }
}