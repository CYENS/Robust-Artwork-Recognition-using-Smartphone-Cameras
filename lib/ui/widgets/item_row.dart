import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/artist_details_page.dart';
import 'package:modern_art_app/ui/widgets/artwork_details_page.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';

class ItemRow extends StatelessWidget {
  // todo make arguments private
  final String title;
  final String subtitle;
  final String imgFileName;
  final double rowHeight;
  final dynamic detailsPage;
  final String _heroTag;

  ItemRow.artist({Key key, @required Artist artist, this.rowHeight})
      : title = artist.name,
        subtitle = "${artist.yearBirth}–${artist.yearDeath}",
        imgFileName = artist.fileName,
        _heroTag = artist.name,
        detailsPage = ArtistDetailsPage(artist: artist),
        super(key: key);

  ItemRow.artwork({Key key, @required Artwork artwork, this.rowHeight})
      : title = artwork.title,
        subtitle = "${artwork.artist}" +
            (artwork.year != "" ? ", ${artwork.year}" : ""),
        imgFileName = artwork.fileName,
        _heroTag = artwork.id,
        detailsPage = ArtworkDetailsPage(artwork: artwork),
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
                  heroTag: _heroTag,
                  tileWidth:
                      rowHeight ?? MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
