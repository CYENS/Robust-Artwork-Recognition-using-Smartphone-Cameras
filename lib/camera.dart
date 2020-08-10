import 'dart:async';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:modern_art_app/details.dart';
import 'package:modern_art_app/models.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';

typedef void Callback(List<dynamic> list, int h, int w);

class TakePictureScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const TakePictureScreen({Key key, @required this.cameras}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // create CameraController
    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.high,
    );
    // initialize controller
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // dispose controller when widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Point the camera to a painting"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //future complete, display preview
            return CameraPreview(_controller);
          } else {
            // if not, display loading indicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        //onpressed callback
        onPressed: () async {
          // try to take a picture
          try {
            // ensure the camera is initialized
            await _initializeControllerFuture;
            //construct path for picture file
            final path = join(
              // store the picture in the temp directory, find the temp
              // directory using the `path_provider` plugin
              (await getTemporaryDirectory()).path,
              "${DateTime.now()}.png",
            );
            // take picture
            await _controller.takePicture(path);
            // if picture was taken, show it in DisplayPictureScreen widget
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // catch any errors
            print(e);
          }
        },
      ),
    );
  }
}

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  Camera(this.cameras, this.setRecognitions, this.model);

  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
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

            if (widget.model == mobilenet) {
              Tflite.runModelOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                numResults: 2,
              ).then((recognitions) {
                int endTime = new DateTime.now().millisecondsSinceEpoch;
                print("Detection took ${endTime - startTime}");

                widget.setRecognitions(recognitions, img.height, img.width);

                isDetecting = false;
              });
            } else if (widget.model == posenet) {
              Tflite.runPoseNetOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                numResults: 2,
              ).then((recognitions) {
                int endTime = new DateTime.now().millisecondsSinceEpoch;
                print("Detection took ${endTime - startTime}");

                widget.setRecognitions(recognitions, img.height, img.width);

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
                print("Detection took ${endTime - startTime}");

                widget.setRecognitions(recognitions, img.height, img.width);

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
