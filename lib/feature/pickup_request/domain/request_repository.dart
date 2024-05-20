

abstract class RequestRepository {
  Future<String> createRequest(Map<String,String> request);
  Future<String> updateRequest(Map<String,String> request);
  Future<String> deleteRequest(String id);
  Future<List> getRequests();
  Future<String> getRequest(String id);
  Future<String> acceptRequest(String id);
  Future<String> rejectRequest(String id);
  Future<String> completeRequest(String id);
}