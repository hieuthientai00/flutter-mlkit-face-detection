import 'package:equatable/equatable.dart';

abstract class DetectLeftFaceState extends Equatable {
  const DetectLeftFaceState();

  @override
  List<dynamic> get props => [];
}

/// UnInitialized
class UnDetectLeftFaceState extends DetectLeftFaceState {
  const UnDetectLeftFaceState();

  @override
  String toString() => '$runtimeType';
}

enum InDetectLeftFaceStatus { initial, loading, done, error }

/// Initialized
class InDetectLeftFaceState extends DetectLeftFaceState {
  const InDetectLeftFaceState({
    this.status = InDetectLeftFaceStatus.initial,
    this.message = '',
  });

  final InDetectLeftFaceStatus status;
  final String message;

  InDetectLeftFaceState copyWith({
    InDetectLeftFaceStatus? status,
    String? message,
  }) =>
      InDetectLeftFaceState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  String toString() => '$runtimeType(status: $status, message: $message)';

  @override
  List<dynamic> get props => [status, message];
}
