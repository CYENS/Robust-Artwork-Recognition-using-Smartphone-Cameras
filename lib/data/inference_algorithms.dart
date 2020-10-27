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
  final double sensitivity;
  final int windowLength;
  double _topMean = 0.0;
  var _probsByID = DefaultDict<String, List<double>>(() => []);

  WindowAverageAlgo({this.sensitivity, this.windowLength});

  @override
  void updateRecognitions(List<dynamic> recognitions, int inferenceTime) {
    _updateHistories(recognitions, inferenceTime);

    if (history.length >= windowLength) {
      // sort probabilities of the last windowLength recognitions by artworkId
      history.sublist(history.length - windowLength).forEach((recognition) {
        _probsByID[recognition["label"]].add(recognition["confidence"]);
      });

      // get mean probability for each artworkId
      var meansByID = <String, double>{
        for (var id in _probsByID.entries)
          id.key: id.value.reduce((a, b) => a + b) / id.value.length
      };

      // sort artworkIds by mean, largest to smallest
      // meansByID is converted to LinkedHashMap here, that guarantees
      // preserving key insertion order
      meansByID = meansByID.sortedByValue((mean) => mean, order: Order.desc);

      _topMean = 0.0;

      var entries = meansByID.entries.toList();

      // check if the first artwork's probability exceeds the sensitivity
      if (entries[0].value >= sensitivity / 100) {
        if (meansByID.length == 1) {
          // case of only one id
          setTopInference(entries[0].key);
          _topMean = entries[0].value;
        } else if (meansByID.length > 1 &&
            entries[0].value != entries[1].value) {
          // case of multiple ids with no ties between the top 2
          setTopInference(entries[0].key);
          _topMean = entries[0].value;
        } else {
          // there is a tie in means, wait for next round
          resetTopInference();
        }
      } else {
        // no winner yet
        resetTopInference();
      }

      _probsByID.clear();
    }
  }

  @override
  ViewingsCompanion topInferenceAsViewingsCompanion() {
    // TODO: implement topInferenceAsViewingsCompanion
    throw UnimplementedError();
  }

  @override
  String get topInferenceFormatted {
    if (hasResult()) {
      return _topInference + " (${(_topMean * 100).toStringAsPrecision(2)}%)";
    } else {
      return noResult;
    }
  }
}

/// 2nd algorithm: tallies the number of appearances of each artwork in a
/// sliding window of length [windowLength] over the stream of predictions by
/// the model. The artwork with the highest count is chosen as the "winner". In
/// case of ties in artwork top counts, no winner is chosen and the algorithm
/// proceeds to the next window.
///
/// We could improve this algorithm by only accepting as winner the artwork
/// that has a majority count, i.e. more than half, in the window.
class WindowHighestCountAlgo extends InferenceAlgorithm {
  final double sensitivitySetting;
  final int windowLength;
  var _countsByID = DefaultDict<String, int>(() => 0);

  WindowHighestCountAlgo({this.windowLength, this.sensitivitySetting = 0.0});

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
      // _countsByID is converted to LinkedHashMap here, that guarantees
      // preserving key insertion order
      _countsByID =
          _countsByID.sortedByValue((count) => count, order: Order.desc);

      var topEntry = _countsByID.entries.toList()[0];

      if (_countsByID.length == 1) {
        // if there is only one artwork in map, set it as top
        setTopInference(topEntry.key);
      } else if (topEntry.value != _countsByID.values.toList()[1]) {
        // if there are no ties between first and second artworks, set first as top
        setTopInference(topEntry.key);
      } else {
        // in case of a tie, wait for next round to decide
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

  @override
  String get topInferenceFormatted {
    if (hasResult()) {
      return _topInference +
          " (count of ${_countsByID[_topInference]} in last "
              "$windowLength inferences)";
    } else {
      return noResult;
    }
  }
}

/// 3rd algorithm: keep count of all predictions for each artwork, and pick as
/// "winner" the first artwork to reach [countThreshold]. If [sensitivity] is
/// specified, only those predictions that equal or exceed it are counted.
///
/// Resembles [First-past-the-post voting](https://en.wikipedia.org/wiki/First-past-the-post_voting),
/// hence the name.
class FirstPastThePostAlgo extends InferenceAlgorithm {
  final double sensitivity;
  final int countThreshold;
  var _countsByID = DefaultDict<String, int>(() => 0);

  FirstPastThePostAlgo({this.countThreshold, this.sensitivity = 0.0});

  @override
  void updateRecognitions(List recognitions, int inferenceTime) {
    _updateHistories(recognitions, inferenceTime);

    // keep count of each inference per artworkId
    recognitions.forEach((recognition) {
      double recProbability = recognition["confidence"];
      // here if sensitivitySetting is not specified, every inference counts,
      // otherwise inferences with lower values are not counted
      if (recProbability >= (sensitivity / 100)) {
        _countsByID[recognition["label"]] += 1;
      }
    });

    // sort artworkIds by their counts, largest to smallest
    // _countsByID is converted to LinkedHashMap here, that guarantees
    // preserving key insertion order
    _countsByID =
        _countsByID.sortedByValue((count) => count, order: Order.desc);

    var entries = _countsByID.entries.toList();

    // check the first artwork's count exceeds the count threshold
    if (entries[0].value >= countThreshold) {
      if (_countsByID.length == 1) {
        // case of only one artwork that exceeds threshold
        setTopInference(entries[0].key);
      } else if (entries[0].value != entries[1].value) {
        // case of multiple artworks with no ties between the top 2
        setTopInference(entries[0].key);
      } else {
        // there is a tie in counts, wait for next round
        resetTopInference();
      }
    } else {
      // no winner yet
      resetTopInference();
    }
  }

  @override
  ViewingsCompanion topInferenceAsViewingsCompanion() {
    // TODO: implement topInferenceAsViewingsCompanion
    throw UnimplementedError();
  }

  @override
  String get topInferenceFormatted {
    if (hasResult()) {
      // if we continue counting after the first top inference is chosen, the
      // top inference may change, and the return value below will no longer be
      // "correct", but in normal circumstances the app will not reach such a
      // scenario, since it will pick the first result and stop counting
      return _topInference +
          " (First to reach count of $countThreshold - current "
              "count ${_countsByID[_topInference]}";
    } else {
      return noResult;
    }
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
