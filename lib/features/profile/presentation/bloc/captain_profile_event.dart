import 'package:equatable/equatable.dart';

abstract class CaptainProfileEvent extends Equatable {
  const CaptainProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadCaptainProfileEvent extends CaptainProfileEvent {
  const LoadCaptainProfileEvent();
}

class ToggleCarpoolHostModeEvent extends CaptainProfileEvent {
  final bool isActive;

  const ToggleCarpoolHostModeEvent(this.isActive);

  @override
  List<Object?> get props => [isActive];
}
