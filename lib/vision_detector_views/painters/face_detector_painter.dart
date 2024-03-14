import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter({
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
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.face != face;
  }
}


/*
      left    top       right             bottom
Face 331.7 147.7333333 46.93333333333334 432.533333 Size(384.0, 682.7) - Size(1280.0, 720.0)
Face 329.6 149.8666666 49.06666666666666 434.666666 Size(384.0, 682.7) - Size(1280.0, 720.0)
Face 331.2 156.2666666 55.46666666666664 432.000000 Size(384.0, 682.7) - Size(1280.0, 720.0)
Face 328.5 154.1333333 57.60000000000002 429.866666 Size(384.0, 682.7) - Size(1280.0, 720.0)
Face 328.5 156.2666666 57.60000000000002 432.000000 Size(384.0, 682.7) - Size(1280.0, 720.0)
*/