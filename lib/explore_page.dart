import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ExplorePageParallax extends StatefulWidget {
  @override
  _ExplorePageParallaxState createState() => _ExplorePageParallaxState();
}

class _ExplorePageParallaxState extends State<ExplorePageParallax> {
  StreamSubscription<dynamic> _subscription;
  List<double> _accelerometerValues;
  List<double> _xValues = [];

  double _offset = 100;
  double _start = -320;
  double _sign = 0;
  Size _screenSize;

  @override
  void initState() {
    super.initState();
    _subscription = accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        _xValues.add(event.x);
        if (_xValues.length > 15) {
          _xValues.removeAt(0);
        }
        double mean = _xValues.reduce((value, element) => value + element) /
            _xValues.length;
        // get x acceleration sign (pos or neg)
        _sign = event.x / event.x.abs();

        if (mean < 0) {
          _start = _start < 0 ? _start + 1 : 0;
        } else {
          _start = _start > -640 ? _start - 1 : -640;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    double scale = 1280 / 960;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: _screenSize.height,
          width: _screenSize.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: _start,
                child: Container(
                  height: _screenSize.height,
                  width: _screenSize.height * scale,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/pinakothiki_building.jpg"),
                          fit: BoxFit.fitHeight)),
                ),
              ),
              Center(child: Text("$_start $_sign\n$_xValues")),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
