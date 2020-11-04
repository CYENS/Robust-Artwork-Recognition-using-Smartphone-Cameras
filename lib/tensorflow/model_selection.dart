import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/inference_algorithms.dart';
import 'package:modern_art_app/data/viewings_dao.dart';
import 'package:modern_art_app/tensorflow/tensorflow_camera.dart';
import 'package:modern_art_app/ui/widgets/artwork_details_page.dart';
import 'package:modern_art_app/ui/widgets/settings_page.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:provider/provider.dart';
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

  String _fps = "";
  String _model = "";
  double _preferredSensitivity = 0.0;
  bool _navigateToDetails = false;

  bool addedViewing = false;
  var currentAlgorithm;
  String _currentRes = "";
  String _currentAlgo = "";
  ViewingsDao viewingsDao;

  @override
  void setState(VoidCallback fn) {
    // must check if mounted here before setting state, in case user navigates
    // away from the widget, since TensorFlowCamera may use setRecognitions for
    // setting the results of its the last inference, that most likely will
    // arrive after user navigated away (setState after dispose)
    // dispose is called in tensorflow_camera
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    initModel();
  }

  initModel() {
    // get preferred model, algorithm, sensitivity and winThreshP from settings
    // and load model and algorithm
    String preferredModel = Settings.getValue(keyCnnModel, mobileNetNoArt);
    double sensitivity = Settings.getValue(keyCnnSensitivity, 99.0);
    String preferredAlgorithm =
        Settings.getValue(keyRecognitionAlgo, firstAlgorithm);

    // keyWinThreshP's value is stored as double, have to make sure it is
    // converted to int here
    int winThreshP = Settings.getValue(keyWinThreshP, 5.0).round();

    // determine from settings whether to automatically navigate to an artwork's
    // details when a recognition occurs
    bool navigateToDetails = Settings.getValue(keyNavigateToDetails, false);

    setState(() {
      _model = preferredModel;
      _preferredSensitivity = sensitivity;
      currentAlgorithm =
          allAlgorithms[preferredAlgorithm](sensitivity, winThreshP);
      _currentAlgo = preferredAlgorithm;
      _navigateToDetails = navigateToDetails;
    });
    loadModelFromSettings();
  }

  loadModelFromSettings() async {
    TfLiteModel model = tfLiteModels[_model];
    String res = await Tflite.loadModel(
      model: model.modelPath,
      labels: model.labelsPath,
    );
    print("$res loading model $_model, as specified in Settings");
  }

  setRecognitions(recognitions, imageHeight, imageWidth, inferenceTime) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
      _inferenceTime = inferenceTime;

      // each item in recognitions is a LinkedHashMap in the form of
      // {confidence: 0.5562283396720886, index: 15, label: untitled_votsis}
      currentAlgorithm.updateRecognitions(recognitions, inferenceTime);
      _currentRes = currentAlgorithm.topInferenceFormatted;
      _fps = currentAlgorithm.fps;
      if (currentAlgorithm.hasResult() && !addedViewing) {
        if (currentAlgorithm.topInference != "no_artwork") {
          // get top inference as an object ready to insert in db
          ViewingsCompanion vc = currentAlgorithm.resultAsDbObject();
          // add current model to object
          vc = vc.copyWith(cnnModelUsed: Value(_model));
          viewingsDao.insertTask(vc);
          print("Added VIEWING: $vc");
          addedViewing = true;
          // optionally navigate to artwork details when a recognition occurs
          // TODO navigating to details is flawed here, since it leaves tflite
          //  running in the background; a proper implementation must be able
          //  to somehow dispose of the TensorFlowCamera widget before
          //  navigating to details
          if (_navigateToDetails) {
            Provider.of<ArtworksDao>(context, listen: false)
                .getArtworkById(
                    artworkId: currentAlgorithm.topInference,
                    languageCode: context.locale().languageCode)
                .then((artwork) {
              return Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ArtworkDetailsPage(artwork: artwork)));
            });
          }
        } else {
          print("Not adding VIEWING no_artwork");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    viewingsDao = Provider.of<ViewingsDao>(context);
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
                          "Result: $_currentRes",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Current algorithm: $_currentAlgo",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text("Model: $_model"),
                        Text("Sensitivity: $_preferredSensitivity" + ", $_fps"),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
