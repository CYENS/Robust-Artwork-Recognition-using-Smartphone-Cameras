import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// to auto-generate necessary code, run the following in the terminal:
// 'flutter packages pub run build_runner build'
// or the following to continuously regenerate code when code changes
// 'flutter packages pub run build_runner watch'

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class Artworks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 2, max: 32)();

  TextColumn get year => text().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get artist =>
      text().nullable().customConstraint("NULL REFERENCES artists(name)")();

  @JsonKey("file_name")
  TextColumn get fileName => text().nullable()();
}

// Class "Artist" is automatically generated, by stripping the trailing "s" in
// the table name. If a custom name is required, use @DataClassName("CustomName").
class Artists extends Table {
  TextColumn get name => text()();

  TextColumn get yearBirth => text().nullable()();

  TextColumn get yearDeath => text().nullable()();

  TextColumn get biography => text().nullable()();

  TextColumn get fileName => text().nullable()();

  @override
  Set<Column> get primaryKey => {name};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Artworks, Artists])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  /// Enable foreign keys.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement("PRAGMA foreign_keys = ON");
        },
      );

  // loads all artworks
  Future<List<Artwork>> get allArtworkEntries => select(artworks).get();

  Stream<List<Artwork>> get watchAllArtworkEntries => select(artworks).watch();

  // watches all artwork entries for a given painter. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<List<Artwork>> watchArtworksByArtist(Artist a) {
    return (select(artworks)..where((p) => p.artist.equals(a.name))).watch();
  }

  // returns the generated id
  Future<int> addArtwork(ArtworksCompanion entry) {
    return into(artworks).insert(entry);
  }
}
