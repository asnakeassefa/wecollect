

import '../data/userModel.dart';

abstract class MapRepository{
  Future<UserModel> getUserData(String userId);
  Future<String> acceptRequest(Map<String,dynamic> request);
  Future<String> completeRequest(Map<String,dynamic> request);
}