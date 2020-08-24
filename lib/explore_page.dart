import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  StreamSubscription<dynamic> _subscription;
  List<double> _accelerometerValues;
  List<double> _xValues = [];

  double _start = -50;

  @override
  void initState() {
    super.initState();
    _subscription = gyroscopeEvents.listen((event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        // get x acceleration sign (pos or neg)
//        double sign = event.x / event.x.abs();
        if (event.x < 0) {
          _start = _start < 0 ? _start + .5 : 0;
        } else {
          _start = _start > -50 ? _start - .5 : -50;
        }
      });
    });
//    _subscription = accelerometerEvents.listen((AccelerometerEvent event) {
//      setState(() {
//        _accelerometerValues = [event.x, event.y, event.z];
//        _xValues.add(event.x);
//        print(_accelerometerValues);
//      });
//    });
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        height: MediaQuery.of(context).size.height,
//        width: MediaQuery.of(context).size.width,
//        child: Stack(
//          children: [
//            Positioned(
//              child: Container(
//                height: MediaQuery.of(context).size.height + 200,
//                width: MediaQuery.of(context).size.width,
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_start.toString())
//      Text(_xValues
//          .reduce((value, element) => math.max(value, element))
//          .toString()),
        );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
