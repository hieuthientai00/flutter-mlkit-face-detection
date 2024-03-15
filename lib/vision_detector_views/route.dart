import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_front_face/camera_front_face_view.dart';
import 'camera_left_face/camera_left_face_view.dart';
import 'camera_right_face/camera_right_face_view.dart';
import 'detect_front_face/index.dart';
import 'detect_left_face/index.dart';
import 'detect_right_face/index.dart';
import 'home.dart';
import 'image_screen.dart';

final router = GoRouter(
  initialLocation: HomePage.route,
  routes: [
    GoRoute(
      path: HomePage.route,
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: CameraFrontFaceView.route,
      builder: (context, state) =>
          CameraFrontFaceView(faceDetector: state.extra as FaceDetector),
    ),
    GoRoute(
      path: CameraRightFaceView.route,
      builder: (context, state) =>
          CameraRightFaceView(faceDetector: state.extra as FaceDetector),
    ),
    GoRoute(
      path: CameraLeftFaceView.route,
      builder: (context, state) =>
          CameraLeftFaceView(faceDetector: state.extra as FaceDetector),
    ),
    GoRoute(
      path: DetectFrontFacePage.routeName,
      builder: (context, state) => DetectFrontFacePage(
        faceDetector: state.extra as FaceDetector,
      ),
    ),
    GoRoute(
      path: DetectLeftFacePage.routeName,
      builder: (context, state) => DetectLeftFacePage(
        faceDetector: state.extra as FaceDetector,
      ),
    ),
    GoRoute(
      path: DetectRightFacePage.routeName,
      builder: (context, state) => DetectRightFacePage(
        faceDetector: state.extra as FaceDetector,
      ),
    ),
    GoRoute(
      path: ImageView.route,
      builder: (context, state) => ImageView(path: state.extra as String),
    ),
  ],
);
