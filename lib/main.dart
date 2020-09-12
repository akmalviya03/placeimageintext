import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyPlaceImageInsideText());
}

class MyPlaceImageInsideText extends StatefulWidget {
  @override
  _MyPlaceImageInsideTextState createState() => _MyPlaceImageInsideTextState();
}

class _MyPlaceImageInsideTextState extends State<MyPlaceImageInsideText> {
  Future<ui.Image> imgFromFuture;
  Float64List matrix4 = Matrix4.identity().storage;
  Future<ui.Image> getImageDataFromAsset(String ImageAssetPath) async {
    var imageData =
        Uint8List.sublistView(await rootBundle.load(ImageAssetPath));
    return await decodeImageFromList(imageData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgFromFuture = getImageDataFromAsset("assets/images/Board.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FutureBuilder(
              future: imgFromFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Hello World',
                    style: TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = ImageShader(snapshot.data,
                              TileMode.repeated, TileMode.repeated, matrix4)),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
