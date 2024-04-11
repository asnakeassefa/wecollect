import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:wecollect/core/network/endpoints.dart';
import 'package:wecollect/feature/auth/domain/auth_repostiory.dart';
import 'package:http/http.dart' as http;

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImp implements AuthenticationRepository {
  @override
  Future<String> login(String username, String password) async {
    try {
      final url = Uri.parse(Endpoints.login);
      Map<String, String> payload = {
        "username": username,
        "password": password
      };
      final response = await http.post(url, body: jsonEncode(payload));

      if (response == 200) {
        return jsonDecode(response.body)['msg'];
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
      final url = Uri.parse(Endpoints.login);
      final response = await http.post(url, body: jsonEncode(userData));

      if (response == 201) {
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
