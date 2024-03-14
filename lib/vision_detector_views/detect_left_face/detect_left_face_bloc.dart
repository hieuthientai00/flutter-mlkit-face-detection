import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils.dart';
import 'index.dart';

class DetectLeftFaceBloc
    extends Bloc<DetectLeftFaceEvent, DetectLeftFaceState> {
  DetectLeftFaceBloc(DetectLeftFaceState initialState) : super(initialState) {
    on<DetectLeftFaceEvent>((event, emit) {
      return emit.forEach<DetectLeftFaceState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          logger.e('$runtimeType', error: error, stackTrace: stackTrace);
          return InDetectLeftFaceState(
              status: InDetectLeftFaceStatus.error, message: error.toString());
        },
      );
    });
  }
}
