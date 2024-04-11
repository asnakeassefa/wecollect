import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/auth_repostiory.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      // final user = await authRepository.login(email, password);

      emit(AuthSuccess("Login Successful"));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void register(String email, String password) async {
    emit(AuthLoading());
    try {
      Map<String, String> userInfo = {"email": email, "password": password};
      // final user = await authRepository.signup(userInfo);
      emit(AuthSuccess("Registration Successful"));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      // final user = await authRepository.forgotPassword(email);
      emit(AuthSuccess("Password reset link sent to your email"));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void resetPassword(String email, String newPassword) async {
    emit(AuthLoading());
    try {
      // final user = await authRepository.resetPassword(email, newPassword);
      emit(AuthSuccess("Password reset successful"));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
