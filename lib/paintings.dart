import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'details.dart';

class PaintingList extends StatelessWidget {
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

  const PaintingRow({Key key, this.paintingName}) : super(key: key);

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
                  builder: (context) => DetailsPage(
                        paintingName: paintingName,
                      )),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                  tag: paintingName,
                  child: Image.asset("assets/paintings/mona_lisa.webp")),
              Text(paintingName),
            ],
          ),
        ),
      ),
    );
  }
}
