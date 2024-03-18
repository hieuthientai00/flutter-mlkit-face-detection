import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../utils.dart';
import 'left_face_detector_painter.dart';

class CameraLeftFaceViewScreen extends StatefulWidget {
  CameraLeftFaceViewScreen({
    Key? key,
    required this.faceDetector,
  }) : super(key: key);

  final FaceDetector faceDetector;

  @override
  State<CameraLeftFaceViewScreen> createState() =>
      _CameraLeftFaceViewScreenState();
}

class _CameraLeftFaceViewScreenState extends State<CameraLeftFaceViewScreen> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  LeftFaceDetectorPainter? facePainter;
  int _cameraIndex = -1;
  bool checkMatched = false;
  final Paint painter = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..color = Colors.red;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == Utils.defaultCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
    _controller = null;
    widget.faceDetector.close();
    super.dispose();
    print('DISPOSE $this');
  }

  @override
  Widget build(BuildContext context) {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return Column(
      children: [
        Text(
          'LEFT FACE',
          style: TextStyle(fontSize: 30, color: Colors.red),
        ),
        Stack(
          fit: StackFit.loose,
          children: [
            CameraPreview(
              _controller!,
              child: CustomPaint(
                painter: facePainter,
              ),
            ),
            Positioned(
              left: 50,
              top: 150,
              right: 50,
              child: Image(
                color: checkMatched ? Colors.green : Colors.red,
                image: AssetImage('assets/images/icon-scan2.png'),
              ),
              // ValueListenableBuilder<bool>(
              //   valueListenable: checkMatchedNotifier,
              //   builder: (context, matched, child) {
              //     if (matched) {
              //       // _controller?.pausePreview().then((_) {
              //       //   _controller?.takePicture().then((picture) {
              //       //     context.go(ImageView.route, extra: picture.path);
              //       //   });
              //       // });
              //       return Image(
              //         color: Colors.green,
              //         image: AssetImage('assets/images/icon-scan2.png'),
              //       );
              //     }
              //     return Image(
              //       color: Colors.red,
              //       image: AssetImage('assets/images/icon-scan2.png'),
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> onImage(InputImage inputImage) async {
    widget.faceDetector.processImage(inputImage).then((faces) {
      if (faces.isNotEmpty) {
        final face = faces[0];
        if (inputImage.metadata?.size != null &&
            inputImage.metadata?.rotation != null) {
          facePainter = LeftFaceDetectorPainter(
              painter: painter,
              face: face,
              imageSize: inputImage.metadata!.size,
              checkMatched: (matched) {
                checkMatched = matched;
              });
        } else {
          facePainter = null;
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(camera, ResolutionPreset.medium,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.nv21);
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {
        print('Initialized camera controller');
      });
    });
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    onImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    // if (Platform.isIOS) {
    //   rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    // } else if (Platform.isAndroid) {
    var rotationCompensation =
        _orientations[_controller!.value.deviceOrientation];
    if (rotationCompensation == null) return null;

    rotationCompensation = (sensorOrientation + rotationCompensation) % 360;

    rotation = InputImageRotationValue.fromRawValue(rotationCompensation);

    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
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
}
