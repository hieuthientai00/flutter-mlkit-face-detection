import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../image_screen.dart';
import 'index.dart';

class DetectFrontFaceScreen extends StatelessWidget {
  DetectFrontFaceScreen({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);
  final FaceDetector faceDetector;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetectFrontFaceBloc, DetectFrontFaceState>(
        bloc: context.read<DetectFrontFaceBloc>(),
        listener: (_, DetectFrontFaceState currentState) {},
        builder: (_, DetectFrontFaceState currentState) {
          if (currentState is InitializedFrontCameraState) {
            return Column(
              children: [
                Text(
                  'FRONT FACE',
                  style: TextStyle(fontSize: 30, color: Colors.red),
                ),
                Stack(
                  fit: StackFit.loose,
                  children: [
                    CameraPreview(
                      currentState.controller,
                    ),
                    Positioned(
                      left: 50,
                      top: 150,
                      right: 50,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: currentState.checkMatchedNotifier,
                        builder: (context, matched, child) {
                          if (matched) {
                            currentState.controller.pausePreview().then((_) {
                              currentState.controller
                                  .takePicture()
                                  .then((picture) {
                                context.pushReplacement(ImageView.route,
                                    extra: picture.path);
                              });
                            });
                            return Image(
                              color: Colors.green,
                              image: AssetImage('assets/images/icon-scan2.png'),
                            );
                          }
                          return Image(
                            color: Colors.red,
                            image: AssetImage('assets/images/icon-scan2.png'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        });
  }
}
