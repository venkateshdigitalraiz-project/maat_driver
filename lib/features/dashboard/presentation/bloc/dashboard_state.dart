import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int currentTabIndex;

  const DashboardState({this.currentTabIndex = 0});

  DashboardState copyWith({int? currentTabIndex}) {
    return DashboardState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  List<Object?> get props => [currentTabIndex];
}
