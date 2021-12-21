import 'package:camera/camera.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/tensorflow/model_selection.dart';
import 'package:modern_art_app/ui/pages/explore_page.dart';
import 'package:modern_art_app/ui/pages/settings_page.dart';
import 'package:modern_art_app/utils/extensions.dart';

class MainPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const MainPage({Key? key, required this.cameras}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// The HeroController is needed for enabling Hero animations in the custom
  /// Navigator below, see this post https://stackoverflow.com/a/60729122
  late HeroController _heroController;

  /// The global [_navigatorKey] is necessary so that the nav bar can push
  /// routes to the navigator (the nav bar is located above/in another branch
  /// of the widget hierarchy from the navigator, and thus in another context,
  /// and so it cannot access the navigator using the usual
  /// Navigator.of(context) methods.
  final _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _heroController = HeroController(createRectTween: _createRectTween);
  }

  /// Used for enabling Hero animations in the custom Navigator.
  Tween<Rect?> _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    return Scaffold(
      body: WillPopScope(
        // wrapping the Navigator with a WillPopScope enables the correct
        // handling of the back button on Android
        onWillPop: () async {
          if (_navigatorKey.currentState != null) {
            if (_navigatorKey.currentState!.canPop()) {
              print("CAN POP");
              _navigatorKey.currentState!.pop();
              setState(() {
                _appBarKey.currentState!.animateTo(0);
                _currentIndex = 0;
              });
              return false;
            }
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          observers: [_heroController],
          initialRoute: Routes.explorePage,
          onGenerateRoute: (RouteSettings settings) {
            // navigator routes
            WidgetBuilder bldr;
            switch (settings.name) {
              case Routes.explorePage:
                bldr = (BuildContext context) => ExplorePage();
                break;
              case Routes.identifyPage:
                bldr = (BuildContext context) => ModelSelection(widget.cameras);
                break;
              case Routes.settingsPage:
                bldr = (BuildContext context) => SettingsPage();
                break;
              default:
                throw Exception("Invalid route: ${settings.name}");
            }
            return MaterialPageRoute(builder: bldr, settings: settings);
          },
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        key: _appBarKey,
        style: TabStyle.fixed,
        backgroundColor: Colors.grey.shade800,
        activeColor: Theme.of(context).colorScheme.secondary,
        elevation: 20,
        initialActiveIndex: _currentIndex,
        items: [
          TabItem(icon: Icons.home_rounded, title: strings.nav.explore),
          TabItem(icon: Icons.camera_rounded, title: strings.nav.identify),
          TabItem(icon: Icons.settings_rounded, title: strings.stngs.title),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // when the Explore tab is selected, remove everything else from
              // the navigator's stack
              _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                Routes.explorePage,
                (_) => false,
              );
              break;
            case 1:
              _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                Routes.identifyPage,
                ModalRoute.withName(Routes.explorePage),
              );
              break;
            case 2:
              // prevent multiple pushes of Settings page
              // if (_currentIndex != 2) {
              // here also remove everything else apart from "/"
              _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                Routes.settingsPage,
                ModalRoute.withName(Routes.explorePage),
              );
              // }
              break;
          }
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

class Routes {
  static const String explorePage = "/";
  static const String identifyPage = "/identify";
  static const String settingsPage = "/settings";
}
