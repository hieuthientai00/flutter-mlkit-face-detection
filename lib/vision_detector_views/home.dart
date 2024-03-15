import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_front_face/camera_front_face_view.dart';
import 'camera_left_face/camera_left_face_view.dart';
import 'camera_right_face/camera_right_face_view.dart';
import 'detect_front_face/index.dart';
import 'detect_left_face/index.dart';
import 'detect_right_face/index.dart';

class HomePage extends StatelessWidget {
  static final String route = '/home-page';

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    context.push(CameraFrontFaceView.route,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(),
                        ));
                  },
                  child: Text('SetState front face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(CameraLeftFaceView.route,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(),
                        ));
                  },
                  child: Text('SetState left face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(CameraRightFaceView.route,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(),
                        ));
                  },
                  child: Text('SetState right face'),
                ),
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    context.push(DetectFrontFacePage.routeName,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(),
                        ));
                  },
                  child: Text('Bloc front face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(DetectLeftFacePage.routeName,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(),
                        ));
                  },
                  child: Text('Bloc left face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(DetectRightFacePage.routeName,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(),
                        ));
                  },
                  child: Text('Bloc right face'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
