import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/core/network/endpoints.dart';
import 'package:wecollect/feature/auth/domain/auth_repostiory.dart';
import 'package:http/http.dart' as http;

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImp implements AuthenticationRepository {
  FlutterSecureStorage _storage = FlutterSecureStorage();
  @override
  Future<String> login(Map<String, String> loginInfo) async {
    try {
      final url = Uri.parse(Endpoints.login);

      final response = await http.post(url, body: loginInfo);
      log(response.body.toString());
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await _storage.write(key: 'accessToken', value: res['access_token']);
        await _storage.write(key: 'refreshToken', value: res['refresh_token']);
        await _storage.write(key: 'role', value: res['role']);
        return res['message'];
      } else {
        throw Exception("Couldn't login to the sytem: please try again!");
      }
    } catch (e) {
      throw Exception("Login Faild");
    }
  }

  @override
  Future<String> signup(Map<String, String> userData) async {
    try {
      final url = Uri.parse(Endpoints.signup);
      final response = await http.post(url, body: userData);

      if (response.statusCode == 201) {
        return "user registerd successfully";
      } else {
        throw Exception("Couldn't login to the sytem: please try again!");
      }
    } catch (e) {
      throw Exception("Login Faild");
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
