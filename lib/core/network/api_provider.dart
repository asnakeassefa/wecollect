import 'package:dio/dio.dart';
import 'package:wecollect/core/data/secure_storage.dart';

class ApiProivder {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  final String accessToken;

  LocalStorage localStorage = LocalStorage();
  ApiProivder({required this.accessToken}) {
    _interceptor();
  }

  Future<Response> post(String url, dynamic data) async {
    return await dio.post(url, data: data);
  }

  Future<Response> get(String url) async {
    final res = await dio.get(url);
    return res;
  }

  Future<Response> put(String url, dynamic data) async {
    return await dio.put(url, data: data);
  }

  Future<Response> delete(String url, String id) async {
    return await dio.delete(url);
  }

  // an interceptor to handle refersh token when the response is 401
  void _interceptor() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authoriztion'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          final newToken = await _refreshToken("");
          if (newToken != null) {
            LocalStorage localStorage = LocalStorage();
            await localStorage.saveData('accessToken', newToken);
            dio.options.headers['Authorization '] = 'Bearer $newToken';
          }
        }
        return handler.next(e);
      },
    ));
  }

  // a method to refresh token with try catch
  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final response = await dio.post('/refresh-token',data: refreshToken);
      return response.data['accessToken'];
    } catch (e) {
      return null;
    }
  }

  // a mehtod to retry
  Future<Response> _retry(RequestOptions requestOptions) async {
    final response = await dio.request(
      requestOptions.path,
      data: requestOptions.data,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
    return response;
  }
}
