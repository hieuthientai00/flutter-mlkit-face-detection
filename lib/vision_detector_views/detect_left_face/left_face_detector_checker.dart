import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../painters/check_face_direction.dart';
import '../painters/coordinates_translator.dart';

class LeftFaceDetectorChecker {
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
      raw-LEFT ${face.boundingBox.left} ${face.boundingBox.top} ${face.boundingBox.right} ${face.boundingBox.bottom}
      LEFT $left $top $right $bottom $canvasSize $imageSize
      headEulerAngleX: ${face.headEulerAngleX},
      headEulerAngleY: ${face.headEulerAngleY},
      headEulerAngleZ: ${face.headEulerAngleZ},
      ''');
    checkMatchedNotifier.value = CheckFaceDirection(
      headEulerAngleX: face.headEulerAngleX!,
      headEulerAngleY: face.headEulerAngleY!,
      headEulerAngleZ: face.headEulerAngleZ!,
    ).faceLeft(face.boundingBox.left, face.boundingBox.top,
        face.boundingBox.right, face.boundingBox.bottom);
  }
}
/*
330.4 158.4 53.60000000000002 435.2 Size(384.0, 576.0)
*/