import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class LoadJson{
  FileLoader reader;
  LoadJson(this.reader);
  Future<List<dynamic>> readJson(String path) async {
    final String response = await reader.loadFile(path);
    final data = await json.decode(response);
    return data;
  }
}

abstract class FileLoader {
  Future<String> loadFile(String path);
}

class AppWay implements FileLoader {
  @override
  Future<String> loadFile(String path) {
    return rootBundle.loadString(path);
  }

}

class TestWay implements FileLoader {
  @override
  Future<String> loadFile(String path) {
    final file = File(path);
    return file.readAsString();
  }

}