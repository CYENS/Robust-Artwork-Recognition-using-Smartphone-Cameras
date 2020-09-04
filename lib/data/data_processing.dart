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

/// Updates the app's db from the remote Google spreadsheet.
void updateDbFromGSheets(ArtworksDao artworksDao, ArtistsDao artistsDao) async {
  // first update artists
  getRemoteJsonItemList(gSheetUrlArtists)
      .then((artists) => artists.forEach((entry) {
            var artist = Artist.fromJson(parseItemMap(entry));
            artistsDao.upsertArtist(artist);
            print("Updated artist ${artist.name}");
          }));
  // then update artworks
  getRemoteJsonItemList(gSheetUrlArtworks)
      .then((artworks) => artworks.forEach((entry) {
            var artwork = Artwork.fromJson(parseItemMap(entry));
            artworksDao.upsertArtwork(artwork);
            print("Updated artwork ${artwork.title}");
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
