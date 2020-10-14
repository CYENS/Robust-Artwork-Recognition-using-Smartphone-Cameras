import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:modern_art_app/tensorflow/tensorflow_camera.dart';
import 'package:modern_art_app/utils/utils.dart';
import 'package:tflite/tflite.dart';

import 'bbox.dart';
import 'models.dart';

class ModelSelection extends StatefulWidget {
  final List<CameraDescription> cameras;

  ModelSelection(this.cameras);

  @override
  _ModelSelectionState createState() => new _ModelSelectionState();
}

class _ModelSelectionState extends State<ModelSelection> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  int _inferenceTime = 0;
  String _model = "";
  var _recHistory = Map();
  var _recHistory2 = DefaultDict<double, List<String>>(() => []);
  var _recHistory3 = DefaultDict<String, List<double>>(() => []);

  @override
  void setState(VoidCallback fn) {
    // must check if mounted here before setting state, in case user navigates
    // away from the widget, since TensorFlowCamera may use setRecognitions for
    // setting the results of its the last inference, that most likely will
    // arrive after user navigated away (setState after dispose)
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  loadModelFromSettings() async {
    TfLiteModel model = tfLiteModels[_model];
    String res = await Tflite.loadModel(
      model: model.modelPath,
      labels: model.labelsPath,
    );
    print("$res loading model $_model, as specified in Settings");
  }

  onSelect(model) {
    setState(() {
      String preferredModel = Settings.getValue("key-cnn-type", mobileNetNoArt);
      _model = preferredModel;
    });
    loadModelFromSettings();
  }

  setRecognitions(recognitions, imageHeight, imageWidth, inferenceTime) {
    setState(() {
      _recHistory.addAll(Map<String, double>.fromIterable(
        recognitions,
        // each item in recognitions is a LinkedHashMap in the form of
        // {confidence: 0.5562283396720886, index: 15, label: untitled_votsis}
        key: (recognition) => recognition["label"],
        value: (recognition) => recognition["confidence"],
      ));
      recognitions.forEach((element) {
        _recHistory2[element["confidence"]].add(element["label"]);
        _recHistory3[element["label"]].add(element["confidence"]);
      });
      _recHistory3.forEach((key, value) {
        print("$key $value");
      });
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
      _inferenceTime = inferenceTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: _model == ""
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // RaisedButton(
                  //   child: const Text(ssd),
                  //   onPressed: () => onSelect(ssd),
                  // ),
                  // RaisedButton(
                  //   child: const Text(yolo),
                  //   onPressed: () => onSelect(yolo),
                  // ),
                  // RaisedButton(
                  //   child: const Text(mobilenet),
                  //   onPressed: () => onSelect(mobilenet),
                  // ),
                  // RaisedButton(
                  //   child: const Text(posenet),
                  //   onPressed: () => onSelect(posenet),
                  // ),
                  RaisedButton(
                    child: const Text(vgg19),
                    onPressed: () => onSelect(vgg19),
                  ),
                  RaisedButton(
                    child: const Text(vgg19Quant),
                    onPressed: () => onSelect(vgg19Quant),
                  ),
                  RaisedButton(
                    child: const Text(vgg19NoArtQuant),
                    onPressed: () => onSelect(vgg19NoArtQuant),
                  ),
                  RaisedButton(
                    child: const Text(vgg19ZeroOneMultiQuant),
                    onPressed: () => onSelect(vgg19ZeroOneMultiQuant),
                  ),
                  RaisedButton(
                    child: const Text(mobileNetNoArt),
                    onPressed: () => onSelect(mobileNetNoArt),
                  ),
                  RaisedButton(
                    child: const Text(mobileNetNoArtQuant),
                    onPressed: () => onSelect(mobileNetNoArtQuant),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                TensorFlowCamera(
                  widget.cameras,
                  setRecognitions,
                  _model,
                ),
                BBox(
                    _recognitions == null ? [] : _recognitions,
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model,
                    _inferenceTime),
              ],
            ),
    );
  }
}
