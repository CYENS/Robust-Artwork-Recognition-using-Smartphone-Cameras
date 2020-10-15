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
  var _history = [];
  var _recHistory = DefaultDict<String, List<double>>(() => []);
  var _currentTopInference = "Calculating...";

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
      recognitions.forEach((element) {
        // each item in recognitions is a LinkedHashMap in the form of
        // {confidence: 0.5562283396720886, index: 15, label: untitled_votsis}
        _recHistory[element["label"]].add(element["confidence"]);
        _history.add(element);
      });
      // calculate means every 5 inferences, ignore first 5
      if (_history.length % 5 == 0 && _history.length != 5) {
        print("Number of results ${_history.length}");
        _recHistory.forEach((key, value) {
          print("$key $value");
        });
        var means = <String, double>{
          for (var entry in _recHistory.entries)
            entry.key: entry.value.reduce((a, b) => a + b) / entry.value.length,
        };

        var sortedByMean = means.keys.toList(growable: false)
          ..sort((k1, k2) => means[k1].compareTo(means[k2]));

        if (sortedByMean.length >= 1) {
          _currentTopInference = sortedByMean.last;
        }

        print(sortedByMean);

        _recHistory.clear();
      }
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
      _inferenceTime = inferenceTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    String preferredModel = Settings.getValue("key-cnn-type", mobileNetNoArt);
    _model = preferredModel;
    loadModelFromSettings();
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: _model == ""
          // here check if model was loaded properly (see res in loadFrom...())
          // instead of checking if _model is empty; if loading fails show an
          // appropriate msg
          ? Center(child: CircularProgressIndicator())
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Selection based last 5 inferences: $_currentTopInference",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("Model used: $_model"),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
