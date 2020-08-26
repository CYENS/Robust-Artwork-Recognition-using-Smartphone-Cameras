import 'package:flutter/material.dart';
import 'package:modern_art_app/painting_list.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: size.height * 0.3,
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
              HeadlineAndMoreRow(listType: "Painting"),
              PaintingListHorizontal(listType: "Painting"),
              HeadlineAndMoreRow(listType: "Painter"),
              PaintingListHorizontal(listType: "Painter"),
            ],
          ),
        ),
      ),
    );
  }
}

class HeadlineAndMoreRow extends StatelessWidget {
  final String listType;

  const HeadlineAndMoreRow({Key key, @required this.listType})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headline("${listType}s"),
            Spacer(),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaintingListVertical(
                                listType: listType,
                              )));
                },
                child: Text("more"))
          ],
        ),
      );
}

Widget headline(String text) => Text(
      text.toUpperCase(),
      style: Typography.whiteMountainView.headline1.copyWith(fontSize: 20),
    );
