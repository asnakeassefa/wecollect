/*
  request type
  unauthorized access type
*/

enum RequestTypes { POST, PUT, GET, PATCH, DELETE, HEAD, OPTIONS }

class UnAuthorized {
  final String message;
  const UnAuthorized({required this.message});
}
