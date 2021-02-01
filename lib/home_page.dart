import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/tensorflow/model_selection.dart';
import 'package:modern_art_app/ui/pages/explore_page.dart';
import 'package:modern_art_app/ui/pages/settings_page.dart';

import 'utils/extensions.dart';

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
    final strings = context.strings();
    List<Widget> _screens = [
      ExplorePage(),
      ModelSelection(widget.cameras),
      SettingsPage(),
    ];
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: strings.nav.explore),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera), label: strings.nav.identify),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: strings.stngs.title),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
