abstract class AuthenticationRepository {
  Future<String> login(String email, String password);
  Future<String> signup(Map<String,String> userData);
  Future<String> forgotPassword(String email);
  Future<String> resetPassword(String email, String newPassword);
}
