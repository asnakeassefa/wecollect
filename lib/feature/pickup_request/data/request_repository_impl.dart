import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/feature/pickup_request/data/assigned_activity_model.dart';
import '../../../core/network/api_provider.dart';
import '../../../core/network/endpoints.dart';
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
      log('here in request');
      log(request.toString());
      final response = await api.post(url, request);
      log(response.data.toString());
      if (response.statusCode == 201) {
        
        return response.data['message'];
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      log(e.toString());
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
      final role = await const FlutterSecureStorage().read(key: 'role');
      final userId = await const FlutterSecureStorage().read(key: 'userId');
      final url = "${Endpoints.recentActivity}/$userId/$role";
      log(url);
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
  Future<String> updateRequest(Map<String, String> request) {
    // TODO: implement updateRequest
    throw UnimplementedError();
  }
  
  @override
  Future<List<AssignedData>> getAgentRequests() async{
    try {
      const storage = FlutterSecureStorage();
      final userId = await storage.read(key: 'userId');
      final url = "${Endpoints.agentRequest}/$userId";

      final response = await api.get(url);
      
      log(response.data.toString());

      if (response.statusCode == 200) {
        AssignedModel res = AssignedModel.fromJson(response.data);
        return res.data ?? [];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('before exception');
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<String> updateStatus(Map<String, dynamic> payload) async{
    try {
      String url = Endpoints.request;
      final response = await api.post(url, payload);
      if (response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
