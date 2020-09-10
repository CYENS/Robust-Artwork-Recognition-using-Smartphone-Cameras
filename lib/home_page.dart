import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/camera.dart';
import 'package:modern_art_app/explore_page.dart';
import 'package:modern_art_app/lang/localization.dart';
import 'package:modern_art_app/ui/widgets/settings_page.dart';

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
    final labels = AppLocalizations.of(context);
    List<Widget> _screens = [
      ExplorePage(),
      TakePictureScreen(cameras: widget.cameras),
      SettingsPage(),
    ];
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text(labels.nav.explore)),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera), title: Text(labels.nav.identify)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text(labels.nav.settings)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
