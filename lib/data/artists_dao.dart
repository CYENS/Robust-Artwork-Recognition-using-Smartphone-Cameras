import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'artists_dao.g.dart';

/// Data access object for [Artist] database related operations.
@UseDao(tables: [Artists])
class ArtistsDao extends DatabaseAccessor<AppDatabase> with _$ArtistsDaoMixin {
  ArtistsDao(AppDatabase db) : super(db);

  /// Upsert [Artist] in db (insert if new, replace if exists already).
  Future<int> upsertArtist(Artist artist) =>
      into(artists).insertOnConflictUpdate(artist);

  /// Gets a list of all artists in the db.
  Future<List<Artist>> get allArtistEntries => select(artists).get();

  /// Gets a stream of all artists in the db.
  Stream<List<Artist>> get watchAllArtistEntries => select(artists).watch();
}
