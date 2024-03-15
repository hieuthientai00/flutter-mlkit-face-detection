import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../utils.dart';
import 'index.dart';

class DetectFrontFaceBloc
    extends Bloc<DetectFrontFaceEvent, DetectFrontFaceState> {
  DetectFrontFaceBloc(
    DetectFrontFaceState initialState, {
    required this.faceDetector,
  }) : super(initialState) {
    on<DetectFrontFaceEvent>((event, emit) {
      return emit.forEach<DetectFrontFaceState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          logger.e('$runtimeType', error: error, stackTrace: stackTrace);
          return InDetectFrontFaceState(
              status: InDetectFrontFaceStatus.error, message: error.toString());
        },
      );
    });
  }
  /* ---------Value--------- */
  final ValueNotifier<bool> checkMatchedNotifier = ValueNotifier<bool>(false);
  final FaceDetector faceDetector;
  CameraController? controller;
  List<CameraDescription> cameras = [];
  int cameraIndex = -1;
  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };
  /* ----------------------- */

  /* ---------Function--------- */

  InputImage? inputImageFromCameraImage(CameraImage image) {
    if (controller == null) return null;
    final camera = cameras[cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    // if (Platform.isIOS) {
    //   rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    // } else if (Platform.isAndroid) {
    var rotationCompensation =
        _orientations[controller!.value.deviceOrientation];
    if (rotationCompensation == null) return null;

    rotationCompensation = (sensorOrientation + rotationCompensation) % 360;

    rotation = InputImageRotationValue.fromRawValue(rotationCompensation);

    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;
    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
  /* ----------------------- */

  Future<void> onImage(InputImage inputImage) async {
    faceDetector.processImage(inputImage).then((faces) {
      if (faces.isNotEmpty) {
        final face = faces[0];
        if (inputImage.metadata?.size != null &&
            inputImage.metadata?.rotation != null) {
          FullFaceDetectorChecker.check(
            face: face,
            canvasSize: Utils.frontFaceCanvasSize,
            imageSize: inputImage.metadata!.size,
            checkMatchedNotifier: checkMatchedNotifier,
          );
        }
      }
    });
  }

  @override
  Future<void> close() {
    controller?.stopImageStream();
    controller?.dispose();
    controller = null;
    faceDetector.close();
    print('DISPOSE $this');
    return super.close();
  }
}
