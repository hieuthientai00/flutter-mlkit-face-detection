import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../painters/check_face_direction.dart';
import '../painters/coordinates_translator.dart';

class FullFaceDetectorChecker {
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
    print(
      '''
      RAW ${face.boundingBox.left} ${face.boundingBox.top} ${face.boundingBox.right} ${face.boundingBox.bottom}
      FRONT $left $top $right $bottom $canvasSize $imageSize
      headEulerAngleX: ${face.headEulerAngleX},
      headEulerAngleY: ${face.headEulerAngleY},
      headEulerAngleZ: ${face.headEulerAngleZ},
      '''
    );
    checkMatchedNotifier.value = CheckFaceDirection(
      headEulerAngleX: face.headEulerAngleX!,
      headEulerAngleY: face.headEulerAngleY!,
      headEulerAngleZ: face.headEulerAngleZ!,
    ).fullFace(left, top, right, bottom);
  }
}


/*
      left    top       right             bottom
Face 331.7 147.7333333 46.93333333333334 432.533333 Size(384.0, 682.7) - Size(1280.0, 720.0)
Face 329.6 149.8666666 49.06666666666666 434.666666 Size(384.0, 682.7) - Size(1280.0, 720.0)
Face 331.2 156.2666666 55.46666666666664 432.000000 Size(384.0, 682.7) - Size(1280.0, 720.0)
Face 328.5 154.1333333 57.60000000000002 429.866666 Size(384.0, 682.7) - Size(1280.0, 720.0)
Face 328.5 156.2666666 57.60000000000002 432.000000 Size(384.0, 682.7) - Size(1280.0, 720.0)

Canvas size: Size(384.0, 576.0)
*/