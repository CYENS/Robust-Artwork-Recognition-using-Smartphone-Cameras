import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:modern_art_app/utils/utils.dart';

abstract class InferenceAlgorithm {
  final startTime = DateTime.now();
  final noResult = "";
  List history;
  List<int> inferenceTimeHistory;
  double _fps = 0.0;
  String _topInference = "";

  String get topInference {
    if (hasResult()) {
      return _topInference;
    } else {
      return noResult;
    }
  }

  String get topInferenceFormatted;

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
class WindowAverageAlgo extends InferenceAlgorithm {
  final double sensitivitySetting;
  final int windowLength;
  double _topMean = 0.0;
  var _sortByID = DefaultDict<String, List<double>>(() => []);

  WindowAverageAlgo({this.sensitivitySetting, this.windowLength});

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

/// 2nd algorithm
class WindowMajorityAlgo extends InferenceAlgorithm {
  final double sensitivitySetting;
  final int windowLength;
  int _topCount = 0;
  var _countsByID = DefaultDict<String, int>(() => 0);

  WindowMajorityAlgo({this.windowLength, this.sensitivitySetting = 0.0});

  @override
  void updateRecognitions(List recognitions, int inferenceTime) {
    _updateHistories(recognitions, inferenceTime);

    // here the sensitivity setting is not taken into account as is

    if (history.length >= windowLength) {
      // count the occurrences of the last windowLength recognitions by artworkId
      history.sublist(history.length - windowLength).forEach((recognition) {
        _countsByID[recognition["label"]] += 1;
      });

      // sort artworkIds by their counts, largest to smallest
      _countsByID =
          _countsByID.sortedByValue((count) => count, order: Order.desc);

      _topCount = 0;

      var topEntry = _countsByID.entries.toList()[0];

      if (_countsByID.length == 1) {
        // if only one id in map, set it as top
        setTopInference(topEntry.key);
        _topCount = topEntry.value;
      } else if (topEntry.value != _countsByID.values.toList()[1]) {
        // check if there are no ties between first and second artworkIds
        setTopInference(topEntry.key);
        _topCount = topEntry.value;
      } else {
        // in case of tie, wait for next round to decide
        resetTopInference();
      }

      _countsByID.clear();
    }
  }

  @override
  ViewingsCompanion topInferenceAsViewingsCompanion() {
    // TODO: implement topInferenceAsViewingsCompanion
    throw UnimplementedError();
  }
}

/// 3rd algorithm: count all inferences for each artwork prediction, and pick
/// as "winner" the first artwork to reach [countThreshold].
/// Resembles First-past-the-post voting
/// https://en.wikipedia.org/wiki/First-past-the-post_voting
class FirstPastThePostAlgo extends InferenceAlgorithm {
  final double sensitivitySetting;
  final int countThreshold;
  var _countsByID = DefaultDict<String, int>(() => 0);

  FirstPastThePostAlgo({this.countThreshold, this.sensitivitySetting = 0.0});

  @override
  void updateRecognitions(List recognitions, int inferenceTime) {
    _updateHistories(recognitions, inferenceTime);

    // keep count of each inference per artworkId
    recognitions.forEach((recognition) {
      double recProbability = recognition["confidence"];
      // here if sensitivitySetting is not specified, every inference counts,
      // otherwise inferences with lower values are not counted
      if (recProbability >= (sensitivitySetting / 100)) {
        _countsByID[recognition["label"]] += 1;
      }
    });

    // sort artworkIds by their counts, largest to smallest
    _countsByID =
        _countsByID.sortedByValue((count) => count, order: Order.desc);

    var entries = _countsByID.entries.toList();

    // check if we have any that exceed the threshold
    if (_countsByID.length == 1 && entries[0].value >= countThreshold) {
      // case of only one id that exceeds threshold
      setTopInference(entries[0].key);
    } else if (_countsByID.length > 1 &&
        entries[0].value >= countThreshold &&
        entries[0].value != entries[1].value) {
      // case of multiple ids with no ties between the top 2, with the top
      // count exceeding threshold
      setTopInference(entries[0].key);
    } else {
      //  no winner yet
      resetTopInference();
    }
  }

  @override
  ViewingsCompanion topInferenceAsViewingsCompanion() {
    // TODO: implement topInferenceAsViewingsCompanion
    throw UnimplementedError();
  }
}

/// 4th algorithm, based loosely on algo by Seidenary et al. 2017..
class SeidenaryAlgo extends InferenceAlgorithm {
  final int P;
  final double sensitivitySetting;
  var _counters = DefaultDict<String, int>(() => 0);
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
        _counters[topArtwork] += 1;
        // subtract 1 for all other previous inferences
        _counters.keys.forEach((key) {
          if (key != topArtwork) {
            _counters[key] -= 1;
          }
        });
      }
    }

    _topCounter = 0;

    if (_counters.length > 0) {
      // sort artworkIds by count, largest to smallest
      var idsSortedByCount = _counters.keys.toList(growable: false)
        ..sort((k1, k2) => _counters[k2].compareTo(_counters[k1]));

      // if _topCounter is equal or larger than P, set topInference
      _topCounter = _counters[idsSortedByCount.first];
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
