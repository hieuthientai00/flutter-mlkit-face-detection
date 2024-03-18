import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DetectUpFaceState extends Equatable {
  const DetectUpFaceState();

  @override
  List<dynamic> get props => [];
}

/// UnInitialized
class UnDetectUpFaceState extends DetectUpFaceState {
  const UnDetectUpFaceState();

  @override
  String toString() => '$runtimeType';
}

enum InDetectUpFaceStatus { initial, loading, done, error }

/// Initialized
class InDetectUpFaceState extends DetectUpFaceState {
  const InDetectUpFaceState({
    this.status = InDetectUpFaceStatus.initial,
    this.message = '',
  });

  final InDetectUpFaceStatus status;
  final String message;

  InDetectUpFaceState copyWith({
    InDetectUpFaceStatus? status,
    String? message,
  }) =>
      InDetectUpFaceState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  String toString() => '$runtimeType(status: $status, message: $message)';

  @override
  List<dynamic> get props => [status, message];
}

class InitializedUpCameraState extends InDetectUpFaceState {
  InitializedUpCameraState({
    required this.controller,
    required this.checkMatchedNotifier,
  }) : super(
            status: InDetectUpFaceStatus.initial,
            message: 'Initialized camera controller - left face');
  final CameraController controller;
  final ValueNotifier<bool> checkMatchedNotifier;
}
