import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class DetectRightFaceScreen extends StatelessWidget {
  const DetectRightFaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetectRightFaceBloc, DetectRightFaceState>(
        bloc: context.read<DetectRightFaceBloc>(),
        listener: (_, DetectRightFaceState currentState) {
          if (currentState is UnDetectRightFaceState) {}
          if (currentState is InDetectRightFaceState &&
              currentState.status == InDetectRightFaceStatus.loading) {}
          if (currentState is InDetectRightFaceState &&
              currentState.status == InDetectRightFaceStatus.error) {}
        },
        builder: (_, DetectRightFaceState currentState) {
          if (currentState is InDetectRightFaceState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.message),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
