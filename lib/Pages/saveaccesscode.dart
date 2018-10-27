import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class AcCodeStorage {

  //getting local path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //getting the file from the path
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/acCode.txt');
  }


  //reading the file
  Future<dynamic> readAcCode() async {
    try {
      final file = await _localFile;

      // Read the file
      String acCode = await file.readAsString();

      return acCode.toString();
    } catch (e) {
      // If we encounter an error, return 0
      return null;
    }
  }

  //writing to the file
  Future<File> writeAcCode(var code) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$code');
  }

  //deleting the file
  Future<File> deleteAcCode() async{
    final file = await _localFile;
    return file.delete();
  }
}
