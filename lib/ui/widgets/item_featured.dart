import 'package:flutter/material.dart';
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
    return ItemTile.artwork(
      artwork: artwork,
      tileWidth: tileWidth,
      tileHeight: tileHeight,
      customHeroTag: artwork.title + "_featured",
    );
  }
}
