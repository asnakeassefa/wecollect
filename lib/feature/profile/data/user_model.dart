class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
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
    role = json['role'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['profile_photo'] = this.profilePhoto;
    data['country'] = this.country;
    data['region'] = this.region;
    data['zone'] = this.zone;
    data['woreda'] = this.woreda;
    data['kebele'] = this.kebele;
    data['role'] = this.role;
    data['user_status'] = this.userStatus;
    return data;
  }
}
