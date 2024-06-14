import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../../core/network/api_provider.dart';
import '../../../core/network/endpoints.dart';
import '../../landing/data/recent_activity_model.dart';
import '../domain/request_repository.dart';
import 'request_data_model.dart';

@Injectable(as: RequestRepository)
class RequestRepositoryImp implements RequestRepository {
  Api api = Api();

  @override
  Future<String> acceptRequest(String id) {
    // TODO: implement acceptRequest
    throw UnimplementedError();
  }

  @override
  Future<String> completeRequest(String id) {
    // TODO: implement completeRequest
    throw UnimplementedError();
  }

  @override
  Future<String> createRequest(Map<String, dynamic> request) async {
    try {
      String url = Endpoints.request;
      final response = await api.post(url, request);
      if (response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteRequest(String id) {
    // TODO: implement deleteRequest
    throw UnimplementedError();
  }

  @override
  Future<String> getRequest(String id) {
    // TODO: implement getRequest
    throw UnimplementedError();
  }

  @override
  Future<List<Data>> getRequests() async{
    try {
      final url = Endpoints.recentActivity;

      final response = await api.get(url);
      log(response.data.toString());
      if (response.statusCode == 200) {
        ActivityModel res = ActivityModel.fromJson(response.data);
        return res.data ?? [];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> rejectRequest(String id) {
    // TODO: implement rejectRequest
    throw UnimplementedError();
  }

  @override
  Future<String> updateRequest(Map<String, String> request) {
    // TODO: implement updateRequest
    throw UnimplementedError();
  }
  
  @override
  Future<List<Data>> getAgentRequests() async{
    try {
      final _storage = FlutterSecureStorage();
      final userId = await _storage.read(key: 'userId');
      final url = "${Endpoints.agentRequest}/$userId";

      final response = await api.get(url);
      log(response.data.toString());
      if (response.statusCode == 200) {
        ActivityModel res = ActivityModel.fromJson(response.data);
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
