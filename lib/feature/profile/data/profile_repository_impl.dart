

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/core/network/endpoints.dart';
import 'package:wecollect/feature/profile/data/user_model.dart';
import 'package:http_parser/http_parser.dart';

import '../../../core/network/api_provider.dart';
import '../domain/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements  ProfileRepository{
  Api api = Api();

  @override
  Future<UserModel> getProfile() async{
    try {
      final _storage = FlutterSecureStorage();
      final userId = await _storage.read(key: 'userId');
      int id = int.parse(userId!);
      final response = await api.get("https://wasteplasticcollector.onrender.com/user/${id}/");
      if (response.statusCode == 200) {
        final _storage = FlutterSecureStorage();
        await _storage.write(key: 'profile_photo', value: response.data['data']['profile_photo']);
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateProfile(Map<String, dynamic> profile) async{

    final userId = await FlutterSecureStorage().read(key: 'userId');
   String url = "https://wasteplasticcollector.onrender.com/user/update/${userId}/";

   log(profile.toString());
   log('in ffff');
    try {

      final formData = FormData.fromMap(
        {
          "email": profile['email'],
          "name": profile['name'],
          "phone_number":profile['phone_number'],
          "role":profile['role'],
        },
      );

      List<String> types = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
      if (profile['profile_photo'] != null) {
        final extension = profile['profile_photo'].split('.').last.toLowerCase();
        if (!types.contains(extension)) {
          throw Exception('Invalid image type');
        }
        formData.files.add(MapEntry(
          'profile_photo',
          await MultipartFile.fromFile(
            profile['profile_photo'],
            filename: 'project_Image.$extension',
            contentType: MediaType('image', extension),
          ),
        ));
      }

      final response = await api.edit(url, formData);
      if (response.statusCode == 200) {
        log('her in success');
        return 'success';
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      rethrow;
    }
  }
  
}
