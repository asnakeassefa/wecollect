

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wecollect/core/network/api_provider.dart';
import 'package:wecollect/core/network/endpoints.dart';
import 'package:wecollect/feature/profile/data/user_model.dart';
import 'package:http_parser/http_parser.dart';

import '../domain/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements  ProfileRepository{
  Api api = Api();

  @override
  Future<UserModel> getProfile() async{
    try {
      const storage = FlutterSecureStorage();
      final userId = await storage.read(key: 'userId');

      int id = int.parse(userId!);
      final response = await api.get("${Endpoints.user}/$id/");
      if (response.statusCode == 200) {
        const storage = FlutterSecureStorage();
        await storage.write(key: 'profile_photo', value: response.data['data']['profile_photo']);
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

    final userId = await const FlutterSecureStorage().read(key: 'userId');
   String url = "${Endpoints.user}/update/$userId/";
   log(url);
   log(profile.toString());
   
    try {

      final formData = FormData.fromMap(
        {
          "email": profile['email'],
          if(profile['name'].toString().isNotEmpty) "name": profile['name'],
          if(profile['latitued'].toString().isNotEmpty) "latitude": profile['latitude'],
          if(profile['longitude']!=null) "longitude": profile['longitude'],
          if(profile['phone_number']!=null) "phone_number":profile['phone_number'],
        },
      );

      // List<String> types = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
      
      if (profile['profile_photo'] != null && profile['profile_photo'] != '') {
        final extension = profile['profile_photo'].split('.').last.toLowerCase();
        // if (!types.contains(extension)) {
        //   throw Exception('Invalid image type');
        // }
        formData.files.add(MapEntry(
          'profile_photo',
          await MultipartFile.fromFile(
            profile['profile_photo'],
            filename: 'project_Image.$extension',
            contentType: MediaType('image', extension),
          ),
        ));
      }
      log('before log');
      final response = await api.edit(url, formData);
      log(response.toString());
      log(response.statusCode.toString());
      if (response.statusCode.toString()[0] == '2') {
        return 'success';
      } else {
        log(response.statusCode.toString());
        log(response.data.toString());
        log(response.statusMessage.toString());
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      rethrow;
    }
  }
  
}
