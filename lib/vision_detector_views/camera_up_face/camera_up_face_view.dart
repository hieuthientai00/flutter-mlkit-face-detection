import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_up_face_view_screen.dart';

class CameraUpFaceView extends StatelessWidget {
  static final String route = '/camera-up-face-view';

  const CameraUpFaceView({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);
  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CameraUpFaceViewScreen(
          faceDetector: faceDetector,
        ),
      ),
    );
  }
}
