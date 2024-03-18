import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../image_screen.dart';
import 'index.dart';

class DetectDownFaceScreen extends StatelessWidget {
  const DetectDownFaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int captured = 0;
    return BlocConsumer<DetectDownFaceBloc, DetectDownFaceState>(
        bloc: context.read<DetectDownFaceBloc>(),
        listener: (_, DetectDownFaceState currentState) {},
        builder: (_, DetectDownFaceState currentState) {
          if (currentState is InitializedDownCameraState) {
            return Column(
              children: [
                Text(
                  'DOWN FACE',
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
                          if (matched && captured == 0) {
                            captured = 1;
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
