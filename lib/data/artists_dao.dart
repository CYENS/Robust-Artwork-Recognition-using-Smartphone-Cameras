import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'artists_dao.g.dart';

@UseDao(tables: [Artists])
class ArtistsDao extends DatabaseAccessor<AppDatabase> with _$ArtistsDaoMixin {
  ArtistsDao(AppDatabase db) : super(db);

  Future<int> upsertArtist(Artist entry) {
    return into(artists).insertOnConflictUpdate(entry);
  }
}
