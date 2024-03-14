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

  // check face nhìn sang bên trái - so với cam trước
  bool checkFaceLeft() {
    return (headEulerAngleY <= -30 && headEulerAngleY >= -70);
  }

  // check face nhìn sang bên phải - so với cam trước
  bool checkFaceRight() {
    return (headEulerAngleY >= 30 && headEulerAngleY <= 70);
  }

  // check face giữa không sang trái phải - so với cam trước
  bool checkFaceNotLeftRight() {
    return (headEulerAngleY > -10 && headEulerAngleY < 10);
  }

  // check face nhìn lên - so với cam trước
  bool checkFaceUp() {
    return (headEulerAngleX <= -30 && headEulerAngleX >= -70);
  }

  // check face nhìn xuống - so với cam trước
  bool checkFaceDown() {
    return (headEulerAngleX >= 30 && headEulerAngleX <= 70);
  }

  // check face giữa không lên không xuống - so với cam trước
  bool checkFaceNotUpDown() {
    return (headEulerAngleX > -10 && headEulerAngleX < 10);
  }

  // check đầu thẳng đứng không nghiêng - so với cam trước
  bool checkFaceStraight() {
    return (headEulerAngleZ >= -10 && headEulerAngleZ <= 10);
  }

  // step 1 : capture full face - so với cam trước
  bool fullFace(double left, double top, double right, double bottom) {
    return (checkFaceMatchingFrame(left, top, right, bottom) &&
        checkFaceNotUpDown() &&
        checkFaceNotLeftRight() &&
        checkFaceStraight());
  }

  // step 2 : capture left face - so với cam trước
  bool faceLeft(double left, double top, double right, double bottom) {
    return (checkFaceMatchingFrame(left, top, right, bottom) &&
        checkFaceLeft() &&
        checkFaceNotUpDown() &&
        checkFaceStraight());
  }

  // step 3 : capture right face - so với cam trước
  bool faceRight(double left, double top, double right, double bottom) {
    return (checkFaceMatchingFrame(left, top, right, bottom) &&
        checkFaceRight() &&
        checkFaceNotUpDown() &&
        checkFaceStraight());
  }
}
