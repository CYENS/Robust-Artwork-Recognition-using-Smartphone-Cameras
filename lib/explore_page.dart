import 'package:flutter/material.dart';
import 'package:modern_art_app/data/artists_dao.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/ui/widgets/item_featured.dart';
import 'package:modern_art_app/ui/widgets/item_list.dart';
import 'package:provider/provider.dart';

import 'utils/extensions.dart';

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
                          context.strings().galleryName,
                          style: TextStyle(fontSize: 28),
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
                  future: artworksDao.getArtworkById(
                      artworkId: "the_cyclist_votsis",
                      languageCode: context.locale().languageCode),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FeaturedTile(
                        artwork: snapshot.data,
                        tileHeight: size.height * 0.35,
                        tileWidth: size.width,
                      );
                    }
                    return Container();
                  }),
              HeadlineAndMoreRow(
                  listType: "Artworks",
                  itemList: artworksDao.watchAllArtworks(
                      languageCode: context.locale().languageCode)),
              ListHorizontal(
                  itemList: artworksDao.watchAllArtworks(
                      languageCode: context.locale().languageCode)),
              HeadlineAndMoreRow(
                  listType: "Artists",
                  itemList: artistsDao.watchAllArtists(
                      languageCode: context.locale().languageCode)),
              ListHorizontal(
                  itemList: artistsDao.watchAllArtists(
                      languageCode: context.locale().languageCode)),
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
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
      child: Row(
        children: [
          headline(title),
          Spacer(),
          IconButton(
              icon: Icon(Icons.arrow_forward),
              tooltip: strings.button.more,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(title: Text(title)),
                              body: ListVertical(itemList: itemList),
                            )));
              }),
        ],
      ),
    );
  }
}

Widget headline(String text) => Text(
      text.customToUpperCase(),
      style: Typography.whiteMountainView.headline1.copyWith(fontSize: 20),
    );
