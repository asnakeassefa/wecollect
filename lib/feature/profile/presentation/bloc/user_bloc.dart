import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/profile_repository.dart';
import 'user_state.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  final ProfileRepository profileRepository;

  UserCubit(this.profileRepository) : super(UserInitial());

  void getUserProfile() async {
    try {
      emit(UserLoading());
      try {
        final result = await profileRepository.getProfile();
        emit(UserLoaded(user: result));
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    } catch (e) {
      emit(UserError(message: 'Failed to load profile data'));
    }
  }

  void updateUserProfile(Map<String, dynamic> user) async {
    emit(UserLoading());
    try {
      final result = await profileRepository.updateProfile(user);
      if (result == 'success') {
        emit(UserSuccess(message: 'Profile updated successfully'));
        getUserProfile();
      } else {
        emit(UserError(message: 'Failed to update profile'));
        getUserProfile();
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
      getUserProfile();
    }
  }
}
