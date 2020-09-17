import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/artist_details_page.dart';
import 'package:modern_art_app/ui/widgets/artwork_details_page.dart';

/// Displays the provided image at [imagePath] in a tile with rounded corners.
class Tile extends StatelessWidget {
  /// Creates a tile with rounded corners displaying the provided image.
  ///
  /// The [imagePath] and [tileWidth] arguments must not be null. If [tileHeight]
  /// is not specified, it will be set to equal to [tileWidth], i.e. a square
  /// tile will be created.
  const Tile({
    Key key,
    @required this.imagePath,
    @required this.tileWidth,
    this.tileHeight,
    this.heroTag,
  }) : super(key: key);

  /// Path to the image to be displayed.
  final String imagePath;

  /// Desired width of the tile.
  final double tileWidth;

  /// Desired height of the tile.
  final double tileHeight;

  /// Desired hero tag for the image displayed in the tile.
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: tileWidth,
        height: tileHeight ?? tileWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Hero(
            tag: heroTag ?? imagePath,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays the provided [Artist] or [Artwork] as an image tile, which when
/// tapped takes the user to a details page showing more info about the
/// provided object.
///
/// If [tileHeight] is not specified, it will be set to equal [tileWidth], i.e.
/// a square tile will be created. If neither is provided, they will default to
/// a value equal to 20% of the current screen height.
class ItemTile extends StatelessWidget {
  /// Creates a tile with rounded corners displaying the provided [Artist].
  ItemTile.artist({
    Key key,
    @required Artist artist,
    this.tileWidth,
    this.tileHeight,
    String customHeroTag, // Optional custom hero tag
  })  : _title = artist.name,
        _subtitle = artist.yearBirth,
        _imgFileName = artist.fileName,
        _customHeroTag = customHeroTag ?? artist.name,
        _detailsPage = ArtistDetailsPage(artist: artist),
        super(key: key);

  /// Creates a tile with rounded corners displaying the provided [Artwork].
  ItemTile.artwork({
    Key key,
    @required Artwork artwork,
    this.tileWidth,
    this.tileHeight,
    String customHeroTag, // Optional custom hero tag
  })  : _title = artwork.title,
        _subtitle = artwork.year,
        _imgFileName = artwork.fileName,
        _customHeroTag = customHeroTag ?? artwork.id,
        _detailsPage = ArtworkDetailsPage(
          artwork: artwork,
          customHeroTag: customHeroTag ?? artwork.id,
        ),
        super(key: key);

  // todo add option to include title and subtitle below tiles
  final String _title;
  final String _subtitle;
  final String _imgFileName;
  final dynamic _detailsPage;

  /// Desired width of the tile.
  final double tileWidth;

  /// Desired height of the tile.
  final double tileHeight;

  final String _customHeroTag;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => _detailsPage));
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Tile(
              imagePath: _imgFileName,
              heroTag: _customHeroTag,
              tileWidth: tileWidth ?? MediaQuery.of(context).size.height * 0.2,
              tileHeight:
                  tileHeight ?? MediaQuery.of(context).size.height * 0.2,
            ),
          ),
        ),
      );
}
