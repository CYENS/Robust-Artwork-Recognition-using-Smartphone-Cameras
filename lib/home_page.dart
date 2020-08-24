import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/camera.dart';
import 'package:modern_art_app/main.dart';
import 'package:modern_art_app/painting_list.dart';
import 'package:modern_art_app/tensorflow/model_selection.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HomePage({Key key, @required this.cameras}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      IntroPage(),
      TakePictureScreen(cameras: widget.cameras),
      ModelSelection(cameras),
    ];
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Explore")),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera), title: Text("Identify")),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera), title: Text("Tensorflow")),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.45,
              width: size.width,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/pinakothiki_building.jpg",
                      fit: BoxFit.fitHeight,
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
