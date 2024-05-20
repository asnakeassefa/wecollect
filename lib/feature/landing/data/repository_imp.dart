
import 'package:injectable/injectable.dart';

import '../domain/dashboard_repository.dart';

@Injectable(as: DashboardRepository)
class DashboardRepositoryImp implements DashboardRepository {
  @override
  Future<Map<String, String>> getDashboardData() {
    return Future.value({
      'point': '1000',
      'carbon': '200',
      'weight': '800',
      'recycled': '1000',
    });
  }

  @override
  Future<Map<String, dynamic>> recentActivity() {
    final value = Future.value({
      'data': [
        {
          'title': 'Recycle',
          'date': '2022-01-01',
          'point': '100',
          'status': 'success'
        },
        {
          'title': 'cancled',
          'date': '2022-01-01',
          'point': '100',
          'status': 'failed'
        },
        {
          'title': 'Recycle',
          'date': '2022-01-01',
          'point': '100',
          'status': 'success'
        },
        {
          'title': 'Recycle',
          'date': '2022-01-01',
          'point': '100',
          'status': 'success'
        },
        {
          'title': 'canceld',
          'date': '2022-01-01',
          'point': '100',
          'status': 'failed'
        },
      ],
    });

    return value;
  }
}
