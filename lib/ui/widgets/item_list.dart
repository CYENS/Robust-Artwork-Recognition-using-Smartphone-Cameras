import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_row.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';

class ListHorizontal extends StatelessWidget {
  const ListHorizontal({
    Key key,
    @required this.itemList,
    this.listHeight,
  }) : super(key: key);

  // todo make input argument simple List
  final Stream<List<dynamic>> itemList;
  final double listHeight;

  @override
  Widget build(BuildContext context) {
    double height = listHeight ?? MediaQuery.of(context).size.height * 0.2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: height,
        child: StreamBuilder(
          stream: itemList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> items = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return items[0].runtimeType == Artist
                      ? ItemTile.artist(artist: items[index], tileWidth: height)
                      : ItemTile.artwork(
                          artwork: items[index], tileWidth: height);
                },
              );
            }
            return const Center(
                child: SpinKitRotatingPlain(color: Colors.white, size: 50.0));
          },
        ),
      ),
    );
  }
}

class ListVertical extends StatelessWidget {
  const ListVertical({Key key, @required this.itemList}) : super(key: key);

  // todo make input argument simple List
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
            // padding to account for the convex app bar
            padding: const EdgeInsets.only(bottom: 30.0),
            physics: const BouncingScrollPhysics(),
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
