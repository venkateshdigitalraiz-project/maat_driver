import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/driver_home_entities.dart';
import '../../domain/usecases/driver_home_usecases.dart';
import 'driver_home_event.dart';
import 'driver_home_state.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {
  final GetDriverHomeDataUseCase getDriverHomeDataUseCase;
  final ToggleOnlineStatusUseCase toggleOnlineStatusUseCase;
  final RespondToRideRequestUseCase respondToRideRequestUseCase;

  DriverHomeBloc({
    required this.getDriverHomeDataUseCase,
    required this.toggleOnlineStatusUseCase,
    required this.respondToRideRequestUseCase,
  }) : super(const DriverHomeLoading()) {
    on<LoadDriverHomeDataEvent>(_onLoadHomeData);
    on<ToggleOnlineEvent>(_onToggleOnline);
    on<AcceptRideEvent>(_onAcceptRide);
    on<DeclineRideEvent>(_onDeclineRide);
  }

  Future<void> _onLoadHomeData(
    LoadDriverHomeDataEvent event,
    Emitter<DriverHomeState> emit,
  ) async {
    emit(const DriverHomeLoading());
    try {
      final data = await getDriverHomeDataUseCase();
      emit(DriverHomeLoaded(data: data));
    } catch (e) {
      emit(DriverHomeError(e.toString()));
    }
  }

  Future<void> _onToggleOnline(
    ToggleOnlineEvent event,
    Emitter<DriverHomeState> emit,
  ) async {
    if (state is DriverHomeLoaded) {
      final current = state as DriverHomeLoaded;
      emit(current.copyWith(isTogglingOnline: true));

      try {
        await toggleOnlineStatusUseCase(event.isOnline);
        final updatedData = DriverHomeDataEntity(
          isOnline: event.isOnline,
          stats: current.data.stats,
          activeRequest: event.isOnline ? current.data.activeRequest : null,
          surgeAreas: current.data.surgeAreas,
        );
        emit(DriverHomeLoaded(
          data: updatedData,
          isTogglingOnline: false,
          toastMessage: event.isOnline
              ? 'You are now Online! Looking for nearby rides 🚀'
              : 'You are now Offline. Take a break! ☕',
        ));
      } catch (e) {
        emit(current.copyWith(isTogglingOnline: false));
      }
    }
  }

  Future<void> _onAcceptRide(
    AcceptRideEvent event,
    Emitter<DriverHomeState> emit,
  ) async {
    if (state is DriverHomeLoaded) {
      final current = state as DriverHomeLoaded;
      try {
        await respondToRideRequestUseCase.accept(event.requestId);
        final updatedData = DriverHomeDataEntity(
          isOnline: current.data.isOnline,
          stats: DriverEarningsStatsEntity(
            todayEarnings: current.data.stats.todayEarnings + 142.0,
            completedTrips: current.data.stats.completedTrips + 1,
            onlineHours: current.data.stats.onlineHours,
            dailyGoalCompleted: current.data.stats.dailyGoalCompleted + 1,
            dailyGoalTarget: current.data.stats.dailyGoalTarget,
            bonusReward: current.data.stats.bonusReward,
          ),
          activeRequest: null,
          surgeAreas: current.data.surgeAreas,
        );
        emit(DriverHomeLoaded(
          data: updatedData,
          toastMessage: 'Ride Accepted! Navigate to Pickup Location 🗺️',
        ));
      } catch (e) {
        emit(current.copyWith(toastMessage: 'Could not accept ride: $e'));
      }
    }
  }

  Future<void> _onDeclineRide(
    DeclineRideEvent event,
    Emitter<DriverHomeState> emit,
  ) async {
    if (state is DriverHomeLoaded) {
      final current = state as DriverHomeLoaded;
      try {
        await respondToRideRequestUseCase.decline(event.requestId);
        final updatedData = DriverHomeDataEntity(
          isOnline: current.data.isOnline,
          stats: current.data.stats,
          activeRequest: null,
          surgeAreas: current.data.surgeAreas,
        );
        emit(DriverHomeLoaded(
          data: updatedData,
          toastMessage: 'Ride Declined. Searching for next request...',
        ));
      } catch (e) {
        emit(current.copyWith(toastMessage: 'Failed to decline: $e'));
      }
    }
  }
}
