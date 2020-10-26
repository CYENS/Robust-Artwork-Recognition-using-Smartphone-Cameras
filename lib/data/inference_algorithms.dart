import 'package:modern_art_app/data/database.dart';

abstract class InferenceAlgorithm {
  List history;
  List<int> inferenceTimeHistory;
  double _fps = 0.0;

  String get fps => "$_fps fps";

  // InferenceAlgorithm();

  void updateRecognitions({List<dynamic> recognitions, int inferenceTime}) {
    // for now recognitions will only contain 1 element (1 inference from CNN,
    // this is specified in tensorflow_camera), could change this in the future
    // if necessary
    history.addAll(recognitions);
    inferenceTimeHistory.add(inferenceTime);
    _updateFps();
  }

  void _updateFps() {
    if (inferenceTimeHistory.length >= 5) {
      double meanInferenceTime = inferenceTimeHistory
              .sublist(inferenceTimeHistory.length - 5)
              .reduce((a, b) => a + b) /
          5;
      _fps = 1000 / meanInferenceTime;
    }
  }

  ViewingsCompanion toViewingsCompanion();
}
