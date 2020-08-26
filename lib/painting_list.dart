import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

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
    future: loadAssets(assetType: listType),
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
    double size = MediaQuery.of(context).size.width * 0.28;
    return Container(
      height: size,
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
    future: loadAssets(assetType: listType),
    builder: (context, snapshot) {
      double size = MediaQuery.of(context).size.width * 0.28;
      if (snapshot.hasData) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              List<String> results = snapshot.data;
              int len = results.length;
              return PaintingTile(
                paintingName: "$listType $index",
                tileSideLength: size,
                path: results[index % len],
              );
            });
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}

Future<List<String>> loadAssets({String assetType = "assets"}) async {
  final assetManifest = await rootBundle.loadString("AssetManifest.json");
  final Map<String, dynamic> assetMap = json.decode(assetManifest);
//  await Future.delayed(Duration(seconds: 1));
  return assetMap.keys
      .where((String key) => key.contains(assetType.toLowerCase()))
      .toList();
}
