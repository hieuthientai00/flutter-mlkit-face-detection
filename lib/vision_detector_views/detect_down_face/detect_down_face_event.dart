import 'dart:async';

import 'package:camera/camera.dart';

import '../../utils.dart';
import 'index.dart';

abstract class DetectDownFaceEvent {
  Stream<DetectDownFaceState> applyAsync(
      {DetectDownFaceState currentState, DetectDownFaceBloc bloc});
}

class InitializeCameraEvent extends DetectDownFaceEvent {
  @override
  Stream<DetectDownFaceState> applyAsync(
      {DetectDownFaceState? currentState, DetectDownFaceBloc? bloc}) async* {
    try {
      if (bloc!.cameras.isEmpty) {
        bloc.cameras = await availableCameras();
      }
      for (var i = 0; i < bloc.cameras.length; i++) {
        if (bloc.cameras[i].lensDirection == Utils.defaultCameraLensDirection) {
          bloc.cameraIndex = i;
          break;
        }
      }

      if (bloc.cameraIndex != -1) {
        final camera = bloc.cameras[bloc.cameraIndex];
        bloc.controller = CameraController(
          camera,
          ResolutionPreset.medium,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.nv21,
        );
        await bloc.controller?.initialize();

        bloc.controller?.startImageStream((image) {
          final inputImage = bloc.inputImageFromCameraImage(image);
          if (inputImage == null) return;
          bloc.onImage(inputImage);
        });
        yield InitializedDownCameraState(
            controller: bloc.controller!,
            checkMatchedNotifier: bloc.checkMatchedNotifier);
      }
    } catch (error, stackTrace) {
      logger.e('$runtimeType', error: error, stackTrace: stackTrace);
      yield InDetectDownFaceState(
          status: InDetectDownFaceStatus.error, message: error.toString());
    }
  }
}
