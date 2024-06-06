import '../data/user_model.dart';

abstract class ProfileRepository{
  Future<String> updateProfile(Map<String,dynamic> profile);
  Future<UserModel> getProfile();
}