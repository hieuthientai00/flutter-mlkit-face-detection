import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

var logger = Logger();

class Utils {
  static final CameraLensDirection frontCameraLensDirection =
      CameraLensDirection.front;
  static final CameraLensDirection backCameraLensDirection =
      CameraLensDirection.back;
  static final CameraLensDirection defaultCameraLensDirection =
      CameraLensDirection.front;
  static final double widthMin = 720.0;
  static final double widthMax = 1280.0;
  static final Size frontFaceCanvasSize = Size(384.0, 576.0);
  static final Size defaultMinFaceCanvasSize = Size(384.0, 576.0);
  static final Size defaultMaxFaceCanvasSize = Size(384.0, 682.7);
  static final Size leftFaceCanvasSize = Size(384.0, 682.7);
  static final Size rightFaceCanvasSize = Size(384.0, 576.0);
  static final Size downFaceCanvasSize = Size(384.0, 576.0);
  static final Size upFaceCanvasSize = Size(384.0, 576.0);
  static final baseUrl = 'http://10.0.2.2:3000';
  static final imageUrl = '/image';
}
