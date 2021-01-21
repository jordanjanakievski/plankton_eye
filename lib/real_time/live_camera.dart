import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/real_time/bounding_box.dart';
import 'package:object_detection/real_time/camera.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveFeed extends StatefulWidget {
  final List<CameraDescription> cameras;
  LiveFeed(this.cameras);
  @override
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  initCameras() async {}
  loadTfModel() async {
    await Tflite.loadModel(
      //This dictates the model that is being used.
      //Changing the path to a different tflite file will change the model
      model: "assets/models/detect.tflite",
      labels: "assets/models/plankton_labels.txt",
    );
  }
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Plankton Eye",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(color: Colors.white, fontSize: 25),
            )),
      ),
      body: Stack(
        children: <Widget>[
          CameraFeed(widget.cameras, setRecognitions),
          BoundingBox(
            _recognitions == null ? [] : _recognitions,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
          ),
        ],
      ),
    );
  }
}
