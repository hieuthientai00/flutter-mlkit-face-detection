import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'index.dart';

class DetectRightFacePage extends StatelessWidget {
  static const String routeName = '/detectRightFace';

  const DetectRightFacePage({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);

  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
        create: (BuildContext context) => DetectRightFaceBloc(
          const UnDetectRightFaceState(),
          faceDetector: faceDetector,
        )..add(InitializeCameraEvent()),
        child: const DetectRightFaceScreen(),
      ),
    ));
  }
}
