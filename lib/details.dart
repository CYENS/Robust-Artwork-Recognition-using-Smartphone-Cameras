import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:photo_view/photo_view.dart';

class DetailsPage extends StatelessWidget {
  final String imagePath;

  const DetailsPage({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Painting details")),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "The Mona Lisa",
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
          Text("by Leonardo da Vinci, 1503–1506"),
          Align(
            child: AspectRatio(
              aspectRatio: 1 / 0.9,
              child: PhotoView(
                  imageProvider: AssetImage("assets/paintings/mona_lisa.webp")),
            ),
          ),
          Text(
            "Description",
            style: TextStyle(fontSize: 25),
          ),
          Text(lorem(paragraphs: 5, words: 300)),
        ]),
      ),
    );
  }
}
