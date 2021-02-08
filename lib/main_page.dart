import 'package:camera/camera.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/tensorflow/model_selection.dart';
import 'package:modern_art_app/ui/pages/explore_page.dart';
import 'package:modern_art_app/ui/pages/settings_page.dart';

import 'utils/extensions.dart';

class MainPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const MainPage({Key key, @required this.cameras}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey.currentState.canPop()) {
            _navigatorKey.currentState.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: "/",
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            // route names
            // todo move route names into a list? map?
            switch (settings.name) {
              case "/":
                builder = (BuildContext context) => ExplorePage();
                break;
              case "/identify":
                builder =
                    (BuildContext context) => ModelSelection(widget.cameras);
                break;
              case "/settings":
                builder = (BuildContext context) => SettingsPage();
                break;
              default:
                throw Exception("Invalid route: ${settings.name}");
            }
            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        backgroundColor: ThemeData.dark().primaryColor,
        initialActiveIndex: _currentIndex,
        items: [
          TabItem(icon: Icon(Icons.home), title: strings.nav.explore),
          TabItem(icon: Icon(Icons.camera), title: strings.nav.identify),
          TabItem(icon: Icon(Icons.settings), title: strings.stngs.title),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              _navigatorKey.currentState.pushNamed("/");
              break;
            case 1:
              _navigatorKey.currentState.pushNamed("/identify");
              break;
            case 2:
              _navigatorKey.currentState.pushNamed("/settings");
              break;
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
