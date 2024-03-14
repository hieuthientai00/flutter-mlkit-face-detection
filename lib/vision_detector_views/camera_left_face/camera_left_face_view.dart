import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_left_face_view_screen.dart';

class CameraLeftFaceView extends StatelessWidget {
  static final String route = '/camera-left-face-view';

  const CameraLeftFaceView({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);
  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CameraLeftFaceViewScreen(
          faceDetector: faceDetector,
        ),
      ),
    );
  }
}
