import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/urls.dart';
import 'package:modern_art_app/painting_list.dart';
import 'package:moor/moor.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyDatabase db = Provider.of<MyDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        actions: [
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MoorDbViewer(db)))),
          IconButton(
            icon: Icon(Icons.http),
            onPressed: getJson,
          )
        ],
      ),
      body: StreamBuilder<List<Artwork>>(
        stream: db.watchAllArtworkEntries,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final artworks = snapshot.data;
          return ListView.builder(
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                Artwork artwork = artworks[index];
                print(artwork.toJsonString());
                return PaintingRow(
                    paintingName: "${artwork.id} ${artwork.description}");
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          db.addArtwork(ArtworksCompanion(
              title: Value("todosssssss"),
              description: Value("todo todo todo")));
        },
      ),
    );
  }
}

void getJson() async {
  var jsonData = await http.get(gSheetUrlArtworks);

  if (jsonData.statusCode == 200) {
    Map body = json.decode(jsonData.body);
    var artworks = List<Map>.from(body["feed"]["entry"]);

    var s = Map<String, dynamic>.fromIterable(
      // filter keys, only interested in the ones that start with "gsx$"
      artworks[0].keys.where((k) => k.startsWith("gsx")),
      // remove "gsx$" from keys, to match with local data class column names
      key: (k) => k.replaceAll("gsx\$", ""),
      // get value for key, in the case of id parse it into int first
      value: (k) => k == "gsx\$id"
          ? int.parse(artworks[0][k]["\$t"])
          : artworks[0][k]["\$t"],
    );
    s.forEach((key, value) {
      print("$key ${key.runtimeType} $value ${value.runtimeType}");
    });
    print(Artwork.fromJson(s));
  } else {
    print("Error getting json: statusCode ${jsonData.statusCode}");
  }
}
