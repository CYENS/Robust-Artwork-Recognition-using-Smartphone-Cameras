import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class IdentifyPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const IdentifyPage({Key key, this.cameras}) : super(key: key);

  @override
  _IdentifyPageState createState() => _IdentifyPageState();
}

class _IdentifyPageState extends State<IdentifyPage> {
  CameraController _controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      print("No camera found!");
    } else {
      // initialize camera controller
      _controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
        // we don't need audio in the app, so by passing false below, the
        // microphone permission is not requested from the user on Android;
        // on iOS the permission has to be manually specified, which was not
        // done for this app
        enableAudio: false,
      );

      _controller.initialize().then((_) {
        // check that the user has not navigated away
        if (!mounted) {
          return;
        }

        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    // dispose controller when user navigates away
    _controller?.dispose();
    print("camera controller disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      // todo show error message to user here
      return Container();
    }

    return CameraPreview(_controller);
  }
}
