import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/tensorflow/models.dart';
import 'package:tflite/tflite.dart';

typedef Callback = void Function(
  List<dynamic> list,
  int h,
  int w,
  int inferenceTime,
);

class TensorFlowCamera extends StatefulWidget {
  const TensorFlowCamera({
    required this.cameras,
    required this.setRecognitions,
    required this.model,
  });

  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  @override
  _TensorFlowCameraState createState() => _TensorFlowCameraState();
}

class _TensorFlowCameraState extends State<TensorFlowCamera> {
  late CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();

    if (widget.cameras.isEmpty) {
      debugPrint('No camera is found');
    } else {
      controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
        // we don't need audio in the app, so by passing false below, the
        // microphone permission is not requested from the user (on Android,
        // on iOS the permission has to be manually specified, which was not
        // done for this app)
        enableAudio: false,
      );
      controller.initialize().then(
        (_) {
          if (!mounted) {
            return;
          }
          setState(() {});

          controller.startImageStream(
            (CameraImage img) {
              if (!isDetecting) {
                isDetecting = true;

                final int startTime = DateTime.now().millisecondsSinceEpoch;

                if ([vgg19, vgg19Quant, vgg19NoArtQuant, vgg19ZeroOneMultiQuant]
                    .contains(widget.model)) {
                  debugPrint('calculating with ${widget.model}');
                  Tflite.runModelOnFrame(
                    bytesList: img.planes.map((plane) => plane.bytes).toList(),
                    imageHeight: img.height,
                    imageWidth: img.width,
                    imageMean: 0,
                    imageStd: 255.0,
                    numResults: 1,
                  ).then(
                    (recognitions) {
                      if (recognitions != null) {
                        final inferenceTime =
                            DateTime.now().millisecondsSinceEpoch - startTime;
                        debugPrint('Detection took $inferenceTime ms');
                        widget.setRecognitions(
                          recognitions,
                          img.height,
                          img.width,
                          inferenceTime,
                        );
                      }
                      isDetecting = false;
                    },
                  );
                } else if ([
                  mobilenet,
                  mobileNetNoArt,
                  mobileNetNoArtQuant,
                  inceptionV3NoArt500,
                  mobNetNoArt500Quant_4,
                  inceptionV3NoArt500Quant,
                  mobNetNoArt500_4,
                ].contains(widget.model)) {
                  Tflite.runModelOnFrame(
                    bytesList: img.planes.map((plane) => plane.bytes).toList(),
                    imageHeight: img.height,
                    imageWidth: img.width,
                    numResults: 1,
                  ).then(
                    (recognitions) {
                      if (recognitions != null) {
                        final inferenceTime =
                            DateTime.now().millisecondsSinceEpoch - startTime;
                        debugPrint('Detection took $inferenceTime ms');
                        widget.setRecognitions(
                          recognitions,
                          img.height,
                          img.width,
                          inferenceTime,
                        );
                      }
                      isDetecting = false;
                    },
                  );
                } else if (widget.model == posenet) {
                  Tflite.runPoseNetOnFrame(
                    bytesList: img.planes.map((plane) => plane.bytes).toList(),
                    imageHeight: img.height,
                    imageWidth: img.width,
                    numResults: 1,
                  ).then(
                    (recognitions) {
                      if (recognitions != null) {
                        final inferenceTime =
                            DateTime.now().millisecondsSinceEpoch - startTime;
                        debugPrint('Detection took $inferenceTime ms');
                        widget.setRecognitions(
                          recognitions,
                          img.height,
                          img.width,
                          inferenceTime,
                        );
                      }
                      isDetecting = false;
                    },
                  );
                } else {
                  Tflite.detectObjectOnFrame(
                    bytesList: img.planes.map((plane) => plane.bytes).toList(),
                    model: widget.model == yolo ? 'YOLO' : 'SSDMobileNet',
                    imageHeight: img.height,
                    imageWidth: img.width,
                    imageMean: widget.model == yolo ? 0 : 127.5,
                    imageStd: widget.model == yolo ? 255.0 : 127.5,
                    numResultsPerClass: 1,
                    threshold: widget.model == yolo ? 0.2 : 0.4,
                  ).then(
                    (recognitions) {
                      if (recognitions != null) {
                        final inferenceTime =
                            DateTime.now().millisecondsSinceEpoch - startTime;
                        debugPrint('Detection took $inferenceTime ms');
                        widget.setRecognitions(
                          recognitions,
                          img.height,
                          img.width,
                          inferenceTime,
                        );
                      }
                      isDetecting = false;
                    },
                  );
                }
              }
            },
          );
        },
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    final screenH = math.max(tmp.height, tmp.width);
    final screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize!;
    final previewH = math.max(tmp.height, tmp.width);
    final previewW = math.min(tmp.height, tmp.width);
    final screenRatio = screenH / screenW;
    final previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
