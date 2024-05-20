
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/feature/landing/domain/dashboard_repository.dart';
import 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardRepository dashboardRepository;
  DashboardCubit({required this.dashboardRepository})
      : super(DashboardInitial());

  void getDashboard() async {
    try {
      emit(DashboardLoading());
      final dashboardData = await dashboardRepository.getDashboardData();
      final recentActivityData = await dashboardRepository.recentActivity();
      List<Map<String, String>> recentActivities =
          recentActivityData['data'].toList();

      emit(DashboardLoaded(
          statistics: dashboardData, recentActivity: recentActivities));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
