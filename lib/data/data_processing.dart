import 'dart:convert';

import 'package:flutter/services.dart';

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
