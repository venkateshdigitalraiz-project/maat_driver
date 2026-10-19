import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/captain_profile_entity.dart';
import '../../domain/usecases/captain_profile_usecases.dart';
import 'captain_profile_event.dart';
import 'captain_profile_state.dart';

class CaptainProfileBloc extends Bloc<CaptainProfileEvent, CaptainProfileState> {
  final GetCaptainProfileUseCase getCaptainProfileUseCase;
  final ToggleCarpoolHostUseCase toggleCarpoolHostUseCase;

  CaptainProfileBloc({
    required this.getCaptainProfileUseCase,
    required this.toggleCarpoolHostUseCase,
  }) : super(const CaptainProfileLoading()) {
    on<LoadCaptainProfileEvent>(_onLoadProfile);
    on<ToggleCarpoolHostModeEvent>(_onToggleCarpoolHost);
  }

  Future<void> _onLoadProfile(
    LoadCaptainProfileEvent event,
    Emitter<CaptainProfileState> emit,
  ) async {
    emit(const CaptainProfileLoading());
    try {
      final profile = await getCaptainProfileUseCase();
      emit(CaptainProfileLoaded(profile: profile));
    } catch (e) {
      emit(CaptainProfileError(e.toString()));
    }
  }

  Future<void> _onToggleCarpoolHost(
    ToggleCarpoolHostModeEvent event,
    Emitter<CaptainProfileState> emit,
  ) async {
    if (state is CaptainProfileLoaded) {
      final current = state as CaptainProfileLoaded;
      try {
        await toggleCarpoolHostUseCase(event.isActive);
        final updatedProfile = CaptainProfileEntity(
          id: current.profile.id,
          name: current.profile.name,
          captainId: current.profile.captainId,
          phoneNumber: current.profile.phoneNumber,
          vehicleName: current.profile.vehicleName,
          vehicleNumber: current.profile.vehicleNumber,
          vehicleType: current.profile.vehicleType,
          rating: current.profile.rating,
          totalRatings: current.profile.totalRatings,
          totalTrips: current.profile.totalTrips,
          acceptanceRate: current.profile.acceptanceRate,
          completionRate: current.profile.completionRate,
          walletBalance: current.profile.walletBalance,
          documentsStatus: current.profile.documentsStatus,
          carpoolHostActive: event.isActive,
        );
        emit(CaptainProfileLoaded(
          profile: updatedProfile,
          toastMessage: event.isActive
              ? 'Intercity Carpool host mode ENABLED 🚗'
              : 'Carpool host mode disabled.',
        ));
      } catch (e) {
        emit(current.copyWith(toastMessage: 'Could not toggle carpool mode: $e'));
      }
    }
  }
}
