import 'dart:convert';
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
      final _storage = FlutterSecureStorage();
      final url = Endpoints.dashboard;
      final userId = await _storage.read(key: 'userId');
      int id = int.parse(userId!);
      final userinfo = await api.get("https://wasteplasticcollector.onrender.com/user/${id}/");
      final response = await api.get(url);
      if (response.statusCode == 200) {
        DashboardModel res = DashboardModel.fromJson(response.data);
        return {
          'point': res.reward.toString(),
          'carbon': res.carbonEmission.toString(),
          'weight': res.totalCollection.toString(),
          'recycled': res.totalCollection.toString(),
        };
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ActivityData>> recentActivity() async{
    try {
      final url = Endpoints.recentActivity;

      final response = await api.get(url);
      if (response.statusCode == 200) {
        LatestActivityModel res = LatestActivityModel.fromJson(response.data);
        return res.data ?? [];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
