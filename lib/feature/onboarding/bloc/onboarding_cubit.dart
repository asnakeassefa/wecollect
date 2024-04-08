import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utility/Request/local_datasource.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super((OnboardingInit()));

  void isLoaded() async {
    emit(OnboardingLoading());
    try {
      final authenticated =
          await LocalDataSource.readFromStorage('accessToken');
      if (authenticated != null) {
        emit((UserAuthenticated()));
        return;
      }
      final onboarding = await LocalDataSource.readFromStorage('onboarding');
      if (onboarding != null) {
        emit(OnboardingLoaded());
        return;
      }
      await LocalDataSource.writeToStorage('onboarding', 'true');
      emit(OnboardingStarted());
    } catch (e) {
      emit(OnboardingError(error: e.toString()));
    }
  }
}
