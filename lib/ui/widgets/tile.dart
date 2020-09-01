import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/painting_details_page.dart';
import 'package:modern_art_app/ui/widgets/artist_details_page.dart';

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

class ArtistTile extends StatelessWidget {
  const ArtistTile({Key key, this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArtistDetailsPage(
                      artist: artist,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Tile(
          imagePath: artist.fileName,
          tileWidth: 100,
          heroTag: artist.name,
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgFileName;
  final double rowHeight;
  final dynamic detailsPage;

  ItemRow.artist({Key key, @required Artist artist, this.rowHeight})
      : title = artist.name,
        subtitle = artist.yearBirth,
        imgFileName = artist.fileName,
        detailsPage = ArtistDetailsPage(artist: artist),
        super(key: key);

  ItemRow.artwork({Key key, @required Artwork artwork, this.rowHeight})
      : title = artwork.title,
        subtitle = artwork.year,
        imgFileName = artwork.fileName,
        detailsPage = PaintingDetailsPage(
          path: artwork.fileName,
          name: artwork.title,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => detailsPage));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Tile(
                  imagePath: imgFileName,
                  heroTag: title,
                  tileWidth:
                      rowHeight ?? MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(title, style: TextStyle(fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(subtitle),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
