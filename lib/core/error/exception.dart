
// define exception class for network error

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});
}