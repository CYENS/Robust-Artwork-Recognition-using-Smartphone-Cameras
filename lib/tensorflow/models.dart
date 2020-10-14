import 'package:flutter/material.dart';

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

class TfLiteModel {
  final String modelAssetsPath = "assets/tflite/";

  final String _modelPath;

  final String _labelsPath;

  const TfLiteModel({@required String modelPath, @required String labelsPath})
      : _modelPath = modelPath,
        _labelsPath = labelsPath;

  String get modelPath => modelAssetsPath + _modelPath;

  String get labelsPath => modelAssetsPath + _labelsPath;
}
