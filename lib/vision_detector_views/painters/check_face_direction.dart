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
    return (left >= 50 &&
        left <= 90 &&
        top >= 170 &&
        top <= 210 &&
        right > 390 &&
        right <= 430 &&
        bottom >= 510 &&
        bottom <= 550);
  }

  // check face chụp mặt bên trái - so với cam trước
  bool checkFaceLeft() {
    return (headEulerAngleY >= 20 && headEulerAngleY <= 80); // camera sau
    // return (headEulerAngleY <= -20 && headEulerAngleY >= -80); // camera truoc
  }

  // check face nhìn sang bên phải - so với cam trước
  bool checkFaceRight() {
    return (headEulerAngleY <= -20 && headEulerAngleY >= -80);
    // return (headEulerAngleY >= 20 && headEulerAngleY <= 80); // camera truoc
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
    final result = checkFaceMatchingFrame(left, top, right, bottom) &&
        checkFaceLeft() &&
        checkFaceNotUpDown() &&
        checkFaceStraight();
    return result;
  }

  // step 3 : capture right face - so với cam trước
  bool faceRight(double left, double top, double right, double bottom) {
    return (checkFaceMatchingFrame(left, top, right, bottom) &&
        checkFaceRight() &&
        checkFaceNotUpDown() &&
        checkFaceStraight());
  }
}
