import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DetectRightFaceState extends Equatable {
  const DetectRightFaceState();

  @override
  List<dynamic> get props => [];
}

/// UnInitialized
class UnDetectRightFaceState extends DetectRightFaceState {
  const UnDetectRightFaceState();

  @override
  String toString() => '$runtimeType';
}

enum InDetectRightFaceStatus { initial, loading, done, error }

/// Initialized
class InDetectRightFaceState extends DetectRightFaceState {
  const InDetectRightFaceState({
    this.status = InDetectRightFaceStatus.initial,
    this.message = '',
  });

  final InDetectRightFaceStatus status;
  final String message;

  InDetectRightFaceState copyWith({
    InDetectRightFaceStatus? status,
    String? message,
  }) =>
      InDetectRightFaceState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  String toString() => '$runtimeType(status: $status, message: $message)';

  @override
  List<dynamic> get props => [status, message];
}

class InitializedRightCameraState extends InDetectRightFaceState {
  InitializedRightCameraState({
    required this.controller,
    required this.checkMatchedNotifier,
  }) : super(
            status: InDetectRightFaceStatus.initial,
            message: 'Initialized camera controller - left face');
  final CameraController controller;
  final ValueNotifier<bool> checkMatchedNotifier;
}
