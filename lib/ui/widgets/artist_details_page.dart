import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/extensions.dart';
import 'package:modern_art_app/ui/widgets/item_list.dart';
import 'package:provider/provider.dart';

class ArtistDetailsPage extends StatelessWidget {
  const ArtistDetailsPage({Key key, this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // to change appbar color according to image, use below with futurebuilder
    // PaletteGenerator.fromImageProvider(AssetImage(artist.fileName));
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings().artistDetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: artist.name,
              child: Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(artist.fileName),
                  fit: BoxFit.fitHeight,
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 0.0),
              child: Text(artist.name, style: TextStyle(fontSize: 30)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                  artist.yearDeath.isNotEmpty
                      ? "${artist.yearBirth}–${artist.yearDeath}"
                      : artist.yearBirth,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 0.0),
              child: Text(context.strings().biography,
                  style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(artist.biography.isNotEmpty
                  ? artist.biography
                  : lorem(paragraphs: 1, words: 150)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 4.0),
              child: Text("${context.strings().artworksBy} ${artist.name}",
                  style: TextStyle(fontSize: 20)),
            ),
            ListHorizontal(
                itemList: Provider.of<ArtworksDao>(context)
                    .watchArtworksByArtist(artist)),
          ],
        ),
      ),
    );
  }
}
