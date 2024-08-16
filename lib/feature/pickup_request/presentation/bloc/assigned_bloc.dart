import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/request_repository.dart';
import 'assigned_state.dart';

@injectable
class AgentTaskCubit extends Cubit<AgentTasksState> {
  AgentTaskCubit(this.repository) : super(AgentTasksInitial());
  final RequestRepository repository;

  void fetchAgentRequests() async {
    emit(AgentTasksLoading());
    try {
      final response = await repository.getAgentRequests();
      emit(AgentTasksLoaded(agentTaskss: response));
    } catch (e) {
      emit(AgentTasksError(message: e.toString()));
    }
  }


  void changeStatus(Map<String,dynamic> request)  async {
    emit(AgentTasksLoading());
    try{
      final response = await repository.updateStatus(request);
    } catch(e){
      emit(AgentTasksError(message: "Couldn't get a response"));
    }
  }
}
