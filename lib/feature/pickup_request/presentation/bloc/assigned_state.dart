
sealed class AgentTasksState{}

class AgentTasksInitial extends AgentTasksState{}

class AgentTasksLoading extends AgentTasksState{}

class AgentTasksSuccess extends AgentTasksState{
  final String message;
  AgentTasksSuccess({required this.message});
}

class AgentTasksError extends AgentTasksState{
  final String message;
  AgentTasksError({required this.message});
}

class AgentTasksLoaded extends AgentTasksState{
  final List agentTaskss;
  AgentTasksLoaded({required this.agentTaskss});
}