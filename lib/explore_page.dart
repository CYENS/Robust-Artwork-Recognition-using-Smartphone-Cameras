import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:modern_art_app/data/artists_dao.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_featured.dart';
import 'package:modern_art_app/ui/widgets/item_list.dart';
import 'package:provider/provider.dart';

import 'extensions.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ArtworksDao artworksDao = Provider.of<ArtworksDao>(context);
    ArtistsDao artistsDao = Provider.of<ArtistsDao>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        "assets/pinakothiki_building.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      // add gradient in front of building photo to make text in
                      // front of it legible, based on the example provided here
                      // https://api.flutter.dev/flutter/widgets/Stack-class.html
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black.withAlpha(0),
                            Colors.black12,
                            Colors.black38,
                            Colors.black
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: Text(
                          "Κρατική Πινακοθήκη\nΣύγχρονης Κυπριακής Τέχνης",
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: headline(context.strings().artworkOfTheWeek),
              ),
              FutureBuilder(
                  future: artworksDao.allArtworkEntries,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Artwork> artworks = snapshot.data;
                      return FeaturedTile(
                        artwork:
                            artworks[math.Random().nextInt(artworks.length)],
                        tileHeight: size.height * 0.35,
                        tileWidth: size.width,
                      );
                    }
                    return Container();
                  }),
              HeadlineAndMoreRow(
                  listType: "Artworks",
                  itemList: artworksDao.watchAllArtworkEntries),
              ListHorizontal(itemList: artworksDao.watchAllArtworkEntries),
              HeadlineAndMoreRow(
                  listType: "Artists",
                  itemList: artistsDao.watchAllArtistEntries),
              ListHorizontal(itemList: artistsDao.watchAllArtistEntries),
            ],
          ),
        ),
      ),
    );
  }
}

class HeadlineAndMoreRow extends StatelessWidget {
  final String listType;
  final Stream<List<dynamic>> itemList;

  const HeadlineAndMoreRow({Key key, @required this.listType, this.itemList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = context.strings();
    // TODO: fix this
    String title = listType == "Artists" ? strings.artists : strings.artworks;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
      child: Row(
        children: [
          headline(title),
          Spacer(),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(title: Text(title)),
                              body: ListVertical(itemList: itemList),
                            )));
              },
              child: Text(strings.button.more))
        ],
      ),
    );
  }
}

Widget headline(String text) => Text(
      text.customToUpperCase(),
      style: Typography.whiteMountainView.headline1.copyWith(fontSize: 20),
    );
