import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'models.dart';

typedef void Callback(List<dynamic> list, int h, int w, int inferenceTime);

class TensorFlowCamera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  TensorFlowCamera(this.cameras, this.setRecognitions, this.model);

  @override
  _TensorFlowCameraState createState() => new _TensorFlowCameraState();
}

class _TensorFlowCameraState extends State<TensorFlowCamera> {
  CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = new DateTime.now().millisecondsSinceEpoch;

            if ([vgg19, vgg19Quant, vgg19NoArtQuant, vgg19ZeroOneMultiQuant]
                .contains(widget.model)) {
              print("calculating with ${widget.model}");
              Tflite.runModelOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                imageMean: 0,
                imageStd: 255.0,
                numResults: 1,
              ).then((recognitions) {
                int endTime = new DateTime.now().millisecondsSinceEpoch;
                var inferenceTime = endTime - startTime;
                print("Detection took $inferenceTime ms");
                widget.setRecognitions(
                    recognitions, img.height, img.width, inferenceTime);

                isDetecting = false;
              });
            } else if ([
              mobilenet,
              mobileNetNoArt,
              mobileNetNoArtQuant,
              mobNetNoArt800,
              mobNetNoArt500Quant_4,
              mobNetNoArt700New,
              mobNetNoArt500_4,
            ].contains(widget.model)) {
              Tflite.runModelOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                numResults: 1,
              ).then((recognitions) {
                int endTime = new DateTime.now().millisecondsSinceEpoch;
                var inferenceTime = endTime - startTime;
                print("Detection took $inferenceTime ms");
                widget.setRecognitions(
                    recognitions, img.height, img.width, inferenceTime);

                isDetecting = false;
              });
            } else if (widget.model == posenet) {
              Tflite.runPoseNetOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                numResults: 1,
              ).then((recognitions) {
                int endTime = new DateTime.now().millisecondsSinceEpoch;
                var inferenceTime = endTime - startTime;
                print("Detection took $inferenceTime ms");
                widget.setRecognitions(
                    recognitions, img.height, img.width, inferenceTime);

                isDetecting = false;
              });
            } else {
              Tflite.detectObjectOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                model: widget.model == yolo ? "YOLO" : "SSDMobileNet",
                imageHeight: img.height,
                imageWidth: img.width,
                imageMean: widget.model == yolo ? 0 : 127.5,
                imageStd: widget.model == yolo ? 255.0 : 127.5,
                numResultsPerClass: 1,
                threshold: widget.model == yolo ? 0.2 : 0.4,
              ).then((recognitions) {
                int endTime = new DateTime.now().millisecondsSinceEpoch;
                var inferenceTime = endTime - startTime;
                print("Detection took $inferenceTime ms");
                widget.setRecognitions(
                    recognitions, img.height, img.width, inferenceTime);

                isDetecting = false;
              });
            }
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
