import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/camera.dart';

class HomePageMain extends StatelessWidget {
  final CameraDescription camera;

  const HomePageMain({Key key, @required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modern Art App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: "Settings",
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Image.asset("pinakothiki_building.jpg"),
          Text(
            "Κρατική Πινακοθήκη Σύγχρονης Κυπριακής Τέχνης",
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TakePictureScreen(camera: camera),
            ),
          );
        },
      ),
    );
  }
}
