import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DetectDownFaceState extends Equatable {
  const DetectDownFaceState();

  @override
  List<dynamic> get props => [];
}

/// UnInitialized
class UnDetectDownFaceState extends DetectDownFaceState {
  const UnDetectDownFaceState();

  @override
  String toString() => '$runtimeType';
}

enum InDetectDownFaceStatus { initial, loading, done, error }

/// Initialized
class InDetectDownFaceState extends DetectDownFaceState {
  const InDetectDownFaceState({
    this.status = InDetectDownFaceStatus.initial,
    this.message = '',
  });

  final InDetectDownFaceStatus status;
  final String message;

  InDetectDownFaceState copyWith({
    InDetectDownFaceStatus? status,
    String? message,
  }) =>
      InDetectDownFaceState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  String toString() => '$runtimeType(status: $status, message: $message)';

  @override
  List<dynamic> get props => [status, message];
}

class InitializedDownCameraState extends InDetectDownFaceState {
  InitializedDownCameraState({
    required this.controller,
    required this.checkMatchedNotifier,
  }) : super(
            status: InDetectDownFaceStatus.initial,
            message: 'Initialized camera controller - left face');
  final CameraController controller;
  final ValueNotifier<bool> checkMatchedNotifier;
}
