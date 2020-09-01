import 'package:flutter/material.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/painting_list.dart';
import 'package:provider/provider.dart';

class ArtistDetailsPage extends StatelessWidget {
  const ArtistDetailsPage({Key key, this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artist details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: artist.name,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(artist.fileName), fit: BoxFit.cover),
                  shape: BoxShape.circle),
            ),
          ),
          Text(artist.name, style: TextStyle(fontSize: 30)),
          Text("Description", style: TextStyle(fontSize: 25)),
          Text(artist.biography),
          Text("Artworks by artist", style: TextStyle(fontSize: 25)),
          ArtistListHorizontal(artist: artist),
        ],
      ),
    );
  }
}

class ArtistListHorizontal extends StatelessWidget {
  const ArtistListHorizontal({Key key, @required this.artist})
      : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    ArtworksDao artworksDao = Provider.of<ArtworksDao>(context);
    return Container(
      height: 200,
      child: FutureBuilder(
        future: artworksDao.getArtworksByArtist(artist),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Artwork> artworks = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                return PaintingTile(
                  paintingName: artworks[index].title,
                  tileSideLength: 200,
                  path: artworks[index].fileName,
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
