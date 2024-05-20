import 'package:injectable/injectable.dart';
import '../../../core/network/api_provider.dart';
import '../../../core/network/endpoints.dart';
import '../domain/request_repository.dart';

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
  Future<String> createRequest(Map<String, String> request) async {
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
  Future<List> getRequests() {
    // TODO: implement getRequests
    throw UnimplementedError();
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
}
