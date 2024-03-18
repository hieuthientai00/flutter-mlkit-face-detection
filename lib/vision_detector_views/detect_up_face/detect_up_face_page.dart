import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'index.dart';

class DetectUpFacePage extends StatelessWidget {
  static const String routeName = '/detectUpFace';

  const DetectUpFacePage({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);

  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
        create: (BuildContext context) => DetectUpFaceBloc(
          const UnDetectUpFaceState(),
          faceDetector: faceDetector,
        )..add(InitializeCameraEvent()),
        child: const DetectUpFaceScreen(),
      ),
    ));
  }
}
