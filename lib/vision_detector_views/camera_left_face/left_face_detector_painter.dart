import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../painters/check_face_direction.dart';
import '../painters/coordinates_translator.dart';

class LeftFaceDetectorPainter extends CustomPainter {
  LeftFaceDetectorPainter({
    required this.face,
    required this.imageSize,
    required this.checkMatched,
    required this.painter,
  });

  final Paint painter;
  final Face face;
  final Size imageSize;
  final void Function(bool) checkMatched;

  @override
  void paint(Canvas canvas, Size size) {
    final left = ConvertCoordinateImage.convertX(
      face.boundingBox.left,
      size,
      imageSize,
    );
    final top = ConvertCoordinateImage.convertY(
      face.boundingBox.top,
      size,
      imageSize,
    );
    final right = ConvertCoordinateImage.convertX(
      face.boundingBox.right,
      size,
      imageSize,
    );
    final bottom = ConvertCoordinateImage.convertY(
      face.boundingBox.bottom,
      size,
      imageSize,
    );
    canvas.drawRect(
      Rect.fromLTRB(left, top, right, bottom),
      painter,
    );
    print('''
      raw ${face.boundingBox.left} ${face.boundingBox.top} ${face.boundingBox.right} ${face.boundingBox.bottom}
      left $left $top $right $bottom $size $imageSize
      headEulerAngleX: ${face.headEulerAngleX},
      headEulerAngleY: ${face.headEulerAngleY},
      headEulerAngleZ: ${face.headEulerAngleZ},
      ''');
    checkMatched(CheckFaceDirection(
      headEulerAngleX: face.headEulerAngleX!,
      headEulerAngleY: face.headEulerAngleY!,
      headEulerAngleZ: face.headEulerAngleZ!,
    ).faceLeft(face.boundingBox.left, face.boundingBox.top,
        face.boundingBox.right, face.boundingBox.bottom));
  }

  @override
  bool shouldRepaint(LeftFaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.face != face;
  }
}


/*
332.0 154.4 55.19999999999999 431.2 Size(384.0, 576.0)
*/