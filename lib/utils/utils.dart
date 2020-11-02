import 'dart:collection';
import 'dart:io';

import 'package:modern_art_app/data/database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Formats an [Artist]'s lifespan properly, returning only year of birth if
/// they are alive, or their lifespan otherwise.
///
/// TODO implement this in [ArtistTranslated] class perhaps
///
/// TODO return e.g. "b. 2000" in the first case, if [ArtistTranslated] is used as an input argument, the locale will be available, and can adjust accordingly for language
String lifespan(Artist artist) => artist.yearDeath.isNotEmpty
    ? "${artist.yearBirth}–${artist.yearDeath}"
    : artist.yearBirth;

String getArtistFilename(Artist artist) => "assets/painters/${artist.id}.webp";

String getArtworkFilename(Artwork artwork) =>
    "assets/paintings/${artwork.id}.webp";

/// Class that mirrors the functionality of [collections.defaultdict] in
/// Python, using Dart's Map class to implement similar behaviour. If a key is
/// not present in the "dict", putIfAbsent is automatically used to initialise
/// it's value with [_ifAbsent].
///
/// See https://stackoverflow.com/a/61198678
class DefaultDict<K, V> extends MapBase<K, V> {
  final Map<K, V> _map = {};
  final V Function() _ifAbsent;

  /// Initialise a [DefaultDict] by providing a default value for keys that do
  /// not yet have values.
  DefaultDict(this._ifAbsent);

  @override
  V operator [](Object key) => _map.putIfAbsent(key as K, _ifAbsent);

  @override
  void operator []=(K key, V value) => _map[key] = value;

  @override
  void clear() => _map.clear();

  @override
  Iterable<K> get keys => _map.keys;

  @override
  V remove(Object key) => _map.remove(key);
}

/// Returns a file path for a json file to be saved in the temporary directory.
Future<String> getTempFilePath() async {
  Directory tempDir = await getTemporaryDirectory();
  String appDocumentsPath = tempDir.path;
  return join(appDocumentsPath, "${DateTime.now().toIso8601String()}.json");
}

/// Saves the provided [text] string as a JSON file in the temporary directory.
/// Returns the file path of the saved JSON file.
Future<String> saveToJsonFile(String text) async {
  File file = File(await getTempFilePath());
  file.writeAsString(text);
  return file.path;
}
