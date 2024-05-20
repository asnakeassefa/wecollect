
abstract class DashboardRepository {
  Future<Map<String,String>> getDashboardData();
  Future<Map<String,dynamic>> recentActivity();
}