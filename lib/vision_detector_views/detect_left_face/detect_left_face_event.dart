import 'dart:async';
import '../../utils.dart';
import 'index.dart';

abstract class DetectLeftFaceEvent {
  Stream<DetectLeftFaceState> applyAsync(
      {DetectLeftFaceState currentState, DetectLeftFaceBloc bloc});
}

class LoadDetectLeftFaceEvent extends DetectLeftFaceEvent {
  @override
  Stream<DetectLeftFaceState> applyAsync(
      {DetectLeftFaceState? currentState, DetectLeftFaceBloc? bloc}) async* {
    try {
      yield const UnDetectLeftFaceState();
      await Future.delayed(const Duration(seconds: 1));
      yield const InDetectLeftFaceState(message: 'Hello world!');
    } catch (error, stackTrace) {
      logger.e('$runtimeType', error: error, stackTrace: stackTrace);
      yield InDetectLeftFaceState(
          status: InDetectLeftFaceStatus.error, message: error.toString());
    }
  }
}
