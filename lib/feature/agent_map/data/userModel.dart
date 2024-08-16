class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? name;
  String? phoneNumber;
  String? profilePhoto;
  String? country;
  String? region;
  String? zone;
  String? woreda;
  String? kebele;
  double? latitude;
  double? longitude;
  String? role;
  String? userStatus;

  Data(
      {this.id,
      this.email,
      this.name,
      this.phoneNumber,
      this.profilePhoto,
      this.country,
      this.region,
      this.zone,
      this.woreda,
      this.kebele,
      this.latitude,
      this.longitude,
      this.role,
      this.userStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    profilePhoto = json['profile_photo'];
    country = json['country'];
    region = json['region'];
    zone = json['zone'];
    woreda = json['woreda'];
    kebele = json['kebele'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    role = json['role'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['profile_photo'] = profilePhoto;
    data['country'] = country;
    data['region'] = region;
    data['zone'] = zone;
    data['woreda'] = woreda;
    data['kebele'] = kebele;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['role'] = role;
    data['user_status'] = userStatus;
    return data;
  }
}
