import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'painting_details_page.dart';

class PaintingListVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Painting List")),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            return PaintingRow(paintingName: "row $index");
          }),
    );
  }
}

class PaintingRow extends StatelessWidget {
  final String paintingName;
  final String _path;

  PaintingRow({Key key, this.paintingName, path})
      : _path = path ?? randomPainting(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaintingDetailsPage(
                          name: paintingName,
                        )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(tag: paintingName, child: Image.asset(_path)),
              Text(paintingName),
            ],
          ),
        ),
      ),
    );
  }
}

class PaintingListHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return PaintingTile(paintingName: "mona", tileSideLength: 150);
        },
      ),
    );
  }
}

class PaintingTile extends StatelessWidget {
  final String paintingName;
  final double tileSideLength;

  const PaintingTile({Key key, this.paintingName, this.tileSideLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaintingDetailsPage(
                      name: paintingName,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: tileSideLength,
        width: tileSideLength,
        child: Image.asset(
          randomPainting(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

String randomPainting() {
  return [
    "assets/paintings/last_supper.webp",
    "assets/paintings/mona_lisa.webp",
    "assets/paintings/vitruvian_man.webp"
  ][Random().nextInt(3)];
}
