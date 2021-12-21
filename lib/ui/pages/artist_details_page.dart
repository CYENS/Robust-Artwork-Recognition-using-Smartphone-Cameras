import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/ui/widgets/item_list.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:modern_art_app/utils/utils.dart';
import 'package:provider/provider.dart';

class ArtistDetailsPage extends StatelessWidget {
  const ArtistDetailsPage({Key? key, required this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // to change appbar color according to image, use below with futurebuilder
    // PaletteGenerator.fromImageProvider(AssetImage(artist.fileName));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(context.strings().artistDetails),
      ),
      body: SingleChildScrollView(
        // padding to account for the convex app bar
        padding: const EdgeInsets.only(bottom: 30.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: artist.name!,
              child: Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(getArtistFilename(artist)),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                artist.name!,
                style: GoogleFonts.openSansCondensed(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
              child: Text(
                lifespan(artist),
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.strings().biography,
                style: GoogleFonts.openSansCondensed(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
              child: Text(
                artist.biography ?? '',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${context.strings().artworksBy} ${artist.name}",
                style: GoogleFonts.openSansCondensed(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4.0),
              child: ListHorizontal(
                itemList: Provider.of<ArtworksDao>(context)
                    .watchArtworksByArtist(
                        artistId: artist.id,
                        languageCode: context.locale().languageCode),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
