import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'artists_dao.g.dart';

/// Data access object for [Artist] database related operations.
@UseDao(tables: [Artists, ArtistTranslations])
class ArtistsDao extends DatabaseAccessor<AppDatabase> with _$ArtistsDaoMixin {
  ArtistsDao(AppDatabase db) : super(db);

  /// Upsert [Artist] in db (insert if new, replace if exists already).
  Future<int> upsertArtist(Artist artist) =>
      into(artists).insertOnConflictUpdate(artist);

  /// Gets a stream of all artists in the db.
  Stream<List<Artist>> watchAllArtists({String languageCode = "en"}) =>
      (select(artists).join([
        leftOuterJoin(
            artistTranslations, artistTranslations.id.equalsExp(artists.id))
      ])
            ..where(artistTranslations.languageCode.equals(languageCode)))
          .map((e) {
        Artist artist = e.readTable(artists);
        return artist.copyWith(
            name: e.readTable(artistTranslations).name,
            biography: e.readTable(artistTranslations).biography);
      }).watch();

  /// Get artist by id.
  Future<Artist> getArtistById({
    required String artistId,
    String languageCode = "en",
  }) {
    return ((select(artists)..where((tbl) => tbl.id.equals(artistId))).join(
      [
        leftOuterJoin(
            artistTranslations, artistTranslations.id.equalsExp(artists.id))
      ],
    )..where(artistTranslations.languageCode.equals(languageCode)))
        .map(
      (e) {
        Artist artist = e.readTable(artists);
        ArtistTranslation translation = e.readTable(artistTranslations);
        return artist.copyWith(
          name: translation.name,
          biography: translation.biography,
        );
      },
    ).getSingle();
  }
}
