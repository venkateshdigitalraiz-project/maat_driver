import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState(currentTabIndex: 0)) {
    on<ChangeTabEvent>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.tabIndex));
    });
  }
}
