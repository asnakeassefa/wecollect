import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wecollect/core/error/exception.dart';
import 'package:wecollect/core/network/endpoints.dart';

class Api {
  Dio dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Api() {
    dio.options.connectTimeout = const Duration(milliseconds: 30000); // 30s
    dio.options.receiveTimeout = const Duration(milliseconds: 20000); // 20s

    // add interceptor to handle refresh token
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // add token to header
        options.headers["Authorization"] =
            "Bearer ${await _storage.read(key: 'accessToken')}";
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) async {
        // handle refresh token if response returns 401
        // log('api provider error');
        // log("here in one ${e.response.toString().toLowerCase()}");
        
        // log(resData.toString());
        // log(resData['detail'].toString());

        if (e.response?.statusCode == 401 && e.response.toString().toLowerCase().contains('accesstoken')) {
          try {
            // log('before refresh');
            await refreshToken();
            log('after refresh');
            final options = e.requestOptions;
            options.headers["Authorization"] =
                "Bearer ${await _storage.read(key: 'accessToken')}";
            final cloneReq = await retryRequest(options);
            return handler.resolve(cloneReq);
          } catch (error) {

            log('here in error after refresh');
            log(error.toString());
            if (error.toString().toLowerCase().contains('expired')) {
              
              return handler.next(DioException(
                message: 'tokenexpired',
                requestOptions: e.requestOptions,
                response: Response(
                  requestOptions: e.requestOptions,
                  statusCode: 401,
                  data: 'tokenexpired',
                ),
              ));
            } else if (error is DioException) {
              return handler.next(error);
            } else {
              return handler.next(DioException(
                requestOptions: e.requestOptions,
                error: error,
              ));
            }
          }
        } else if(e.response?.statusCode == 401){
          // log('here in exception');
          return handler.next(DioException(
            message: 'expired',
            requestOptions: e.requestOptions,
            response: Response(
              requestOptions: e.requestOptions,
              statusCode: 401,
              data: 'expired',
            ),
          ));
        }
        
        return handler.next(e); //continue
      },
    ));
  }

  // retry request function
  Future<Response> retryRequest(RequestOptions requestOptions) async {
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
  }

  // refresh token function
  Future<void> refreshToken() async {
    try {
      final token = await _storage.read(key: 'refreshToken');
      final refreshTokenResponse = await dio.post(Endpoints.refresh, data: {
        "refresh": token,
      });
      if (refreshTokenResponse.statusCode == 200) {
        // save new token
        final accessToken = refreshTokenResponse.data["access"];
        // save new token
        await _storage.write(key: 'accessToken', value: accessToken);
      } else {
        throw NetworkException(message: 'token expired');
      }
    } catch (e) {
      rethrow;
    }
  }

  // post method with data
  Future<Response> post(String url, Map data) async {
    try {
      log(data.toString());
      log(url);
      var res = await dio.post(url, data: data);
      log(res.toString());
      return res;
    } on DioException {
      rethrow;
    }
  }

  // get method
  Future<Response> get(String url) async {
    try {
      return await dio.get(url);
    } on DioException {
      rethrow;
    }
  }

  // put method
  Future<Response> put(String url, Map data) async {
    try {
      return await dio.put(url, data: data);
    } on DioException {
      rethrow;
    }
  }

  // delete method
  Future<Response> delete(String url) async {
    try {
      return await dio.delete(url);
    } on DioException {
      rethrow;
    }
  }

  // post multipartData
  Future<Response> upload(String url, FormData data) async {
    try {
      return await dio.post(url, data: data);
    } on DioException {
      rethrow;
    }
  }

  // put multipartData
  Future<Response> edit(String url, FormData data) async {
    try {
      return await dio.put(url, data: data);
    } on DioException {
      rethrow;
    }
  }
}
