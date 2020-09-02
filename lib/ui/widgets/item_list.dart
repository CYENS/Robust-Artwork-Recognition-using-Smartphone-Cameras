import 'package:flutter/material.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key key, @required this.artworkList}) : super(key: key);

  final Future<List<Artwork>> artworkList;

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
              scrollDirection: Axis.horizontal,
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                return ItemTile.artwork(artwork: artworks[index]);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
