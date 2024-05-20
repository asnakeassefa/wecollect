

sealed class NotificationState{}

class NotificationInitial extends NotificationState{}

class NotificationLoading extends NotificationState{}

class NotificationSuccess extends NotificationState{
  final String message;
  NotificationSuccess({required this.message});
}

class NotificationError extends NotificationState{
  final String message;
  NotificationError({required this.message});
}