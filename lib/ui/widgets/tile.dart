import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  }) : super(key: key);

  /// Path to the image to be displayed.
  final String imagePath;

  /// Desired width of the tile.
  final double tileWidth;

  /// Desired height of the tile.
  final double tileHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: tileWidth,
        height: tileHeight ?? tileWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Hero(
            tag: imagePath,
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
