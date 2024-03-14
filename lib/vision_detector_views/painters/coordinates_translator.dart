import 'dart:ui';

class ConvertCoordinateImage {
  static double convertX(
    double x,
    Size canvasSize,
    Size imageSize,
  ) {
    return canvasSize.width - x * canvasSize.width / imageSize.height;
  }

  static double convertY(
    double y,
    Size canvasSize,
    Size imageSize,
  ) {
    return y * canvasSize.height / imageSize.width;
  }
}
