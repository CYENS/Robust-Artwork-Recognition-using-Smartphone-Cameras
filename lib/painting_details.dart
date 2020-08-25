import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class PaintingDetails extends StatelessWidget {
  final String path;
  final String name;
  final String painter;

  // todo add hero tag as argument

  const PaintingDetails({
    Key key,
    this.path = "assets/paintings/mona_lisa.webp",
    this.name = "Painting name",
    this.painter = "Painter",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                  height: size.height,
                  child: Image.asset(path, fit: BoxFit.cover)),
            ),
            Container(
              child: Column(
                children: [
                  Text("Description", style: TextStyle(fontSize: 25)),
                  Text(lorem(paragraphs: 2, words: 100))
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black12,
                    Colors.black12,
                    Colors.black38,
                    Colors.black
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: size.width * 0.3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/painters/leonardo_da_vinci.webp"),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
