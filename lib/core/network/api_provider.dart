import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/core/data/secure_storage.dart';

@lazySingleton
class ApiProivder {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 50),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  ApiProivder() {
    _interceptor();
  }

  Future<Response> post(String url, dynamic data) async {
    LocalStorage localStorage = LocalStorage();
    final accessToken = await localStorage.getData('accessToken');
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    return await dio.post(url, data: data);
  }

  Future<Response> get(String url) async {
    LocalStorage localStorage = LocalStorage();
    final accessToken = await localStorage.getData('accessToken');
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    final res = await dio.get(url);

    log(res.data.toString());

    return res;
  }

  // an interceptor to handle refersh token when the response is 401
  void _interceptor() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          final newToken = await _refreshToken();
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
  Future<String?> _refreshToken() async {
    try {
      final response = await dio.post('/refresh-token');
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
