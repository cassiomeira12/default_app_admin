import 'dart:io';
import 'package:http/http.dart' show get;
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

class FileUtil {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String file) async {
    final path = await _localPath;
    return File('$path/${file}');
  }

  Future<File> readFile(String path) async {
    try {
      final file = await _localFile(path);
      return file;
    } catch (error) {
      print(error);
    }
  }

  Future<void> writeFile(File file) async {
    try {
      final save = await _localFile("cassio.txt");
      print(save.path);
      //final save = await _localFile(Path.basename(file.path));
      return save.writeAsString("Hello, world!");
    } catch (error) {
      print(error);
    }
  }



}