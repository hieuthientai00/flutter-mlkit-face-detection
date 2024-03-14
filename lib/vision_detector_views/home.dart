import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_left_face/camera_left_face_view.dart';
import 'camera_right_face/camera_right_face_view.dart';
import 'detect_front_face/index.dart';

class HomePage extends StatelessWidget {
  static final String route = '/home-page';

  HomePage({Key? key}) : super(key: key);
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.push(DetectFrontFacePage.routeName,
                    extra: faceDetector);
                // context.push(CameraFrontFaceView.route, extra: faceDetector);
              },
              child: Text('Go to camera front face'),
            ),
            TextButton(
              onPressed: () {
                context.push(CameraLeftFaceView.route, extra: faceDetector);
              },
              child: Text('Go to camera left face'),
            ),
            TextButton(
              onPressed: () {
                context.push(CameraRightFaceView.route, extra: faceDetector);
              },
              child: Text('Go to camera right face'),
            ),
          ],
        ),
      ),
    );
  }
}
