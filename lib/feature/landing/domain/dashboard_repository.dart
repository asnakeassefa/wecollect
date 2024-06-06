
import 'package:wecollect/feature/landing/data/recent_activity_model.dart';

abstract class DashboardRepository {
  Future<Map<String,String>> getDashboardData();
  Future<List<ActivityData>> recentActivity();
}