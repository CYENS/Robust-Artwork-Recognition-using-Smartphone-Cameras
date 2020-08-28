import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'artworks_dao.g.dart';

/// Data access object for [Artwork] database related operations.
@UseDao(tables: [Artworks])
class ArtworksDao extends DatabaseAccessor<AppDatabase>
    with _$ArtworksDaoMixin {
  ArtworksDao(AppDatabase db) : super(db);

  /// Gets a list of all artworks in the db.
  Future<List<Artwork>> get allArtworkEntries => select(artworks).get();

  /// Gets a live stream of all artworks in the db (automatically emits new items
  /// whenever the underlying data changes).
  Stream<List<Artwork>> get watchAllArtworkEntries => select(artworks).watch();

  /// Gets a live stream of all artworks for a given painter
  Stream<List<Artwork>> watchArtworksByArtist(Artist artist) {
    return (select(artworks)
          ..where((artwork) => artwork.artist.equals(artist.name)))
        .watch();
  }

  /// Safely insert an [Artwork] into db, with the use of an [ArtworksCompanion].
  /// Returns the generated [Artwork] id.
  Future<int> addCArtwork(ArtworksCompanion artworkC) {
    return into(artworks).insert(artworkC);
  }

  /// Upsert [Artwork] in db (insert if new, replace if exists already). Returns
  /// the generated/replaced [Artwork] id.
  Future<int> upsertArtwork(Artwork artwork) {
    return into(artworks).insertOnConflictUpdate(artwork);
  }
}
