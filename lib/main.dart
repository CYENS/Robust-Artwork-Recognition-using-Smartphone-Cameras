import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/home_page.dart';
import 'package:provider/provider.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // get back camera
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print("Error ${e.code}\nError msg: ${e.description}");
  }
  runApp(Provider<MyDatabase>(
    create: (context) => MyDatabase(),
    child: MyApp(),
    dispose: (context, db) => db.close(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(cameras: cameras),
    );
  }
}
