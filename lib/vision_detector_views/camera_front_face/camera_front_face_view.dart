import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_front_face_view_screen.dart';

class CameraFrontFaceView extends StatelessWidget {
  static final String route = '/camera-front-face-view';

  const CameraFrontFaceView({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);
  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CameraFrontFaceViewScreen(
          faceDetector: faceDetector,
        ),
      ),
    );
  }
}
