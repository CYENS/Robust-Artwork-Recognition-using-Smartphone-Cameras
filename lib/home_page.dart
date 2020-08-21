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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Modern Art App"),
        actions: [
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
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.33,
              width: size.width,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.33,
                    width: size.width,
                    child: Image.asset(
                      "pinakothiki_building.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    // add gradient in front of building photo to make text in
                    // front of it legible, based on the example provided here
                    // https://api.flutter.dev/flutter/widgets/Stack-class.html
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black12,
                          Colors.black12,
                          Colors.black
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Κρατική Πινακοθήκη Σύγχρονης Κυπριακής Τέχνης",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HeadlineAndMoreRow(listType: "Painting"),
            PaintingListHorizontal(listType: "Painting"),
            HeadlineAndMoreRow(listType: "Painter"),
            PaintingListHorizontal(listType: "Painter"),
          ],
        ),
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

class HeadlineAndMoreRow extends StatelessWidget {
  final String listType;

  const HeadlineAndMoreRow({Key key, @required this.listType})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headline("${listType}s"),
          Spacer(),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaintingListVertical(
                              listType: listType,
                            )));
              },
              child: Text("more"))
        ],
      );
}

Widget headline(String text) => Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text.toUpperCase(),
        style: Typography.whiteMountainView.headline1.copyWith(fontSize: 20),
      ),
    );
