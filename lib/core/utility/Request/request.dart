import "dart:convert";
import "package:http/http.dart" as http;

import "./local_datasource.dart";
import "./types.dart";
import "request_abstract.dart";

/*
required:
  body : string json
  url : string
response:
  response | Error | UnAuthorized
*/

class Request extends RequestAbstract {
  String baseUri = "https://eskalate.onrender.com/api";
  final http.Client httpClient;

  Request({required this.httpClient});

  @override
  Future<http.Response> associate(Uri uri,
      {Map<String, String>? body, required RequestTypes requestType}) async {
    try {
      String? accessToken =
          await LocalDataSource.readFromStorage("accessToken");
      // setting token
      final headers = {'Authorization': 'Bearer $accessToken'};
      // map request
      switch (requestType) {
        case RequestTypes.POST:
          {
            return await httpClient.post(uri, body: body, headers: headers);
          }
        case RequestTypes.PUT:
          {
            return await httpClient.put(uri, body: body, headers: headers);
          }
        case RequestTypes.PATCH:
          {
            return await httpClient.patch(uri, body: body, headers: headers);
          }
        default:
          {
            return await httpClient.get(uri, headers: headers);
          }
      }
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<http.Response> send(Uri uri,
      {Map<String, String>? body, required RequestTypes requestType}) async {
    try {
      // send request
      final result = await associate(uri, body: body, requestType: requestType);
      if (result.statusCode == 401) {
        // refresh access token
        final isUnauthorized = await refresh();
        if (isUnauthorized) {
          throw const UnAuthorized(message: "unauthorized token");
        }
        // try again
        final result2 =
            await associate(uri, body: body, requestType: requestType);
        if (result2.statusCode == 401) {
          // unauthorized
          throw const UnAuthorized(message: "unauthorized token");
        }
        return result2;
      }
      return result;
    } catch (error) {
      if (error is UnAuthorized) {
        await LocalDataSource.deleteFromStorage("accessToken");
        await LocalDataSource.deleteFromStorage("refreshToken");
      }
      rethrow;
    }
  }

  @override
  Future<http.Response> delete(Uri uri, {Map<String, String>? body}) async {
    return await send(uri, body: body, requestType: RequestTypes.DELETE);
  }

  @override
  Future<http.Response> get(Uri uri, {Map<String, String>? body}) async {
    return await send(uri, body: body, requestType: RequestTypes.GET);
  }

  @override
  Future<http.Response> patch(Uri uri, {Map<String, String>? body}) async {
    return await send(uri, body: body, requestType: RequestTypes.PATCH);
  }

  @override
  Future<http.Response> put(Uri uri, {Map<String, String>? body}) async {
    return await send(uri, body: body, requestType: RequestTypes.PUT);
  }

  @override
  Future<bool> refresh() async {
    try {
      final refreshToken =
          await LocalDataSource.readFromStorage("refreshToken");
      // setting refreshToken
      final result = await http.post(
        Uri.parse("$baseUri/Auth/refresh"),
        headers: {'Cookie': 'refreshToken=$refreshToken'},
      );

      if (result.statusCode == 401) {
        return false;
      }

      if (result.statusCode != 200) {
        throw Exception(result.body);
      }

      final accessToken = jsonDecode(result.body)["accessToken"];
      await LocalDataSource.writeToStorage("accessToken", accessToken);
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<http.Response> post(Uri uri, {Map<String, String>? body}) async {
    return await send(uri, body: body, requestType: RequestTypes.POST);
  }
}
