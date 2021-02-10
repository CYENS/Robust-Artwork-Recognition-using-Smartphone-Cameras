import 'package:flutter/material.dart';

// older example models
// TODO remove these
const String mobilenet = "MobileNet";
const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";
const String posenet = "PoseNet";

// custom models for modern art gallery
const String vgg19 = "VGG19";
const String vgg19Quant = "VGG19 (Quantized)";
const String vgg19NoArtQuant = "VGG19 - No Artwork category (Quantized)";
const String vgg19ZeroOneMultiQuant = "VGG19 - 0, 1, or Multiple (Quantized)";
const String mobileNetNoArt = "MobileNet - No Artwork category";
const String mobileNetNoArtQuant =
    "MobileNet - No Artwork category (Quantized)";
const String inceptionV3NoArt500 = "Inception V3 500 - No Artwork category";
const String inceptionV3NoArt500Quant =
    "Inception V3 500 - No Artwork category (Quantized)";
const String mobNetNoArt500_4 = "MobileNet 500 - V.4 - No Artwork category";
const String mobNetNoArt500Quant_4 =
    "MobileNet 500 - V.4 - No Artwork category (Quantized)";

/// Map containing information about all TfLite models bundled with the app.
const Map<String, TfLiteModel> tfLiteModels = {
  // vgg19: TfLiteModel(
  //     modelPath: "cnn224RGB_VGG19.tflite",
  //     labelsPath: "cnn224RGB_VGG19_labels.txt"),
  // vgg19Quant: TfLiteModel(
  //     modelPath: "cnn224RGB_VGG19_quant.tflite",
  //     labelsPath: "cnn224RGB_VGG19_labels.txt"),
  vgg19NoArtQuant: TfLiteModel(
      modelPath: "VGG_with_no_art_quant.tflite",
      labelsPath: "MobileNet_No_Art_labels.txt"),
  // vgg19ZeroOneMultiQuant: TfLiteModel(
  //     modelPath: "VGG19ZeroOneMultiple1500Frames_quant.tflite",
  //     labelsPath: "VGG19ZeroOneMultiple1500Frames_labels.txt"),
  // mobileNetNoArt: TfLiteModel(
  //     modelPath: "MobileNet_No_Art.tflite",
  //     labelsPath: "MobileNet_No_Art_labels.txt"),
  // mobileNetNoArtQuant: TfLiteModel(
  //     modelPath: "MobileNet_No_Art_quant.tflite",
  //     labelsPath: "MobileNet_No_Art_labels.txt"),
  mobNetNoArt500_4: TfLiteModel(
      modelPath: "MobNetNoArt500Frames_4.tflite",
      labelsPath: "MobileNet_No_Art_labels.txt"),
  // mobNetNoArt500Quant_4: TfLiteModel(
  //     modelPath: "MobNetNoArt500Frames_4_quant.tflite",
  //     labelsPath: "MobileNet_No_Art_labels.txt"),
  // inceptionV3NoArt500: TfLiteModel(
  //     modelPath: "InceptionV3NoArt500Frames.tflite",
  //     labelsPath: "MobileNet_No_Art_labels.txt"),
  inceptionV3NoArt500Quant: TfLiteModel(
      modelPath: "InceptionV3NoArt500Frames_quant.tflite",
      labelsPath: "MobileNet_No_Art_labels.txt"),
};

/// Map with tfLiteModels names, used in settings to allow selection of model.
final tfLiteModelNames = Map<String, String>.fromIterable(
  tfLiteModels.keys,
  key: (key) => key,
  value: (key) => key,
);

/// Class for holding information about the TfLite models bundled with the app,
/// specifically the file paths to the model itself, as well as to the text
/// files with the model's list of labels.
class TfLiteModel {
  /// Prefix to the assets directory that contains the models, so it can be
  /// easily updated in the future if needed.
  static String _modelAssetsPath = "assets/tflite/";

  final String _modelPath;

  final String _labelsPath;

  const TfLiteModel({@required String modelPath, @required String labelsPath})
      : _modelPath = modelPath,
        _labelsPath = labelsPath;

  /// Returns the full path to the model's file.
  String get modelPath => _modelAssetsPath + _modelPath;

  /// Returns the full path to the model's labels.
  String get labelsPath => _modelAssetsPath + _labelsPath;
}
