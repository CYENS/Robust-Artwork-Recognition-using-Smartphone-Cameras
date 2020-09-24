import 'dart:io';

import 'package:modern_art_app/data/artists_dao.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/data_processing.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// To auto-generate the necessary moor-related code, run the following in the terminal:
// 'flutter packages pub run build_runner build'
// or the following to continuously regenerate code when code changes
// 'flutter packages pub run build_runner watch'

/// Path of locally cached json file with artists info.
const String artistsJsonPath = "assets/data/artists.json";

/// Path of locally cached json file with artworks info.
const String artworksJsonPath = "assets/data/artworks.json";

/// Table for [Artwork]s in database.
///
/// Class "Artwork" is auto-generated, by stripping the trailing "s" in the
/// table name. If a custom name is required, use @DataClassName("CustomName").
class Artworks extends Table {
  TextColumn get id => text()();

  // if primary key is not an autoIncrement IntColumn, it must be set like this
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get title => text().withLength(min: 1, max: 32)();

  TextColumn get year => text().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get artist =>
      text().nullable().customConstraint("NULL REFERENCES artists(name)")();

  // GSheets returns columns keys in all lowercase, so it's necessary to specify
  // the JsonKey below. Setting the column title in the spreadsheet as "file_name",
  // for example, does not help either, since GSheets removes the underscore
  @JsonKey("filename")
  TextColumn get fileName => text().nullable()();
}

/// Table for [Artist]s in database.
class Artists extends Table {
  TextColumn get name => text()();

  @JsonKey("yearbirth")
  TextColumn get yearBirth => text().nullable()();

  @JsonKey("yeardeath")
  TextColumn get yearDeath => text().nullable()();

  TextColumn get biography => text().nullable()();

  @JsonKey("filename")
  TextColumn get fileName => text().nullable()();

  @override
  Set<Column> get primaryKey => {name};
}

class Arts extends Table {
  IntColumn get artId => integer().autoIncrement()();

  @JsonKey("yearbirth")
  TextColumn get yearBirth => text().nullable()();

  @JsonKey("yeardeath")
  TextColumn get yearDeath => text().nullable()();

  TextColumn get photo => text().nullable()();
}

class ArtI18ns extends Table {
  IntColumn get id => integer().autoIncrement()();

  // no primary key?
  IntColumn get artId =>
      integer().customConstraint("NULL REFERENCES arts(art_id)")();

  // should specify json key
  TextColumn get languageCode => text()();

  TextColumn get name => text()();

  TextColumn get biography => text().nullable()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

/// Creates an instance of [AppDatabase] (lazily).
///
/// During the first use of [AppDatabase], it is automatically populated from a
/// Json file with the necessary information in assets.
@UseMoor(
    tables: [Artworks, Artists, Arts, ArtI18ns],
    daos: [ArtworksDao, ArtistsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// The schemaVersion number should be incremented whenever there is a change
  /// in any of the table definitions (also a migration policy must be declared
  /// below).
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          /// Enables foreign keys in the db.
          await customStatement("PRAGMA foreign_keys = ON");

          /// When db is first created, populate it from json files in assets.
          if (details.wasCreated) {
            // artists must be inserted first, since artist name is a foreign
            // key in artworks table
            await getLocalJsonItemList(artistsJsonPath)
                .then((artistEntries) => artistEntries.forEach((entry) {
                      var artist = Artist.fromJson(parseItemMap(entry));
                      into(artists).insertOnConflictUpdate(artist);
                      print("Created entry for artist ${artist.name}");
                    }));

            // insert artworks
            await getLocalJsonItemList(artworksJsonPath)
                .then((artworkEntries) => artworkEntries.forEach((entry) {
                      var artwork = Artwork.fromJson(parseItemMap(entry));
                      into(artworks).insertOnConflictUpdate(artwork);
                      print("Created entry for artwork \"${artwork.title}\" by "
                          "${artwork.artist}");
                    }));

            [1, 2, 3].forEach((id) {
              into(arts).insertOnConflictUpdate(
                  Art(artId: id, yearBirth: "1950", yearDeath: "2050"));
            });

            var count = 0;
            [1, 2, 3].forEach((id) {
              into(artI18ns).insertOnConflictUpdate(ArtI18n(
                  id: count, artId: id, languageCode: "en", name: "name"));

              count += 1;
              into(artI18ns).insertOnConflictUpdate(ArtI18n(
                  id: count, artId: id, languageCode: "el", name: "onoma"));
              count += 1;
            });
          }
        },
      );
}
