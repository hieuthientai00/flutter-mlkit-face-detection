import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_down_face_view_screen.dart';

class CameraDownFaceView extends StatelessWidget {
  static final String route = '/camera-down-face-view';

  const CameraDownFaceView({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);
  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CameraDownFaceViewScreen(
          faceDetector: faceDetector,
        ),
      ),
    );
  }
}
