import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const HomePage({Key key, this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kratiki Pinakothiki"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: "Settings",
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Text("Welcome to Kratiki Pinakothiki"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: null,
      ),
    );
  }
}
