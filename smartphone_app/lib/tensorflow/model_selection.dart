import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/inference_algorithms.dart';
import 'package:modern_art_app/data/viewings_dao.dart';
import 'package:modern_art_app/tensorflow/models.dart';
import 'package:modern_art_app/tensorflow/tensorflow_camera.dart';
import 'package:modern_art_app/ui/pages/artwork_details_page.dart';
import 'package:modern_art_app/ui/pages/settings_page.dart';
import 'package:modern_art_app/ui/widgets/viewfinder_animation.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import 'package:vibration/vibration.dart';

class ModelSelection extends StatefulWidget {
  const ModelSelection(this.cameras);

  final List<CameraDescription> cameras;

  @override
  _ModelSelectionState createState() => _ModelSelectionState();
}

class _ModelSelectionState extends State<ModelSelection>
    with WidgetsBindingObserver {
  List<Map<String, dynamic>> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  int _inferenceTime = 0;

  String _fps = '';
  String _model = '';
  double _preferredSensitivity = 0.0;
  bool _navigateToDetails = true;

  // bool addedViewing = false;
  late InferenceAlgorithm currentAlgorithm;
  String _currentRes = '';
  String _currentAlgo = '';

  bool _canVibrate = false;

  @override
  void setState(VoidCallback fn) {
    // must check if mounted here before setting state, in case user navigates
    // away from the widget, since TensorFlowCamera may use setRecognitions for
    // setting the results of its the last inference, that most likely will
    // arrive after user navigated away (setState after dispose)
    // dispose is called in tensorflow_camera
    if (mounted) {
      // bool hasRes = currentAlgorithm?.hasResult() ?? false;
      // if (hasRes && _model.isEmpty) {
      //   return;
      // }
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    // observe for AppLifecycleState changes, to pause CNN if app state changes
    // https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver-class.html
    WidgetsBinding.instance?.addObserver(this);
    // initialize model
    initModel();
  }

  @override
  void dispose() {
    // remove AppLifecycleState observer
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('CHANGE STATE $state');
    if ([AppLifecycleState.inactive, AppLifecycleState.paused]
        .contains(state)) {
      // pause the CNN if user puts app in the background
      setState(() => _model = '');
    } else if (state == AppLifecycleState.resumed) {
      // resume the CNN when user comes back
      initModel();
    }
  }

  void initModel() {
    // get preferred algorithm from settings
    final String preferredModel =
        Settings.getValue(keyCnnModel, mobNetNoArt500_4);

    // get preferred algorithm, sensitivity and winThreshP from settings
    final String preferredAlgorithm =
        Settings.getValue(keyRecognitionAlgo, firstAlgorithm);

    final double sensitivity = Settings.getValue(
      keyCnnSensitivity,
      defaultSettings(preferredAlgorithm)![keyCnnSensitivity] as double,
    );

    // keyWinThreshP's value is stored as double, converted to int here
    final int winThreshP = Settings.getValue<double>(
      keyWinThreshP,
      defaultSettings(preferredAlgorithm)![keyWinThreshP] as double,
    ).round();

    // determine from settings whether to automatically navigate to an artwork's
    // details when a recognition occurs
    final bool navigateToDetails =
        Settings.getValue(keyNavigateToDetails, true);

    setState(
      () {
        _model = preferredModel;
        _preferredSensitivity = sensitivity;
        currentAlgorithm = allAlgorithms[preferredAlgorithm]!(
          sensitivity,
          winThreshP,
        ) as InferenceAlgorithm;
        _currentAlgo = preferredAlgorithm;
        _navigateToDetails = navigateToDetails;
      },
    );
    loadModelFromSettings();
  }

  Future<void> loadModelFromSettings() async {
    final TfLiteModel model = tfLiteModels[_model]!;
    final String? res = await Tflite.loadModel(
      model: model.modelPath,
      labels: model.labelsPath,
    );
    debugPrint('$res loading model $_model, as specified in Settings');

    Vibration.hasVibrator().then(
      (canVibrate) {
        if (canVibrate != null) {
          setState(() => _canVibrate = canVibrate);
        }
      },
    );
  }

  void setRecognitions(
    List<Map<String, dynamic>> recognitions,
    int imageHeight,
    int imageWidth,
    int inferenceTime,
  ) {
    if (_model.isNotEmpty) {
      if (currentAlgorithm.hasResult() &&
          _navigateToDetails &&
          currentAlgorithm.topInference != 'no_artwork') {
        setState(() => _model = '');
      }
      setState(
        () {
          _recognitions = recognitions;
          _imageHeight = imageHeight;
          _imageWidth = imageWidth;
          _inferenceTime = inferenceTime;

          // each item in recognitions is a LinkedHashMap in the form of
          // {confidence: 0.5562283396720886, index: 15, label: untitled_votsis}
          currentAlgorithm.updateRecognitions(recognitions, inferenceTime);
          _currentRes = currentAlgorithm.topInferenceFormatted;
          _fps = currentAlgorithm.fps;
          if (currentAlgorithm.hasResult() && _navigateToDetails) {
            // && !addedViewing
            if (currentAlgorithm.topInference != 'no_artwork') {
              _model = '';
              if (_canVibrate) {
                Vibration.vibrate(pattern: [0, 40, 100, 40]);
              }

              // get top inference as an object ready to insert in db
              ViewingsCompanion vc = currentAlgorithm.resultAsDbObject();
              // add current model to object
              vc = vc.copyWith(cnnModelUsed: Value(_model));
              Provider.of<ViewingsDao>(context, listen: false).insertTask(vc);
              debugPrint('Added VIEWING: $vc');
              // addedViewing = true;

              if (_navigateToDetails) {
                // navigate to artwork details
                Provider.of<ArtworksDao>(context, listen: false)
                    .getArtworkById(
                  artworkId: currentAlgorithm.topInference,
                  languageCode: context.locale().languageCode,
                )
                    .then(
                  (artwork) {
                    // set model to empty here, so that the camera stream stops
                    _model = '';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtworkDetailsPage(
                          artwork: artwork,
                        ),
                      ),
                    ).then(
                      (_) {
                        // re-initialize model when user is back to this screen
                        initModel();
                      },
                    );
                  },
                );
              }
            } else {
              debugPrint('Not adding VIEWING no_artwork');
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(strings.msg.pointTheCamera, maxLines: 1),
        backgroundColor: ThemeData.dark().primaryColor.withOpacity(0.2),
      ),
      body: _model == ''
          // todo here check if model was loaded properly (see res in loadFrom...())
          // instead of checking if _model is empty; if loading fails show an
          // appropriate msg
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned.fill(
                  child: TensorFlowCamera(
                    cameras: widget.cameras,
                    setRecognitions: setRecognitions,
                    model: _model,
                  ),
                ),
                if (Settings.getValue(keyDisplayExtraInfo, false) &&
                    _recognitions.isNotEmpty)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 30),
                      child: Column(
                        children: [
                          Text(
                            'Analysing $_fps',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Current consensus: '
                            "${_currentRes.isEmpty ? 'Calculating...' : _currentRes}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Algorithm used: $_currentAlgo',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            "Latest: ${_recognitions.last['label']} "
                            "${((_recognitions.last['confidence'] as double) * 100).toStringAsFixed(0)}"
                            '%, $_inferenceTime ms',
                            style: const TextStyle(fontSize: 12),
                          ),
                          if (!['no_artwork', '']
                              .contains(currentAlgorithm.topInference))
                            Image.asset(
                              'assets/paintings/'
                              '${currentAlgorithm.topInference}.webp',
                              width: screen.shortestSide / 6,
                              height: screen.shortestSide / 6,
                            ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 60),
                    child: Text(_msgForUser(currentAlgorithm.topInference)),
                  ),
                ),
                Center(child: ViewfinderAnimation(size: screen)),
              ],
            ),
    );
  }

  String _msgForUser(String topInference) {
    String current = '';
    switch (topInference) {
      case 'no_artwork':
        current = context.strings().msg.noneIdentified;
        break;
      case '':
        break;
      default:
        current = topInference
            .split('_')
            .map((String e) => e[0].toUpperCase() + e.substring(1))
            .join(' ');
    }
    return '${context.strings().msg.analysing} $current';
  }
}
