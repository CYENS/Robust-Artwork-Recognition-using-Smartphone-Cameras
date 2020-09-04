import 'dart:convert';
import 'dart:io';

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

/// Reads the provided json file at [assetsPath] and returns a future list of map
/// item entries (the entries must be processed with [parseItemMap] first to be
/// valid db entities).
Future<List<Map>> getLocalJsonItemList(String assetsPath) async {
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => List<Map>.from(json.decode(jsonStr)["feed"]["entry"]));
}

/// Gets and parses the json entry at the providded [url] and returns a future
/// list of map item entries (the entries must be processed with [parseItemMap]
/// first to be valid db entities).
Future<List<Map>> getRemoteJsonItemList(String url) async {
  var itemsJson = await http.get(url);
  if (itemsJson.statusCode == 200) {
    Map body = json.decode(itemsJson.body);
    return List<Map>.from(body["feed"]["entry"]);
  } else {
    throw HttpException(
        "Error getting remote json: statusCode ${itemsJson.statusCode}");
  }
}

void getJson(ArtworksDao artworksDao, ArtistsDao artistsDao) async {
  var jsonArtists = await http.get(gSheetUrlArtists);

  if (jsonArtists.statusCode == 200) {
    Map body = json.decode(jsonArtists.body);
    var artists = List<Map>.from(body["feed"]["entry"]);

    artists.forEach((item) {
      // convert map from Json to compatible Map for data class
      var itemMap = parseItemMap(item);
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
      var itemMap = parseItemMap(item);
      artworksDao.upsertArtwork(Artwork.fromJson(itemMap));
      print("added ${itemMap["title"]}");
    });
  } else {
    print("Error getting json: statusCode ${jsonArtworks.statusCode}");
  }
}

void getJson2(ArtworksDao artworksDao, ArtistsDao artistsDao) async {
  var arts = getLocalJsonItemList("assets/data/artists.json");
  arts.then((artists) => artists.forEach((artist) {
        var item = Artist.fromJson(parseItemMap(artist));
        artistsDao.upsertArtist(item);
        print(item);
      }));
}

/// Extracts the necessary fields from each [mapItem] and discards the excess
/// information; the returned map objects can be used as input data to create
/// [Artist] or [Artwork] objects with .fromJson().
Map<String, dynamic> parseItemMap(Map mapItem) =>
    Map<String, dynamic>.fromIterable(
      // filter keys, only interested in the ones that start with "gsx$"
      mapItem.keys.where((k) => k.startsWith("gsx")),
      // remove "gsx$" from keys, to match with local data class column names
      key: (k) => k.replaceAll("gsx\$", ""),
      // get value for key, in the case of id parse it into int first
      value: (k) =>
          k == "gsx\$id" ? int.parse(mapItem[k]["\$t"]) : mapItem[k]["\$t"],
    );
