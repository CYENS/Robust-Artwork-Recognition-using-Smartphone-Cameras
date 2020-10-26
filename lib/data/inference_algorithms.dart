import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/utils/utils.dart';

abstract class InferenceAlgorithm {
  final startTime = DateTime.now();
  final noResult = "";
  List history;
  List<int> inferenceTimeHistory;
  double _fps = 0.0;
  String _topInference = "";

  String get fps => "$_fps fps";

  bool hasResult() => _topInference != "";

  void setTopInference(String value) => _topInference = value;

  void resetTopInference() => _topInference = noResult;

  /// should always call _updateHistories() first
  void updateRecognitions(List<dynamic> recognitions, int inferenceTime);

  void _updateHistories(List<dynamic> recognitions, int inferenceTime) {
    // for now recognitions will only contain 1 element (1 inference from CNN,
    // this is specified in tensorflow_camera), could change this in the future
    // if necessary
    // each item in recognitions is a LinkedHashMap in the form of
    // {confidence: 0.5562283396720886, index: 15, label: untitled_votsis}
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

  ViewingsCompanion topInferenceAsViewingsCompanion();
}

/// 1st algorithm.
class AverageProbabilityAlgo extends InferenceAlgorithm {
  final double sensitivitySetting;
  final int windowLength;
  double _topMean = 0.0;
  var _sortByID = DefaultDict<String, List<double>>(() => []);

  AverageProbabilityAlgo({this.sensitivitySetting, this.windowLength});

  @override
  void updateRecognitions(List<dynamic> recognitions, int inferenceTime) {
    _updateHistories(recognitions, inferenceTime);

    if (history.length >= windowLength) {
      // sort probabilities of the last windowLength recognitions by artworkId
      history.sublist(history.length - windowLength).forEach((recognition) {
        _sortByID[recognition["label"]].add(recognition["confidence"]);
      });

      // get mean probability for each artworkId
      var means = <String, double>{
        for (var id in _sortByID.entries)
          id.key: id.value.reduce((a, b) => a + b) / id.value.length
      };

      // sort artworkIds by mean, largest to smallest
      var idsSortedByMean = means.keys.toList(growable: false)
        ..sort((k1, k2) => means[k2].compareTo(means[k1]));

      _topMean = 0.0;

      // if topMean is equal or larger than sensitivitySetting, set topInference
      _topMean = means[idsSortedByMean.first];
      if (_topMean >= (sensitivitySetting / 100)) {
        setTopInference(idsSortedByMean.first);
      } else {
        resetTopInference();
      }

      _sortByID.clear();
    }
  }

  @override
  ViewingsCompanion topInferenceAsViewingsCompanion() {
    // TODO: implement topInferenceAsViewingsCompanion
    throw UnimplementedError();
  }
}

/// 4th algorithm, based loosely on Seidenary et al. 2017..
class SeidenaryAlgo extends InferenceAlgorithm {
  final int P;
  final double sensitivitySetting;
  var _taverritiAlgo = DefaultDict<String, int>(() => 0);
  int _topCounter = 0;

  SeidenaryAlgo({this.P, this.sensitivitySetting = 0.0});

  @override
  void updateRecognitions(List recognitions, int inferenceTime) {
    _updateHistories(recognitions, inferenceTime);

    if (recognitions.length > 0) {
      // here if sensitivitySetting is not specified, every inference counts,
      // otherwise inferences with lower values are not counted
      if (recognitions.first["confidence"] * 100 >= sensitivitySetting) {
        // add 1 to the top inference of this round
        var topArtwork = recognitions.first["label"];
        _taverritiAlgo[topArtwork] += 1;
        // subtract 1 for all other previous inferences
        _taverritiAlgo.keys.forEach((key) {
          if (key != topArtwork) {
            _taverritiAlgo[key] -= 1;
          }
        });
      }
    }

    _topCounter = 0;

    if (_taverritiAlgo.length > 0) {
      // sort artworkIds by count, largest to smallest
      var idsSortedByCount = _taverritiAlgo.keys.toList(growable: false)
        ..sort((k1, k2) => _taverritiAlgo[k2].compareTo(_taverritiAlgo[k1]));

      // if _topCounter is equal or larger than P, set topInference
      _topCounter = _taverritiAlgo[idsSortedByCount.first];
      if (_topCounter >= P) {
        setTopInference(idsSortedByCount.first);
      } else {
        resetTopInference();
      }
    }
  }

  @override
  ViewingsCompanion topInferenceAsViewingsCompanion() {
    // TODO: implement topInferenceAsViewingsCompanion
    throw UnimplementedError();
  }
}
