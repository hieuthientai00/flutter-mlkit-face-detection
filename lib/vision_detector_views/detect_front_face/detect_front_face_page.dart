import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'index.dart';

class DetectFrontFacePage extends StatelessWidget {
  static const String routeName = '/detectFrontFace';

  const DetectFrontFacePage({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);
  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (BuildContext context) => DetectFrontFaceBloc(
        const UnDetectFrontFaceState(),
        faceDetector: faceDetector,
      )..add(InitializedFrontCamera()),
      child: DetectFrontFaceScreen(
        faceDetector: faceDetector,
      ),
    ));
  }
}
