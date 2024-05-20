

sealed class RequestState{}

class RequestInitial extends RequestState{}

class RequestLoading extends RequestState{}

class RequestSuccess extends RequestState{
  final String message;
  RequestSuccess({required this.message});
}

class RequestError extends RequestState{
  final String message;
  RequestError({required this.message});
}

class RequestLoaded extends RequestState{
  final List requests;
  RequestLoaded({required this.requests});
}