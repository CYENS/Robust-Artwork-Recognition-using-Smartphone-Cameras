import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/home.dart';

CameraDescription camera;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // get back camera
    camera = (await availableCameras()).first;
  } on CameraException catch (e) {
    print("Error ${e.code}\nError msg: ${e.description}");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(camera: camera),
    );
  }
}
