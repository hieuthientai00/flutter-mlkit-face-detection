import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../painters/check_face_direction.dart';
import '../painters/coordinates_translator.dart';

class UpFaceDetectorChecker {
  static void check({
    required Face face,
    required Size canvasSize,
    required Size imageSize,
    required ValueNotifier<bool> checkMatchedNotifier,
  }) {
    final left = ConvertCoordinateImage.convertX(
      face.boundingBox.left,
      canvasSize,
      imageSize,
    );
    final top = ConvertCoordinateImage.convertY(
      face.boundingBox.top,
      canvasSize,
      imageSize,
    );
    final right = ConvertCoordinateImage.convertX(
      face.boundingBox.right,
      canvasSize,
      imageSize,
    );
    final bottom = ConvertCoordinateImage.convertY(
      face.boundingBox.bottom,
      canvasSize,
      imageSize,
    );
    print('''
      raw-DOWN ${face.boundingBox.left} ${face.boundingBox.top} ${face.boundingBox.right} ${face.boundingBox.bottom}
      DOWN $left $top $right $bottom $canvasSize $imageSize
      headEulerAngleX: ${face.headEulerAngleX},
      headEulerAngleY: ${face.headEulerAngleY},
      headEulerAngleZ: ${face.headEulerAngleZ},
      ''');
    checkMatchedNotifier.value = CheckFaceDirection(
      headEulerAngleX: face.headEulerAngleX!,
      headEulerAngleY: face.headEulerAngleY!,
      headEulerAngleZ: face.headEulerAngleZ!,
    ).upFace(face.boundingBox.left, face.boundingBox.top,
        face.boundingBox.right, face.boundingBox.bottom);
  }
}
/*
I/flutter ( 7194):       308.0 128.8 71.19999999999999 365.6
I/flutter ( 7194):       headEulerAngleX: 0.8450696468353271,
I/flutter ( 7194):       headEulerAngleY: -39.43800354003906,
I/flutter ( 7194):       headEulerAngleZ: -7.739866733551025,
*/