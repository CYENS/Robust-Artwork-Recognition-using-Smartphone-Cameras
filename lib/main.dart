import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firstCamera = (await availableCameras()).first;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: HomePage(camera: firstCamera),
  ));
}
