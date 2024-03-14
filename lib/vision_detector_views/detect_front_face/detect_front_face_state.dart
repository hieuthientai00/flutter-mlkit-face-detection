import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DetectFrontFaceState extends Equatable {
  const DetectFrontFaceState();

  @override
  List<dynamic> get props => [];
}

/// UnInitialized
class UnDetectFrontFaceState extends DetectFrontFaceState {
  const UnDetectFrontFaceState();

  @override
  String toString() => '$runtimeType';
}

enum InDetectFrontFaceStatus { initial, loading, done, error }

/// Initialized
class InDetectFrontFaceState extends DetectFrontFaceState {
  const InDetectFrontFaceState({
    this.status = InDetectFrontFaceStatus.initial,
    this.message = '',
  });

  final InDetectFrontFaceStatus status;
  final String message;

  InDetectFrontFaceState copyWith({
    InDetectFrontFaceStatus? status,
    String? message,
  }) =>
      InDetectFrontFaceState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  String toString() => '$runtimeType(status: $status, message: $message)';

  @override
  List<dynamic> get props => [status, message];
}

class InitializedFrontCameraState extends InDetectFrontFaceState {
  InitializedFrontCameraState({
    required this.controller,
    required this.checkMatchedNotifier,
  }) : super(
            status: InDetectFrontFaceStatus.initial,
            message: 'Initialized camera controller');
  final CameraController controller;
  final ValueNotifier<bool> checkMatchedNotifier;
}
