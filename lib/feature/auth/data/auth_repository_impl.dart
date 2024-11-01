import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/core/network/endpoints.dart';
import 'package:wecollect/feature/auth/domain/auth_repostiory.dart';
import 'package:http/http.dart' as http;

import '../../../core/network/api_provider.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImp implements AuthenticationRepository {
  Api api = Api();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  @override
  Future<String> login(Map<String, String> loginInfo) async {
    try {
      final url = Uri.parse(Endpoints.login);

      final response = await http.post(url, body: loginInfo);
      var res = jsonDecode(response.body);
      log(res.toString());
      if (response.statusCode == 200) {
        await _storage.write(key: 'accessToken', value: res['access_token']);
        await _storage.write(key: 'refreshToken', value: res['refresh_token']);
        await _storage.write(key: 'name', value: res['name']);
        await _storage.write(key: 'role', value: res['role']);
        await _storage.write(key: 'userId', value: res['id'].toString());


        final userId = await _storage.read(key: 'userId');
      int id = int.parse(userId!);
      final profileDetail = await api.get("${Endpoints.user}/$id/");
      log(profileDetail.toString());
      await _storage.write(key: 'profile_photo', value:profileDetail.data['data']['profile_photo']);
      log(Endpoints.baseUrl + profileDetail.data['data']['profile_photo'].toString());
        return res['message'];
      } else {
        throw Exception(res['msg']);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signup(Map<String, dynamic> userData) async {
    try {
      final url = Endpoints.signup;
      log(url.toString());
      log(userData.toString());
      final response = await api.post(url , userData);
      if (response.statusCode == 201) {
        return "user registerd successfully";
      } else {
        throw Exception("Couldn't login to the sytem: please try again!");
      }
    } catch (e) {
      throw Exception("Registration failed: please try again!");
    }
  }

  @override
  Future<String> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<String> resetPassword(String email, String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
