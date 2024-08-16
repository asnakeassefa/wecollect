import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/core/network/endpoints.dart';
import 'package:wecollect/feature/landing/data/dashboard_data_model.dart';

import '../../../core/network/api_provider.dart';
import '../domain/dashboard_repository.dart';
import 'recent_activity_model.dart';

@Injectable(as: DashboardRepository)
class DashboardRepositoryImp implements DashboardRepository {
  Api api = Api();
  @override
  Future<Map<String, String>> getDashboardData() async {
    try {
      const storage = FlutterSecureStorage();
      log('landing0');
      final userId = await storage.read(key: 'userId');
      final role = await storage.read(key: 'role');
      final url = "${Endpoints.dashboard}/$userId/$role";
      // final userinfo = await api.get("${Endpoints.user}/$userId");
      log('url');
      log(url);
      final response = await api.get(url);
      log('if there is exception');
      
      if (response.statusCode == 200) {
        
        DashboardModel res = DashboardModel.fromJson(response.data);
        return {
          'point': res.reward.toString(),
          'carbon': res.carbonEmission.toString(),
          'weight': res.totalCollection.toString(),
          'recycled': res.totalCollection.toString(),
        };
      } else {
        log('inside an error1');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
      log('here in dashboard ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<ActivityData>> recentActivity() async{
    try {
      const storage = FlutterSecureStorage();
      final userId = await storage.read(key: 'userId');
      final role = await storage.read(key: 'role');
      final url = "${Endpoints.recentActivity}/$userId/$role";
      final response = await api.get(url);
      if (response.statusCode == 200) {
        
        LatestActivityModel res = LatestActivityModel.fromJson(response.data);
        return res.data ?? [];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
