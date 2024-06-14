import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/request_repository.dart';
import 'request_state.dart';

@injectable
class RequestCubit extends Cubit<RequestState> {
  RequestCubit(this.repository) : super(RequestInitial());
  final RequestRepository repository;

  void fetchRequests() async {
    emit(RequestLoading());
    try {
      final response = await repository.getRequests();
      emit(RequestLoaded(requests: response));
    } catch (e) {
      emit(RequestError(message: e.toString()));
    }
  }

  void fetchAgentRequests() async {
    emit(RequestLoading());
    try {
      final response = await repository.getAgentRequests();
      emit(RequestLoaded(requests: response));
    } catch (e) {
      emit(RequestError(message: e.toString()));
    }
  }

  void createRequest(Map<String, dynamic> request) async {
    emit(RequestLoading());
    try {
      final response = await repository.createRequest(request);
      emit(RequestSuccess(message: response));
    } catch (e) {
      emit(RequestError(message: e.toString()));
    }
  }

  void updateRequest(Map<String, String> request) async {
    emit(RequestLoading());
    try {
      final response = await repository.updateRequest(request);
      emit(RequestSuccess(message: response));
    } catch (e) {
      emit(RequestError(message: e.toString()));
    }
  }

  void deleteRequest(String id) async {
    emit(RequestLoading());
    try {
      final response = await repository.deleteRequest(id);
      emit(RequestSuccess(message: response));
    } catch (e) {
      emit(RequestError(message: e.toString()));
    }
  }
}
