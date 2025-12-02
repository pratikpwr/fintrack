part of 'dashboard_bloc.dart';

/// Base event class for dashboard
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Load dashboard data
class LoadDashboard extends DashboardEvent {
  const LoadDashboard();
}

/// Refresh dashboard data
class RefreshDashboard extends DashboardEvent {
  const RefreshDashboard();
}

