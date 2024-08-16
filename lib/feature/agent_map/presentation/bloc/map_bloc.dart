import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/map_repo.dart';
import 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  MapCubit(this.repository) : super(MapInitial());
  final MapRepository repository;

  void fetchRequests(String userId) async {
    emit(MapLoading());
    try {
      final response = await repository.getUserData(userId);
      emit(MapLoaded(userData: response));
    } catch (e) {
      log(e.toString());
      emit(MapError(message: e.toString()));
    }
  }

  void createRequest(Map<String, dynamic> request) async {
    if (request['agent_status'] == 'reject' ||
        request['task_status'] == 'reject') {
      emit(MapRejectLoading());
    } else {
      emit(MapLoading());
    }
    try {
      final response = await repository.acceptRequest(request);
      log(response.toString());
      emit(MapSuccess(message: response));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  void updateRequest(Map<String, dynamic> request) async {
    if (request['agent_status'] == 'reject' ||
        request['task_status'] == 'reject') {
      emit(MapRejectLoading());
    } else {
      emit(MapLoading());
    }
    try {
      final response = await repository.completeRequest(request);
      emit(MapSuccess(message: response));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }
}
