import 'package:equatable/equatable.dart';
import '../../domain/entities/driver_home_entities.dart';

abstract class DriverHomeState extends Equatable {
  const DriverHomeState();

  @override
  List<Object?> get props => [];
}

class DriverHomeLoading extends DriverHomeState {
  const DriverHomeLoading();
}

class DriverHomeLoaded extends DriverHomeState {
  final DriverHomeDataEntity data;
  final bool isTogglingOnline;
  final String? toastMessage;

  const DriverHomeLoaded({
    required this.data,
    this.isTogglingOnline = false,
    this.toastMessage,
  });

  DriverHomeLoaded copyWith({
    DriverHomeDataEntity? data,
    bool? isTogglingOnline,
    String? toastMessage,
  }) {
    return DriverHomeLoaded(
      data: data ?? this.data,
      isTogglingOnline: isTogglingOnline ?? this.isTogglingOnline,
      toastMessage: toastMessage,
    );
  }

  @override
  List<Object?> get props => [data, isTogglingOnline, toastMessage];
}

class DriverHomeError extends DriverHomeState {
  final String message;

  const DriverHomeError(this.message);

  @override
  List<Object?> get props => [message];
}
