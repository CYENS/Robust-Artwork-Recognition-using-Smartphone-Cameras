import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String imagePath;

  const DetailsScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Painting details")),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "The Mona Lisa",
          style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
        ),
        Text("by Leonardo da Vinci, 1503–1506"),
        Align(
          child: AspectRatio(
            aspectRatio: 1 / 0.9,
            child: Image.asset("Mona_Lisa.jpg"),
          ),
        ),
      ]),
    );
  }
}
