import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';

class FeaturedTile extends StatelessWidget {
  const FeaturedTile({Key key, this.artwork, this.tileWidth, this.tileHeight})
      : super(key: key);

  final Artwork artwork;

  /// Desired width of the tile.
  final double tileWidth;

  /// Desired height of the tile.
  final double tileHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        ItemTile.artwork(
          artwork: artwork,
          tileWidth: tileWidth,
          tileHeight: tileHeight,
          customHeroTag: artwork.name + "_featured",
        ),
        Container(
          color: Colors.black45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: artwork.name,
                        style: TextStyle(
                            fontSize: 28, fontStyle: FontStyle.normal),
                      ),
                      TextSpan(
                        text: " by " + artwork.artist,
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
