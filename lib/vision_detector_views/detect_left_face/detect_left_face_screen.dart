import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class DetectLeftFaceScreen extends StatelessWidget {
  const DetectLeftFaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetectLeftFaceBloc, DetectLeftFaceState>(
        bloc: context.read<DetectLeftFaceBloc>(),
        listener: (_, DetectLeftFaceState currentState) {
          if (currentState is UnDetectLeftFaceState) {}
          if (currentState is InDetectLeftFaceState &&
              currentState.status == InDetectLeftFaceStatus.loading) {}
          if (currentState is InDetectLeftFaceState &&
              currentState.status == InDetectLeftFaceStatus.error) {}
        },
        builder: (_, DetectLeftFaceState currentState) {
          if (currentState is InDetectLeftFaceState) {
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
