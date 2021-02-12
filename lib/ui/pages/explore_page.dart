import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_art_app/data/artists_dao.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/ui/widgets/item_featured.dart';
import 'package:modern_art_app/ui/widgets/item_list.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArtworksDao artworksDao = Provider.of<ArtworksDao>(context);
    ArtistsDao artistsDao = Provider.of<ArtistsDao>(context);
    Size size = MediaQuery.of(context).size;
    final strings = context.strings();
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              onStretchTrigger: () {
                return;
              },
              expandedHeight: size.height * 0.3,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                title: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AutoSizeText(
                    strings.galleryName.customToUpperCase(),
                    style: GoogleFonts.openSansCondensed(fontSize: 28),
                    textAlign: TextAlign.end,
                    maxFontSize: 30,
                    maxLines: 2,
                  ),
                ),
                centerTitle: true,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/pinakothiki_building.webp",
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
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
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline(context.strings().featuredArtwork),
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
                  Padding(
                    // padding to account for the convex app bar
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: ListHorizontal(
                        itemList: artistsDao.watchAllArtists(
                            languageCode: context.locale().languageCode)),
                  ),
                  // Spacer
                ],
              ),
            ),
          ],
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
            icon: Icon(Icons.arrow_forward_rounded),
            tooltip: strings.button.more,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: Text(title)),
                    body: ListVertical(itemList: itemList),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget headline(String text) => Text(
      text.customToUpperCase(),
      style: GoogleFonts.openSansCondensed(fontSize: 25),
    );
