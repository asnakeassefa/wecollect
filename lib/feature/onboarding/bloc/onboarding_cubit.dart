import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super((OnboardingInit()));
  FlutterSecureStorage _storage = FlutterSecureStorage();
  void isLoaded() async {
    emit(OnboardingLoading());
    try {
      final authenticated = await _storage.containsKey(key: 'accessToken');
      if (authenticated) {
        emit((UserAuthenticated()));
        return;
      }
      final onboarding = await _storage.containsKey(key: 'onboarding');
      if (onboarding) {
        emit(OnboardingLoaded());
        return;
      }
      await _storage.write(key: 'onboarding', value: 'true');
      emit(OnboardingStarted());
    } catch (e) {
      emit(OnboardingError(error: e.toString()));
    }
  }
}
