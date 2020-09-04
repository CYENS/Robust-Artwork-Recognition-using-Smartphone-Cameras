import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/data/artists_dao.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/data_processing.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_list.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArtistsDao artistsDao = Provider.of<ArtistsDao>(context);
    ArtworksDao artworksDao = Provider.of<ArtworksDao>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Artworks"),
        actions: [
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      MoorDbViewer(Provider.of<AppDatabase>(context))))),
          IconButton(
            icon: Icon(Icons.http),
            onPressed: () => updateDbFromGSheets(artworksDao, artistsDao),
          )
        ],
      ),
      body: ListVertical(itemList: artistsDao.watchAllArtistEntries),
    );
  }
}

Card _card(Artist artist) => Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Image.asset(artist.fileName),
          ListTile(
            title: Text(artist.name),
            subtitle: Text(artist.biography),
          ),
        ],
      ),
    );
