import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/pages/artist_details_page.dart';
import 'package:modern_art_app/ui/pages/artwork_details_page.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';
import 'package:modern_art_app/utils/utils.dart';

class ItemRow extends StatelessWidget {
  ItemRow.artist({Key? key, required Artist artist, this.rowHeight})
      : title = artist.name!,
        subtitle = lifespan(artist),
        imgFileName = getArtistFilename(artist),
        _heroTag = artist.name!,
        detailsPage = ArtistDetailsPage(artist: artist),
        super(key: key);

  ItemRow.artwork({Key? key, required Artwork artwork, this.rowHeight})
      : title = artwork.name!,
        subtitle = "${artwork.artist}${artwork.year != "" ? ", "
            "${artwork.year}" : ""}",
        imgFileName = getArtworkFilename(artwork),
        _heroTag = artwork.id,
        detailsPage = ArtworkDetailsPage(artwork: artwork),
        super(key: key);

  final String title;
  final String subtitle;
  final String imgFileName;
  final double? rowHeight;
  final Widget detailsPage;
  final String _heroTag;

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => detailsPage),
            );
          },
          child: Row(
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
                        style: const TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
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
