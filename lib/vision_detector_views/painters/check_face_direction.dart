class CheckFaceDirection {
  const CheckFaceDirection({
    required this.headEulerAngleX,
    required this.headEulerAngleY,
    required this.headEulerAngleZ,
  });

  final double headEulerAngleX;
  final double headEulerAngleY;
  final double headEulerAngleZ;

  // check face khớp với khung
  bool checkFaceMatchingFrame(
      double left, double top, double right, double bottom) {
    return (left >= 310 &&
        left <= 335 &&
        top >= 140 &&
        top <= 170 &&
        right > 40 &&
        right <= 60 &&
        bottom >= 410 &&
        bottom <= 440);
  }

  // check face nhìn sang bên trái
  bool checkFaceLeft() {
    return (headEulerAngleY <= -30 && headEulerAngleY >= -70);
  }

  // check face nhìn sang bên phải
  bool checkFaceRight() {
    return (headEulerAngleY >= 30 && headEulerAngleY <= 70);
  }

  // check face giữa không sang trái phải
  bool checkFaceNotLeftRight() {
    return (headEulerAngleY > -10 && headEulerAngleY < 10);
  }

  // check face nhìn lên
  bool checkFaceUp() {
    return (headEulerAngleX <= -30 && headEulerAngleX >= -70);
  }

  // check face nhìn xuống
  bool checkFaceDown() {
    return (headEulerAngleX >= 30 && headEulerAngleX <= 70);
  }

  // check face giữa không lên không xuống
  bool checkFaceNotUpDown() {
    return (headEulerAngleX > -10 && headEulerAngleX < 10);
  }

  // check đầu thẳng đứng không nghiêng
  bool checkFaceStraight() {
    return (headEulerAngleZ >= -10 && headEulerAngleZ <= 10);
  }

  // step 1 : capture full face
  bool fullFace(double left, double top, double right, double bottom) {
    return (checkFaceMatchingFrame(left, top, right, bottom) &&
        checkFaceNotUpDown() &&
        checkFaceNotLeftRight() &&
        checkFaceStraight());
  }

  // step 2 : capture left face
  bool faceLeft(double left, double top, double right, double bottom) {
    return (checkFaceMatchingFrame(left, top, right, bottom) &&
        checkFaceLeft() &&
        checkFaceNotUpDown() &&
        checkFaceStraight());
  }

  // step 3 : capture right face
  bool faceRight(double left, double top, double right, double bottom) {
    return (checkFaceMatchingFrame(left, top, right, bottom) &&
        checkFaceRight() &&
        checkFaceNotUpDown() &&
        checkFaceStraight());
  }
}
