import 'package:flutter/material.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/tile.dart';
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
          Text("Artworks by ${artist.name}", style: TextStyle(fontSize: 25)),
          ArtworkListHorizontal(
              artworkList: Provider.of<ArtworksDao>(context)
                  .getArtworksByArtist(artist)),
        ],
      ),
    );
  }
}

class ArtworkListHorizontal extends StatelessWidget {
  const ArtworkListHorizontal({Key key, @required this.artworkList})
      : super(key: key);

  final Future<List<Artwork>> artworkList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FutureBuilder(
        future: artworkList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Artwork> artworks = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                return ItemTile.artwork(artwork: artworks[index]);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
