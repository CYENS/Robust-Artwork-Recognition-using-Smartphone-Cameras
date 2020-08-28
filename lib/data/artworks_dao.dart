import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'artworks_dao.g.dart';

@UseDao(tables: [Artworks])
class ArtworksDao extends DatabaseAccessor<AppDatabase>
    with _$ArtworksDaoMixin {
  ArtworksDao(AppDatabase db) : super(db);

  // loads all artworks
  Future<List<Artwork>> get allArtworkEntries => select(artworks).get();

  Stream<List<Artwork>> get watchAllArtworkEntries => select(artworks).watch();

  // watches all artwork entries for a given painter. The stream will automatically
  // emit new items whenever the underlying data changes.
  Stream<List<Artwork>> watchArtworksByArtist(Artist a) {
    return (select(artworks)..where((p) => p.artist.equals(a.name))).watch();
  }

  // returns the generated id
  Future<int> addCArtwork(ArtworksCompanion entry) {
    return into(artworks).insert(entry);
  }

  Future<int> upsertArtwork(Artwork entry) {
    return into(artworks).insertOnConflictUpdate(entry);
  }
}
