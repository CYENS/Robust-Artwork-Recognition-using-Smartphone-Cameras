import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_row.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';

class ArtworkList extends StatelessWidget {
  const ArtworkList({
    Key key,
    @required this.artworkList,
    Axis listScrollDirection,
  })  : _listScrollDirection = listScrollDirection ?? Axis.horizontal,
        super(key: key);

  final Future<List<Artwork>> artworkList;
  final Axis _listScrollDirection;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FutureBuilder(
        future: artworkList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Artwork> artworks = snapshot.data;
            return ListView.builder(
              scrollDirection: _listScrollDirection,
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                return _listScrollDirection == Axis.horizontal
                    ? ItemTile.artwork(artwork: artworks[index])
                    : ItemRow.artwork(artwork: artworks[index]);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
