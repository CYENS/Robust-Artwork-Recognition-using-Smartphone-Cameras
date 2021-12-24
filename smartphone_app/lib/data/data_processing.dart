import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:modern_art_app/data/artists_dao.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/url_data_sources.dart';

/// Returns a list with the paths of all asset files; the [assetType] argument
/// can optionally be used to get assets only from specific subdirectories in
/// assets.
Future<List<String>> getAllAssets({String assetType = 'assets'}) async {
  final assetManifest = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> assetMap =
      json.decode(assetManifest) as Map<String, dynamic>;
  return assetMap.keys
      .where((String key) => key.contains(assetType.toLowerCase()))
      .toList();
}

/// Reads the provided json file at [assetsPath] and returns a future list of map
/// item entries (the entries must be processed with [parseItemMap] first to be
/// valid db entities).
Future<List<Map>> getLocalJsonItemList(String assetsPath) async =>
    rootBundle.loadString(assetsPath).then(
          (jsonStr) =>
              List<Map>.from(json.decode(jsonStr)['feed']['entry'] as Iterable),
        );

/// Gets and parses the json entry at the provided [url] and returns a future
/// list of map item entries (the entries must be processed with [parseItemMap]
/// first to be valid db entities).
Future<List<Map>> getRemoteJsonItemList(String url) async {
  final itemsJson = await http.get(Uri.parse(url));
  if (itemsJson.statusCode == 200) {
    final Map body = json.decode(itemsJson.body) as Map<dynamic, dynamic>;
    return List<Map>.from(body['feed']['entry'] as Iterable);
  } else {
    throw HttpException(
      'Error getting remote json: statusCode ${itemsJson.statusCode}',
    );
  }
}

/// Updates the app's db from the remote Google spreadsheet.
Future<void> updateDbFromGSheets(
  ArtworksDao artworksDao,
  ArtistsDao artistsDao,
) async {
  // first update artists
  getRemoteJsonItemList(gSheetUrlArtists).then(
    (artists) => artists.forEach(
      (entry) {
        final artist = Artist.fromJson(parseItemMap(entry));
        artistsDao.upsertArtist(artist);
        debugPrint('Updated artist ${artist.name}');
      },
    ),
  );
  // then update artworks
  getRemoteJsonItemList(gSheetUrlArtworks).then(
    (artworks) => artworks.forEach(
      (entry) {
        final artwork = Artwork.fromJson(parseItemMap(entry));
        artworksDao.upsertArtwork(artwork);
        debugPrint('Updated artwork ${artwork.name}');
      },
    ),
  );
}

/// Extracts the necessary fields from each [mapItem] and discards the excess
/// information; the returned map objects can be used as input data to create
/// [Artist] or [Artwork] objects with .fromJson().
Map<String, dynamic> parseItemMap(Map mapItem) => {
      // filter keys, only interested in the ones that start with "gsx$"
      for (var k in mapItem.keys.where((k) => k.toString().startsWith('gsx')))
        k.toString().replaceAll('gsx\$', ''): mapItem[k]['\$t']
    };

Map<String, dynamic> parseItemTranslations(
  Map<String, dynamic> item,
  String languageCode,
) =>
    {
      // add languageCode here as additional key, so it's included in translations
      // note that key for languageCode must be in all lowercase, in order to
      // be recognised by the json serializer
      for (var k in item.keys.toList()..add('languageCode'))
        k.endsWith('-$languageCode') ? k.replaceAll('-$languageCode', '') : k:
            k == 'languageCode' ? languageCode : item[k]
    };
