import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/painting_details_page.dart';
import 'package:modern_art_app/ui/widgets/artist_details_page.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';

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
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 20),
                    ),
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
