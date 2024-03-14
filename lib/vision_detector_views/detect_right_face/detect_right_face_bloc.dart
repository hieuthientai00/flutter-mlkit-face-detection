import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils.dart';
import 'index.dart';

class DetectRightFaceBloc
    extends Bloc<DetectRightFaceEvent, DetectRightFaceState> {
  DetectRightFaceBloc(DetectRightFaceState initialState) : super(initialState) {
    on<DetectRightFaceEvent>((event, emit) {
      return emit.forEach<DetectRightFaceState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          logger.e('$runtimeType', error: error, stackTrace: stackTrace);
          return InDetectRightFaceState(
              status: InDetectRightFaceStatus.error, message: error.toString());
        },
      );
    });
  }
}
