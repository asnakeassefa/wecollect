

import '../data/assigned_activity_model.dart';
import '../data/request_data_model.dart';

abstract class RequestRepository {
  Future<String> createRequest(Map<String,dynamic> request);
  Future<String> updateRequest(Map<String,String> request);
  Future<String> deleteRequest(String id);
  Future<List<Data>> getRequests();
  Future<String> getRequest(String id);
  Future<List<AssignedData>> getAgentRequests();
  Future<String> updateStatus(Map<String,dynamic> payload);
  Future<String> completeRequest(String id);
}