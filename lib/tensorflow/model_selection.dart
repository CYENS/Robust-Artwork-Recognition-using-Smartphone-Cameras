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
  List<int> _inferenceTimeHistory = [];
  double _fps = 0.0;
  String _model = "";
  double _preferredSensitivity = 0.0;
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

  onSelect(model, sensitivity) {
    setState(() {
      _model = model;
      _preferredSensitivity = sensitivity;
    });
    loadModelFromSettings();
  }

  setRecognitions(recognitions, imageHeight, imageWidth, inferenceTime) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
      _inferenceTime = inferenceTime;
      _inferenceTimeHistory.add(inferenceTime);

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
        var fps = 1000 /
            (_inferenceTimeHistory
                    .sublist(_inferenceTimeHistory.length - 5)
                    .reduce((a, b) => a + b) /
                5);

        if (fps != 0.0) _fps = fps;

        print(sortedByMean);

        _recHistory.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String preferredModel = Settings.getValue("key-cnn-type", mobileNetNoArt);
    double sensitivity = Settings.getValue("key-cnn-sensitivity", 99.0);
    onSelect(preferredModel, sensitivity);
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
                          _currentTopInference,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text("Model: $_model"),
                        Text("Sensitivity: $_preferredSensitivity" +
                            ", ${_fps != 0.0 ? "${_fps.toStringAsPrecision(2)}" : "N/A"} fps"),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
