import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:modern_art_app/utils.dart';

import 'painting_details_page.dart';

class PaintingListVertical extends StatelessWidget {
  final String listType;

  const PaintingListVertical({Key key, @required this.listType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${listType}s")),
      body: listVerticalFuture(listType),
    );
  }
}

class PaintingRow extends StatelessWidget {
  final String paintingName;
  final String _path;

  PaintingRow({Key key, this.paintingName, path})
      : _path = path ?? "assets/paintings/mona_lisa.webp",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.3;
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaintingDetailsPage(
                        name: paintingName,
                        path: _path,
                      )));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
                tag: paintingName,
                child: Image.asset(
                  _path,
                  fit: BoxFit.cover,
                  height: size,
                  width: size,
                )),
            Text(paintingName),
          ],
        ),
      ),
    );
  }
}

Widget listVerticalFuture(String listType) {
  return FutureBuilder(
    future: getAllAssets(assetType: listType),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              List<String> paintings = snapshot.data;
              int len = paintings.length;
              return PaintingRow(
                paintingName: "$listType $index",
                path: paintings[index % len],
              );
            });
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}

class PaintingListHorizontal extends StatelessWidget {
  final String listType;

  const PaintingListHorizontal({Key key, @required this.listType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: listType == "Painting" ? size.width * 0.5 : size.width * 0.28,
      child: listHorizontalFuture(listType),
    );
  }
}

class PaintingTile extends StatelessWidget {
  final String paintingName;
  final String _path;
  final double tileSideLength;
  final double optionalTileHeight;

  PaintingTile(
      {Key key,
      @required this.paintingName,
      @required this.tileSideLength,
      this.optionalTileHeight,
      String path})
      : _path = path ?? "assets/paintings/mona_lisa.webp",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaintingDetailsPage(
                      name: paintingName,
                      path: _path,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: tileSideLength,
        height: optionalTileHeight ?? tileSideLength,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Hero(
            tag: paintingName,
            child: Image.asset(
              _path,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

Widget listHorizontalFuture(String listType) {
  return FutureBuilder(
    future: getAllAssets(assetType: listType),
    builder: (context, snapshot) {
      double width = MediaQuery.of(context).size.width;
      if (snapshot.hasData) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              List<String> results = snapshot.data;
              int len = results.length;
              return PaintingTile(
                paintingName: "$listType $index",
                tileSideLength:
                    listType == "Painting" ? width * 0.5 / 1.618 : width * 0.28,
                optionalTileHeight: listType == "Painting" ? width * 0.5 : null,
                path: results[index % len],
              );
            });
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}
