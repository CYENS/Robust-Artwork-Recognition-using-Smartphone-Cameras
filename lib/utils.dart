import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> loadAssets({String assetType = "assets"}) async {
  final assetManifest = await rootBundle.loadString("AssetManifest.json");
  final Map<String, dynamic> assetMap = json.decode(assetManifest);
//  await Future.delayed(Duration(seconds: 1));
  return assetMap.keys
      .where((String key) => key.contains(assetType.toLowerCase()))
      .toList();
}
