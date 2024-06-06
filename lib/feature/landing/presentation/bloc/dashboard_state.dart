import '../../data/recent_activity_model.dart';

sealed class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Map<String, String> statistics;
  final List<ActivityData> recentActivity;
  DashboardLoaded({required this.recentActivity, required this.statistics});
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
