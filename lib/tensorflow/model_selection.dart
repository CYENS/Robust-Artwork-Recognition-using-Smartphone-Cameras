import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/tensorflow/tensorflow_camera.dart';
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
  String _model = "";
  var _recHistory = Map();

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

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/tflite/other/yolov2_tiny.tflite",
          labels: "assets/tflite/other/yolov2_tiny.txt",
        );
        break;

      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/tflite/other/mobilenet_v1_1.0_224.tflite",
            labels: "assets/tflite/other/mobilenet_v1_1.0_224.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model:
                "assets/tflite/other/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      case modernArt:
        res = await Tflite.loadModel(
            model: "assets/tflite/cnn224RGB_VGG19.tflite",
            labels: "assets/tflite/cnn224RGB_VGG19_labels.txt");
        break;

      case modernArtQuant:
        res = await Tflite.loadModel(
            model: "assets/tflite/cnn224RGB_VGG19_quant.tflite",
            labels: "assets/tflite/cnn224RGB_VGG19_labels.txt");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/tflite/other/ssd_mobilenet.tflite",
            labels: "assets/tflite/other/ssd_mobilenet.txt");
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recHistory.addAll(Map<String, double>.fromIterable(
        recognitions,
        // each item in recognitions is a LinkedHashMap in the form of
        // {confidence: 0.5562283396720886, index: 15, label: untitled_votsis}
        key: (recognition) => recognition["label"],
        value: (recognition) => recognition["confidence"],
      ));
      print(_recHistory);
      recognitions.forEach((element) {
        print(element);
      });
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
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
                    child: const Text(modernArt),
                    onPressed: () => onSelect(modernArt),
                  ),
                  RaisedButton(
                    child: const Text(modernArtQuant),
                    onPressed: () => onSelect(modernArtQuant),
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
                    _model),
              ],
            ),
    );
  }
}
