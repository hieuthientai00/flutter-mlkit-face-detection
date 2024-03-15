import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class InitializedLeftCameraState extends InDetectLeftFaceState {
  InitializedLeftCameraState({
    required this.controller,
    required this.checkMatchedNotifier,
  }) : super(
            status: InDetectLeftFaceStatus.initial,
            message: 'Initialized camera controller - left face');
  final CameraController controller;
  final ValueNotifier<bool> checkMatchedNotifier;
}
