import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_row.dart';
import 'package:modern_art_app/ui/widgets/item_tile.dart';

class ListHorizontal extends StatelessWidget {
  const ListHorizontal({
    Key? key,
    required this.itemList,
    this.listHeight,
  }) : super(key: key);

  // todo make input argument simple List
  final Stream<List<dynamic>> itemList;
  final double? listHeight;

  @override
  Widget build(BuildContext context) {
    final double height =
        listHeight ?? MediaQuery.of(context).size.height * 0.2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: height,
        child: StreamBuilder(
          stream: itemList,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              final List<dynamic> items = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  if (items[0].runtimeType == Artist) {
                    return ItemTile.artist(
                      artist: items[index] as Artist,
                      tileWidth: height,
                    );
                  } else {
                    return ItemTile.artwork(
                      artwork: items[index] as Artwork,
                      tileWidth: height,
                    );
                  }
                },
              );
            }
            return const Center(
              child: SpinKitRotatingPlain(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

class ListVertical extends StatelessWidget {
  const ListVertical({Key? key, required this.itemList}) : super(key: key);

  // todo make input argument simple List
  final Stream<List<dynamic>> itemList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: itemList,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final List<dynamic> items = snapshot.data!;
          return ListView.builder(
            // padding to account for the convex app bar
            padding: const EdgeInsets.only(bottom: 30.0),
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              if (items[0].runtimeType == Artist) {
                return ItemRow.artist(artist: items[index] as Artist);
              } else {
                return ItemRow.artwork(artwork: items[index] as Artwork);
              }
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
