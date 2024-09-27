abstract class AuthenticationRepository {
  Future<String> login(Map<String, String> loginInfo);
  Future<String> signup(Map<String, dynamic> userData);
  Future<String> forgotPassword(String email);
  Future<String> resetPassword(String email, String newPassword);
}
