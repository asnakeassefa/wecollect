import "dart:async";
import "types.dart";
import "package:http/http.dart" as http;

abstract class RequestAbstract {
  
  /* 
    Request type accepts POST, PATCH, PUT, DELETE, GET, HEAD AND OPTION requests
  */

  // Associates the request type, URI, and optional body to send a request
  Future<http.Response> associate(
      Uri uri,{ Map<String, String>? body,required RequestTypes requestType});

  // Sends a request with the specified URI, body, and request type
  Future<http.Response> send(Uri uri,
      {Map<String, String>? body, required RequestTypes requestType});

  // Refreshes the authentication token
  Future<bool> refresh();

  // post request
  Future<http.Response> post(Uri uri,
      {Map<String, String>? body});

  // get request
  Future<http.Response> get(Uri uri,
      {Map<String, String>? body});

  // put request
  Future<http.Response> put(Uri uri,
      {Map<String, String>? body});

  // delete request
  Future<http.Response> delete(Uri uri,
      {Map<String, String>? body});
  
  // patch request
  Future<http.Response> patch(Uri uri,
      {Map<String, String>? body});
      
}