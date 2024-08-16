import '../../data/assigned_activity_model.dart';
import '../../data/request_data_model.dart';

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
  final List<Data> requests;
  RequestLoaded({required this.requests});
}
class AgentRequestLoaded extends RequestState{
  final List<AssignedData> requests;
  AgentRequestLoaded({required this.requests});
}