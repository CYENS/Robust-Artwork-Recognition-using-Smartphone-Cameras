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
class Paintings extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 2, max: 32)();

  TextColumn get description => text().named('body')();

  IntColumn get painter => integer().nullable()();

  TextColumn get fileName => text().nullable()();
}

// Class "Painter" is automatically generated, by stripping the the trailing "s"
// in the table name. If a custom name is required, use @DataClassName("CustomName").
class Painters extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get yearBirth => text().nullable()();

  TextColumn get yearDeath => text().nullable()();

  TextColumn get biography => text()();
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

@UseMoor(tables: [Paintings, Painters])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  // loads all paintings
  Future<List<Painting>> get allPaintingEntries => select(paintings).get();

  Stream<List<Painting>> get watchAllPaintingEntries =>
      select(paintings).watch();

  // watches all painting entries for a given painter. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<List<Painting>> watchPaintingsByPainter(Painter c) {
    return (select(paintings)..where((p) => p.painter.equals(c.id))).watch();
  }

  // returns the generated id
  Future<int> addPainting(PaintingsCompanion entry) {
    return into(paintings).insert(entry);
  }
}
