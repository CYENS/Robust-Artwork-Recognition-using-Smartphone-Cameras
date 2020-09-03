import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:modern_art_app/data/artists_dao.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/urls.dart';

/// Returns a list with the paths of all asset files; the [assetType] argument
/// can optionally be used to get assets only from specific subdirectories in
/// assets.
Future<List<String>> getAllAssets({String assetType = "assets"}) async {
  final assetManifest = await rootBundle.loadString("AssetManifest.json");
  final Map<String, dynamic> assetMap = json.decode(assetManifest);
//  await Future.delayed(Duration(seconds: 1));
  return assetMap.keys
      .where((String key) => key.contains(assetType.toLowerCase()))
      .toList();
}

void getJson(ArtworksDao artworksDao, ArtistsDao artistsDao) async {
  var jsonArtists = await http.get(gSheetUrlArtists);

  if (jsonArtists.statusCode == 200) {
    Map body = json.decode(jsonArtists.body);
    var artists = List<Map>.from(body["feed"]["entry"]);

    artists.forEach((item) {
      // convert map from Json to compatible Map for data class
      var itemMap = parseJsonMap(item);
      artistsDao.upsertArtist(Artist.fromJson(itemMap));
      print("added ${itemMap["name"]}");
    });
  } else {
    print("Error getting json: statusCode ${jsonArtists.statusCode}");
  }

  var jsonArtworks = await http.get(gSheetUrlArtworks);

  if (jsonArtworks.statusCode == 200) {
    Map body = json.decode(jsonArtworks.body);
    var artworks = List<Map>.from(body["feed"]["entry"]);

    artworks.forEach((item) {
      // convert map from Json to compatible Map for data class
      var itemMap = parseJsonMap(item);
      artworksDao.upsertArtwork(Artwork.fromJson(itemMap));
      print("added ${itemMap["title"]}");
    });
  } else {
    print("Error getting json: statusCode ${jsonArtworks.statusCode}");
  }
}

Map<String, dynamic> parseJsonMap(Map map) => Map<String, dynamic>.fromIterable(
      // filter keys, only interested in the ones that start with "gsx$"
      map.keys.where((k) => k.startsWith("gsx")),
      // remove "gsx$" from keys, to match with local data class column names
      key: (k) => k.replaceAll("gsx\$", ""),
      // get value for key, in the case of id parse it into int first
      value: (k) => k == "gsx\$id" ? int.parse(map[k]["\$t"]) : map[k]["\$t"],
    );
