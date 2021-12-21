import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modern_art_app/utils/extensions.dart';

class DemoIdentifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var strings = context.strings();
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(strings.msg.pointTheCamera, maxLines: 1),
        backgroundColor: ThemeData.dark().primaryColor.withOpacity(0.2),
      ),
      body: OverflowBox(
        maxHeight: screen.height - 20,
        maxWidth: screen.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/example_frame.webp",
              fit: BoxFit.fitHeight,
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Analysing...",
                      style: TextStyle(fontSize: 16),
                    ),
                    SpinKitThreeBounce(
                      color: Colors.white,
                      size: screen.width / 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
