import '../../data/user_model.dart';

sealed class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;
  UserLoaded({required this.user});
}

class UserSuccess extends UserState {
  final String message;
  UserSuccess({required this.message});
}

class UserError extends UserState {
  final String message;
  UserError({required this.message});
}