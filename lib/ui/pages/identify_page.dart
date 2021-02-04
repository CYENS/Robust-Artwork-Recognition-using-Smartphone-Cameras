import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/tensorflow/models.dart';
import 'package:modern_art_app/ui/pages/artwork_details_page.dart';
import 'package:modern_art_app/ui/pages/settings_page.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

class IdentifyPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const IdentifyPage({Key key, this.cameras}) : super(key: key);

  @override
  _IdentifyPageState createState() => _IdentifyPageState();
}

class _IdentifyPageState extends State<IdentifyPage> {
  CameraController _controller;
  bool _busy = false;
  String _model = "";

  // initTfLiteModel() {
  //   String preferredModel = Settings.getValue(keyCnnModel, mobileNetNoArt);
  //   setState(() => _model = preferredModel);
  //   loadModel();
  // }

  Future loadModel() async {
    print("LOADING MODEL++++++++++++++++++++++++++++++");
    Tflite.close();
    String preferredModel = Settings.getValue(keyCnnModel, mobileNetNoArt);
    TfLiteModel model = tfLiteModels[preferredModel];
    String result = await Tflite.loadModel(
      // todo modelPath is called on null on first launch, before getting camera permission?
      model: model.modelPath,
      labels: model.labelsPath,
    );
    setState(() => _model = preferredModel);
    print("$result loading model $_model, as specified in Settings");
  }

  @override
  void initState() {
    super.initState();

    _busy = true;

    // Steps that have to happen:
    // - init model
    // - init camera controller (this on first launch triggers asking for camera permission?)
    // Which order should they happen in?

    // initTfLiteModel();
    loadModel().then((_) => setState(() {
          _busy = false;
        }));

    // todo here should make sure the model was initialized?
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
          // todo if setState is overridden like in model_selection, this may be unnecessary?
          return;
        }

        setState(() {});

        _controller.startImageStream((CameraImage img) {
          print("NEW FRAME...............................");
          if (!_busy) {
            _busy = true;

            Tflite.runModelOnFrame(
              bytesList: img.planes.map((plane) => plane.bytes).toList(),
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: 127.5,
              imageStd: 127.5,
              numResults: 1,
            ).then((recognitions) {
              print("Inference for ${recognitions[0]['label']}");
              if (recognitions[0]['label'] != "no_artwork") {
                _busy = true;
                if (_controller.value.isStreamingImages) {
                  _controller.stopImageStream();
                }
                _controller.dispose();
                Tflite.close();
                Provider.of<ArtworksDao>(context, listen: false)
                    .getArtworkById(
                        artworkId: recognitions[0]['label'],
                        languageCode: context.locale().languageCode)
                    .then((artwork) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArtworkDetailsPage(artwork: artwork)),
                        ));
              }
            });

            _busy = false;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    // dispose controller when user navigates away
    _controller?.dispose();
    // Tflite?.close();
    print("camera controller disposed");
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    // checks that page is still mounted before calling setState, to avoid
    // "setState after dispose" errors
    if (mounted) {
      print("SET STATE!!!!!!!!!!!!!!!!!!!!!");
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      // todo show error message to user here
      return Container();
    }

    // the following logic does not work properly when camera preview is in
    // landscape, see this issue https://github.com/flutter/flutter/issues/29951
    // todo fix preview orientation issue
    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = _controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(_controller),
    );
  }
}
