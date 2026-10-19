import 'package:equatable/equatable.dart';
import '../../domain/entities/captain_profile_entity.dart';

abstract class CaptainProfileState extends Equatable {
  const CaptainProfileState();

  @override
  List<Object?> get props => [];
}

class CaptainProfileLoading extends CaptainProfileState {
  const CaptainProfileLoading();
}

class CaptainProfileLoaded extends CaptainProfileState {
  final CaptainProfileEntity profile;
  final String? toastMessage;

  const CaptainProfileLoaded({
    required this.profile,
    this.toastMessage,
  });

  CaptainProfileLoaded copyWith({
    CaptainProfileEntity? profile,
    String? toastMessage,
  }) {
    return CaptainProfileLoaded(
      profile: profile ?? this.profile,
      toastMessage: toastMessage,
    );
  }

  @override
  List<Object?> get props => [profile, toastMessage];
}

class CaptainProfileError extends CaptainProfileState {
  final String message;

  const CaptainProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
