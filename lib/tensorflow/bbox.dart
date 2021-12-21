import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:modern_art_app/tensorflow/models.dart';

class BBox extends StatelessWidget {
  const BBox(
    this.results,
    this.previewHeight,
    this.previewWidth,
    this.screenHeight,
    this.screenWidth,
    this.model,
    this.inferenceTime,
  );

  final List<dynamic> results;
  final int previewHeight;
  final int previewWidth;
  final double screenHeight;
  final double screenWidth;
  final String model;
  final int inferenceTime;

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return results.map(
        (re) {
          final _x = re['rect']['x'];
          final _w = re['rect']['w'];
          final _y = re['rect']['y'];
          final _h = re['rect']['h'];
          var scaleW, scaleH, x, y, w, h;

          if (screenHeight / screenWidth > previewHeight / previewWidth) {
            scaleW = screenHeight / previewHeight * previewWidth;
            scaleH = screenHeight;
            final difW = (scaleW - screenWidth) / scaleW;
            x = (_x - difW / 2) * scaleW;
            w = _w * scaleW;
            if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
            y = _y * scaleH;
            h = _h * scaleH;
          } else {
            scaleH = screenWidth / previewWidth * previewHeight;
            scaleW = screenWidth;
            final difH = (scaleH - screenHeight) / scaleH;
            x = _x * scaleW;
            w = _w * scaleW;
            y = (_y - difH / 2) * scaleH;
            h = _h * scaleH;
            if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
          }

          return Positioned(
            left: math.max(0, x),
            top: math.max(0, y),
            width: w,
            height: h,
            child: Container(
              padding: const EdgeInsets.only(top: 5.0, left: 5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(37, 213, 253, 1.0),
                  width: 3.0,
                ),
              ),
              child: Text(
                "${re["detectedClass"]} "
                "${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ).toList();
    }

    List<Widget> _renderStrings() {
      double offset = -10;
      return results.map(
        (re) {
          offset = offset + 30;
          return Positioned(
            left: 10,
            top: offset,
            // width: screenWidth,
            // height: screenHeight,
            child: Row(
              children: [
                if (!['multiple_artworks', 'no_artwork', 'one_artwork']
                    .contains(re['label']))
                  Image.asset(
                    "assets/paintings/${re['label']}.webp",
                    width: screenWidth / 5,
                    height: screenWidth / 5,
                  ),
                Text(
                  "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%"
                  '\n$inferenceTime ms',
                  style: const TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ],
            ),
          );
        },
      ).toList();
    }

    List<Widget> _renderKeypoints() {
      final lists = <Widget>[];
      results.forEach(
        (re) {
          final list = re['keypoints'].values.map<Widget>(
            (k) {
              final _x = k['x'];
              final _y = k['y'];
              var scaleW, scaleH, x, y;

              if (screenHeight / screenWidth > previewHeight / previewWidth) {
                scaleW = screenHeight / previewHeight * previewWidth;
                scaleH = screenHeight;
                final difW = (scaleW - screenWidth) / scaleW;
                x = (_x - difW / 2) * scaleW;
                y = _y * scaleH;
              } else {
                scaleH = screenWidth / previewWidth * previewHeight;
                scaleW = screenWidth;
                final difH = (scaleH - screenHeight) / scaleH;
                x = _x * scaleW;
                y = (_y - difH / 2) * scaleH;
              }
              return Positioned(
                left: x - 6,
                top: y - 6,
                width: 100,
                height: 12,
                child: Text(
                  "● ${k["part"]}",
                  style: const TextStyle(
                    color: Color.fromRGBO(37, 213, 253, 1.0),
                    fontSize: 12.0,
                  ),
                ),
              );
            },
          ).toList();
          lists.addAll(list);
        },
      );

      return lists;
    }

    return Stack(
      children: [
        mobilenet,
        vgg19,
        vgg19Quant,
        vgg19NoArtQuant,
        vgg19ZeroOneMultiQuant,
        mobileNetNoArt,
        mobileNetNoArtQuant,
        inceptionV3NoArt500,
        mobNetNoArt500Quant_4,
        inceptionV3NoArt500Quant,
        mobNetNoArt500_4,
      ].contains(model)
          ? _renderStrings()
          : model == posenet
              ? _renderKeypoints()
              : _renderBoxes(),
    );
  }
}
