import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:modern_art_app/data/artworks_dao.dart';
import 'package:modern_art_app/ui/widgets/artwork_details_page.dart';
import 'package:provider/provider.dart';

import 'models.dart';

class BBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewHeight;
  final int previewWidth;
  final double screenHeight;
  final double screenWidth;
  final String model;

  BBox(this.results, this.previewHeight, this.previewWidth, this.screenHeight,
      this.screenWidth, this.model);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;

        if (screenHeight / screenWidth > previewHeight / previewWidth) {
          scaleW = screenHeight / previewHeight * previewWidth;
          scaleH = screenHeight;
          var difW = (scaleW - screenWidth) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = screenWidth / previewWidth * previewHeight;
          scaleW = screenWidth;
          var difH = (scaleH - screenHeight) / scaleH;
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
            padding: EdgeInsets.only(top: 5.0, left: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(37, 213, 253, 1.0),
                width: 3.0,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                color: Color.fromRGBO(37, 213, 253, 1.0),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderStrings() {
      double offset = -screenWidth / 5 / 1.3;
      return results.map((re) {
        offset = offset + screenWidth / 5;
        return Positioned(
          left: 10,
          top: offset,
          // width: screenWidth,
          // height: screenHeight,
          child: InkWell(
            onTap: () {
              ArtworksDao artworksDao =
                  Provider.of<ArtworksDao>(context, listen: false);
              // todo: navigating to artwork details here leaves tensorflow camera inferences running in the background!
              artworksDao.getArtworkById(re["label"]).then((value) =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ArtworkDetailsPage(artwork: value))));
            },
            child: Row(
              children: [
                Text(
                  "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  "assets/paintings/${re['label']}.webp",
                  width: screenWidth / 5,
                  height: screenWidth / 5,
                ),
              ],
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (screenHeight / screenWidth > previewHeight / previewWidth) {
            scaleW = screenHeight / previewHeight * previewWidth;
            scaleH = screenHeight;
            var difW = (scaleW - screenWidth) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = screenWidth / previewWidth * previewHeight;
            scaleW = screenWidth;
            var difH = (scaleH - screenHeight) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Container(
              child: Text(
                "● ${k["part"]}",
                style: TextStyle(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }).toList();

        lists..addAll(list);
      });

      return lists;
    }

    return Stack(
      children: [mobilenet, modernArt, modernArtQuant].contains(model)
          ? _renderStrings()
          : model == posenet ? _renderKeypoints() : _renderBoxes(),
    );
  }
}
