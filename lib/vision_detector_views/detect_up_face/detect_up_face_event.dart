import 'dart:async';

import 'package:camera/camera.dart';

import '../../utils.dart';
import 'index.dart';

abstract class DetectUpFaceEvent {
  Stream<DetectUpFaceState> applyAsync(
      {DetectUpFaceState currentState, DetectUpFaceBloc bloc});
}

class InitializeCameraEvent extends DetectUpFaceEvent {
  @override
  Stream<DetectUpFaceState> applyAsync(
      {DetectUpFaceState? currentState, DetectUpFaceBloc? bloc}) async* {
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
          print('SIZE INPUT IMAGE: ${image.width} - ${image.height}');
          if (inputImage == null) return;
          bloc.onImage(inputImage);
        });
        yield InitializedUpCameraState(
            controller: bloc.controller!,
            checkMatchedNotifier: bloc.checkMatchedNotifier);
      }
    } catch (error, stackTrace) {
      logger.e('$runtimeType', error: error, stackTrace: stackTrace);
      yield InDetectUpFaceState(
          status: InDetectUpFaceStatus.error, message: error.toString());
    }
  }
}
