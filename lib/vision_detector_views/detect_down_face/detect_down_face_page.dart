import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'index.dart';

class DetectDownFacePage extends StatelessWidget {
  static const String routeName = '/detectDownFace';

  const DetectDownFacePage({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);

  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
        create: (BuildContext context) => DetectDownFaceBloc(
          const UnDetectDownFaceState(),
          faceDetector: faceDetector,
        )..add(InitializeCameraEvent()),
        child: const DetectDownFaceScreen(),
      ),
    ));
  }
}
