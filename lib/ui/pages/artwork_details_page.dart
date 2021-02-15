import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:modern_art_app/utils/utils.dart';
import 'package:photo_view/photo_view.dart';

class ArtworkDetailsPage extends StatelessWidget {
  const ArtworkDetailsPage(
      {Key key, @required this.artwork, this.customHeroTag})
      : super(key: key);

  final Artwork artwork;
  final String customHeroTag;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(context.strings().artworkDetails),
      ),
      body: SingleChildScrollView(
        // padding to account for the convex app bar
        padding: const EdgeInsets.only(bottom: 30.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    // todo move the setup of Scaffold to ItemZoomPage below
                    appBar: AppBar(
                      // empty app bar so the back button is shown in
                      // the zoom page
                      backgroundColor:
                          ThemeData.dark().primaryColor.withOpacity(0.2),
                    ),
                    body: ItemZoomPage(
                      fileName: getArtworkFilename(artwork),
                      heroTag: customHeroTag ?? artwork.id,
                    ),
                  ),
                ),
              ),
              child: Hero(
                tag: customHeroTag ?? artwork.id,
                child: Container(
                  height: size.height * 0.55,
                  width: size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(getArtworkFilename(artwork)),
                          fit: BoxFit.contain)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                artwork.name,
                style: GoogleFonts.openSansCondensed(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
              child: Text(
                "${artwork.artist}" +
                    (artwork.year.isNotEmpty ? ", ${artwork.year}" : ""),
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.strings().description,
                style: GoogleFonts.openSansCondensed(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
              child: Text(
                artwork.description.isNotEmpty
                    ? artwork.description
                    : lorem(paragraphs: 2, words: 50),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemZoomPage extends StatelessWidget {
  final String fileName;
  final String heroTag;

  const ItemZoomPage({Key key, @required this.fileName, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      child: PhotoView(
        imageProvider: AssetImage(fileName),
        heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
      ),
    );
  }
}
