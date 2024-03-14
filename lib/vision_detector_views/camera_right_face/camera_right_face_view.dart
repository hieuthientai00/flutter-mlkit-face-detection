import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_right_face_view_screen.dart';

class CameraRightFaceView extends StatelessWidget {
  static final String route = '/camera-right-face-view';

  const CameraRightFaceView({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);
  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CameraRightFaceViewScreen(
          faceDetector: faceDetector,
        ),
      ),
    );
  }
}
