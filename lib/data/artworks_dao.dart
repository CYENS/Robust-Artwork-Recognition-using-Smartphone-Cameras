import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'artworks_dao.g.dart';

/// Data access object for [Artwork] database related operations.
@UseDao(tables: [Artworks, ArtworkTranslations, ArtistTranslations])
class ArtworksDao extends DatabaseAccessor<AppDatabase>
    with _$ArtworksDaoMixin {
  ArtworksDao(AppDatabase db) : super(db);

  /// Gets a list of all artworks in the db.
  Future<List<Artwork>> get allArtworkEntries => select(artworks).get();

  /// Gets a live stream of all artworks in the db (automatically emits new items
  /// whenever the underlying data changes).
  Stream<List<Artwork>> watchAllArtworks({String languageCode = "en"}) =>
      (select(artworks).join([
        leftOuterJoin(
            artworkTranslations, artworkTranslations.id.equalsExp(artworks.id)),
        leftOuterJoin(artistTranslations,
            artistTranslations.id.equalsExp(artworks.artistId))
      ])
            ..where(artworkTranslations.languageCode.equals(languageCode) &
                artistTranslations.languageCode.equals(languageCode)))
          .map((e) => composeTranslatedArtwork(
              artwork: e.readTable(artworks),
              artworkTranslation: e.readTable(artworkTranslations),
              artistTranslation: e.readTable(artistTranslations)))
          .watch();

  /// Gets a list of all [Artwork]s for a given [Artist].
  Stream<List<Artwork>> watchArtworksByArtist({
    required String artistId,
    String languageCode = "en",
  }) =>
      ((select(artworks)..where((artwork) => artwork.artistId.equals(artistId)))
              .join(
        [
          leftOuterJoin(
            artworkTranslations,
            artworkTranslations.id.equalsExp(artworks.id),
          ),
          leftOuterJoin(
            artistTranslations,
            artistTranslations.id.equalsExp(artworks.artistId),
          )
        ],
      )..where(artworkTranslations.languageCode.equals(languageCode) &
              artistTranslations.languageCode.equals(languageCode)))
          .map(
            (e) => composeTranslatedArtwork(
              artwork: e.readTable(artworks),
              artworkTranslation: e.readTable(artworkTranslations),
              artistTranslation: e.readTable(artistTranslations),
            ),
          )
          .watch();

  /// Get artwork by id.
  Future<Artwork> getArtworkById({
    required String artworkId,
    String languageCode = "en",
  }) =>
      ((select(artworks)..where((tbl) => tbl.id.equals(artworkId))).join(
        [
          leftOuterJoin(
            artworkTranslations,
            artworkTranslations.id.equalsExp(artworks.id),
          ),
          leftOuterJoin(
            artistTranslations,
            artistTranslations.id.equalsExp(artworks.artistId),
          ),
        ],
      )..where(artworkTranslations.languageCode.equals(languageCode) &
              artistTranslations.languageCode.equals(languageCode)))
          .map(
            (e) => composeTranslatedArtwork(
              artwork: e.readTable(artworks),
              artworkTranslation: e.readTable(artworkTranslations),
              artistTranslation: e.readTable(artistTranslations),
            ),
          )
          .getSingle();

  /// Safely insert an [Artwork] into db, with the use of an [ArtworksCompanion].
  /// Returns the generated [Artwork] id.
  Future<int> addCArtwork(ArtworksCompanion artworkC) =>
      into(artworks).insert(artworkC);

  /// Upsert [Artwork] in db (insert if new, replace if exists already). Returns
  /// the generated/replaced [Artwork] id.
  Future<int> upsertArtwork(Artwork artwork) =>
      into(artworks).insertOnConflictUpdate(artwork);
}

Artwork composeTranslatedArtwork({
  required Artwork artwork,
  required ArtworkTranslation artworkTranslation,
  required ArtistTranslation artistTranslation,
}) =>
    artwork.copyWith(
      name: artworkTranslation.name,
      description: artworkTranslation.description,
      artist: artistTranslation.name,
    );
