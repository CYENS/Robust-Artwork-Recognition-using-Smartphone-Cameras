import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'artists_dao.g.dart';

/// Data access object for [Artist] database related operations.
@UseDao(tables: [Artists])
class ArtistsDao extends DatabaseAccessor<AppDatabase> with _$ArtistsDaoMixin {
  ArtistsDao(AppDatabase db) : super(db);

  /// Upsert [Artist] in db (insert if new, replace if exists already).
  Future<int> upsertArtist(Artist artist) {
    return into(artists).insertOnConflictUpdate(artist);
  }
}
