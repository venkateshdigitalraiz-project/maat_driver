import 'package:equatable/equatable.dart';

abstract class DriverHomeEvent extends Equatable {
  const DriverHomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadDriverHomeDataEvent extends DriverHomeEvent {
  const LoadDriverHomeDataEvent();
}

class ToggleOnlineEvent extends DriverHomeEvent {
  final bool isOnline;

  const ToggleOnlineEvent(this.isOnline);

  @override
  List<Object?> get props => [isOnline];
}

class AcceptRideEvent extends DriverHomeEvent {
  final String requestId;

  const AcceptRideEvent(this.requestId);

  @override
  List<Object?> get props => [requestId];
}

class DeclineRideEvent extends DriverHomeEvent {
  final String requestId;

  const DeclineRideEvent(this.requestId);

  @override
  List<Object?> get props => [requestId];
}
