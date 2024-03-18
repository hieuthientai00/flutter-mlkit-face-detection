import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

import '../remote/post_image.dart';
import 'camera_down_face/camera_down_face_view.dart';
import 'camera_front_face/camera_front_face_view.dart';
import 'camera_left_face/camera_left_face_view.dart';
import 'camera_right_face/camera_right_face_view.dart';
import 'camera_up_face/camera_up_face_view.dart';
import 'detect_down_face/index.dart';
import 'detect_front_face/index.dart';
import 'detect_left_face/index.dart';
import 'detect_right_face/index.dart';
import 'detect_up_face/index.dart';

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
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('SetState front face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(CameraLeftFaceView.route,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('SetState left face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(CameraRightFaceView.route,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('SetState right face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(CameraDownFaceView.route,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('SetState down face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(CameraUpFaceView.route,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('SetState up face'),
                ),
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    context.push(DetectFrontFacePage.routeName,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('Bloc front face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(DetectLeftFacePage.routeName,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('Bloc left face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(DetectRightFacePage.routeName,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('Bloc right face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(DetectDownFacePage.routeName,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('Bloc down face'),
                ),
                TextButton(
                  onPressed: () {
                    context.push(DetectUpFacePage.routeName,
                        extra: FaceDetector(
                          options: FaceDetectorOptions(
                            minFaceSize: 1,
                          ),
                        ));
                  },
                  child: Text('Bloc up face'),
                ),
                TextButton(
                  onPressed: () async {
                    openGallery(context);
                  },
                  child: Text('Upload image'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openGallery(BuildContext context) async {
    ImagePicker().pickImage(source: ImageSource.gallery).then((xFile) {
      print('Picked file');
      if (xFile != null) {
        print('A file has been picked');
        ApiService.postImage(File(xFile.path)).then((isSuccessfully) {
          print('Sended file');
          if (isSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Upload successfully')),
            );
          }
        });
      }
    });
  }
}
