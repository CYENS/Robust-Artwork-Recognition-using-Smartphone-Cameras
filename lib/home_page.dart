import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/camera.dart';
import 'package:modern_art_app/painting_list.dart';
import 'package:modern_art_app/tensorflow/model_selection.dart';

class HomePage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const HomePage({Key key, @required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modern Art App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            // todo add changelog
            tooltip: "Settings",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaintingListVertical()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.camera),
            tooltip: "Tensorflow",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModelSelection(cameras)));
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                "pinakothiki_building.jpg",
                //fit: BoxFit.fill,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(),
                child: Text(
                  "Κρατική Πινακοθήκη Σύγχρονης Κυπριακής Τέχνης",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
          headline("Paintings"),
          PaintingListHorizontal(listType: "Painting"),
          headline("Painters"),
          PaintingListHorizontal(listType: "Painter"),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Αναγνώριση Πίνακα"),
        icon: Icon(Icons.camera_alt),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TakePictureScreen(cameras: cameras)),
          );
        },
      ),
    );
  }
}

Widget headline(String text) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      text.toUpperCase(),
      style: Typography.whiteMountainView.headline1.copyWith(fontSize: 20),
    ),
  );
}
