import 'dart:async';

import '../../utils.dart';
import 'index.dart';

abstract class DetectRightFaceEvent {
  Stream<DetectRightFaceState> applyAsync(
      {DetectRightFaceState currentState, DetectRightFaceBloc bloc});
}

class LoadDetectRightFaceEvent extends DetectRightFaceEvent {
  @override
  Stream<DetectRightFaceState> applyAsync(
      {DetectRightFaceState? currentState, DetectRightFaceBloc? bloc}) async* {
    try {
      yield const UnDetectRightFaceState();
      await Future.delayed(const Duration(seconds: 1));
      yield const InDetectRightFaceState(message: 'Hello world!');
    } catch (error, stackTrace) {
      logger.e('$runtimeType', error: error, stackTrace: stackTrace);
      yield InDetectRightFaceState(
          status: InDetectRightFaceStatus.error, message: error.toString());
    }
  }
}
