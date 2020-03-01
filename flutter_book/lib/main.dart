import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_book/app.dart';
import 'package:flutter_book/config.dart';
import 'package:path_provider/path_provider.dart';

//TODO: fix id for uploaded image
//TODO: remove statfull widget
//TODO: consildate common code
//TODO: fix bottom sheet for appointments
//TODO: build android and ios variants
//TODO: enhance the UI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory docsDir = await getApplicationDocumentsDirectory();
  AppConfig.docsDir = docsDir;
  runApp(FlutterBook());
}
