import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/extensions.dart';
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
      appBar: AppBar(
        title: Text(context.strings().artworkDetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemZoomPage(
                            fileName: artwork.fileName,
                            heroTag: customHeroTag ?? artwork.title,
                          ))),
              child: Hero(
                tag: customHeroTag ?? artwork.title,
                child: Container(
                  height: size.height * 0.6,
                  width: size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(artwork.fileName),
                          fit: BoxFit.fitHeight)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 0.0),
              child: Text(artwork.title, style: TextStyle(fontSize: 30)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                  "${artwork.artist}" +
                      (artwork.year.isNotEmpty ? ", ${artwork.year}" : ""),
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 0.0),
              child: Text(context.strings().description,
                  style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(artwork.description.isNotEmpty
                  ? artwork.description
                  : lorem(paragraphs: 2, words: 50)),
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
