import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/core/network/endpoints.dart';
import '../../../core/network/api_provider.dart';
import '../domain/map_repo.dart';
import 'userModel.dart';

@Injectable(as: MapRepository)
class MapRepositoryImpl implements MapRepository{
  Api api = Api();
  @override
  Future<String> acceptRequest(Map<String, dynamic> request) async{
    final userId =  await const FlutterSecureStorage().read(key: 'userId');
    final url = '${Endpoints.acceptRequest}/$userId/';
    
    try {
      log('before');
      log(request.toString());
      final response = await api.put(url, request);
      log(response.statusCode.toString());
      log(response.data.toString());

      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        log(response.toString());
        throw Exception('Failed to accept the request');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to accept the request');
    }
  }

  @override
  Future<String> completeRequest(Map<String, dynamic> request) async{
    final userId = const FlutterSecureStorage().read(key: 'userId');
    final url = '${Endpoints.completeRequest}/$userId/';

    try {
      final response = await api.put(url, request);
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw Exception('Failed to complete the request');
      }
    } catch (e) {
     throw Exception('Failed to complete the request');
    }
  }

  @override
  Future<UserModel> getUserData(String userId) async{
    final url = "${Endpoints.user}/$userId/";
    
    try {
      final response = await api.get(url);
      
      if (response.statusCode == 200) {
        final res = UserModel.fromJson(response.data);
        return res;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }

  }
  
}