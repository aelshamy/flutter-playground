import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_book/app.dart';
import 'package:flutter_book/config.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory docsDir = await getApplicationDocumentsDirectory();
  AppConfig.docsDir = docsDir;
  runApp(FlutterBook());
}
