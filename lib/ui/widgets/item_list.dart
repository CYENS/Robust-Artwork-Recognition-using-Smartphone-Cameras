import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_row.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';

class ListHorizontal extends StatelessWidget {
  const ListHorizontal({
    Key key,
    @required this.itemList,
    this.listHeight,
  }) : super(key: key);

  final Stream<List<dynamic>> itemList;
  final double listHeight;

  @override
  Widget build(BuildContext context) {
    double height = listHeight ?? MediaQuery.of(context).size.height * 0.2;
    return Container(
      height: height,
      child: StreamBuilder(
        stream: itemList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> items = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return items[0].runtimeType == Artist
                    ? ItemTile.artist(artist: items[index], tileWidth: height)
                    : ItemTile.artwork(
                        artwork: items[index], tileWidth: height);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListVertical extends StatelessWidget {
  const ListVertical({Key key, @required this.itemList}) : super(key: key);

  final Stream<List<dynamic>> itemList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: itemList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> items = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[0].runtimeType == Artist
                  ? ItemRow.artist(artist: items[index])
                  : ItemRow.artwork(artwork: items[index]);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
