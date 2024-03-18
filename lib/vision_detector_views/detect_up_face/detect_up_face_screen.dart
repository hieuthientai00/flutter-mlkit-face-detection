import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../image_screen.dart';
import 'index.dart';

class DetectUpFaceScreen extends StatelessWidget {
  const DetectUpFaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetectUpFaceBloc, DetectUpFaceState>(
        bloc: context.read<DetectUpFaceBloc>(),
        listener: (_, DetectUpFaceState currentState) {},
        builder: (_, DetectUpFaceState currentState) {
          if (currentState is InitializedUpCameraState) {
            return Column(
              children: [
                Text(
                  'UP FACE',
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