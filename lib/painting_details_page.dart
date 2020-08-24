import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:photo_view/photo_view.dart';

class PaintingDetailsPage extends StatelessWidget {
  final String path;
  final String name;
  final String painter;

  // todo add hero tag as argument

  const PaintingDetailsPage({
    Key key,
    this.path = "assets/paintings/mona_lisa.webp",
    this.name = "Painting name",
    this.painter = "Painter",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Painting details")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic)),
            Text(painter),
            Align(
              child: AspectRatio(
                aspectRatio: 1 / 0.9,
                child: PhotoView(
                  imageProvider: AssetImage(path),
                  heroAttributes: PhotoViewHeroAttributes(tag: name),
                ),
              ),
            ),
            Text("Description", style: TextStyle(fontSize: 25)),
            Text(lorem(paragraphs: 5, words: 300)),
          ],
        ),
      ),
    );
  }
}
