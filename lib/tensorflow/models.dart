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

const Map<String, TfLiteModel> tfLiteModels = {
  vgg19: TfLiteModel(
      modelPath: "cnn224RGB_VGG19.tflite",
      labelsPath: "cnn224RGB_VGG19_labels.txt"),
  vgg19Quant: TfLiteModel(
      modelPath: "cnn224RGB_VGG19_quant.tflite",
      labelsPath: "cnn224RGB_VGG19_labels.txt"),
  vgg19NoArtQuant: TfLiteModel(
      modelPath: "VGG_with_no_art_quant.tflite",
      labelsPath: "VGG_with_no_art_labels.txt"),
  vgg19ZeroOneMultiQuant: TfLiteModel(
      modelPath: "VGG_zero_one_multiple_quant.tflite",
      labelsPath: "VGG_zero_one_multiple_labels.txt"),
  mobileNetNoArt: TfLiteModel(
      modelPath: "MobileNet_No_Art.tflite",
      labelsPath: "MobileNet_No_Art_labels.txt"),
  mobileNetNoArtQuant: TfLiteModel(
      modelPath: "MobileNet_No_Art_quant.tflite",
      labelsPath: "MobileNet_No_Art_labels.txt"),
};

class TfLiteModel {
  static String modelAssetsPath = "assets/tflite/";

  final String _modelPath;

  final String _labelsPath;

  const TfLiteModel({@required String modelPath, @required String labelsPath})
      : _modelPath = modelPath,
        _labelsPath = labelsPath;

  String get modelPath => modelAssetsPath + _modelPath;

  String get labelsPath => modelAssetsPath + _labelsPath;
}
