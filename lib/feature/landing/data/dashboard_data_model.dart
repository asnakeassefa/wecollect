class DashboardModel {
  bool? success;
  List<Data>? data;
  num? totalCollection;
  double? carbonEmission;
  num? reward;

  DashboardModel(
      {this.success,
      this.data,
      this.totalCollection,
      this.carbonEmission,
      this.reward});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    totalCollection = json['total_collection'];
    carbonEmission = json['carbon_emission'];
    reward = json['reward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_collection'] = totalCollection;
    data['carbon_emission'] = carbonEmission;
    data['reward'] = reward;
    return data;
  }
}

class Data {
  int? id;
  Requestor? requestor;
  WastePlasticType? wastePlasticType;
  String? requestDate;
  String? requestTime;
  int? wastePlasticSize;
  String? wastePlasticAddress;
  String? uniqueLocation;
  double? latitude;
  double? longitude;
  String? wastePlasticPhoto;
  String? message;
  String? pickUpStatus;

  Data(
      {this.id,
      this.requestor,
      this.wastePlasticType,
      this.requestDate,
      this.requestTime,
      this.wastePlasticSize,
      this.wastePlasticAddress,
      this.uniqueLocation,
      this.latitude,
      this.longitude,
      this.wastePlasticPhoto,
      this.message,
      this.pickUpStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestor = json['requestor'] != null
        ? Requestor.fromJson(json['requestor'])
        : null;
    wastePlasticType = json['wastePlastic_type'] != null
        ? WastePlasticType.fromJson(json['wastePlastic_type'])
        : null;
    requestDate = json['request_date'];
    requestTime = json['request_time'];
    wastePlasticSize = json['wastePlastic_size'];
    wastePlasticAddress = json['wastePlastic_address'];
    uniqueLocation = json['unique_location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    wastePlasticPhoto = json['waste_plastic_photo'];
    message = json['message'];
    pickUpStatus = json['pickUp_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (requestor != null) {
      data['requestor'] = requestor!.toJson();
    }
    if (wastePlasticType != null) {
      data['wastePlastic_type'] = wastePlasticType!.toJson();
    }
    data['request_date'] = requestDate;
    data['request_time'] = requestTime;
    data['wastePlastic_size'] = wastePlasticSize;
    data['wastePlastic_address'] = wastePlasticAddress;
    data['unique_location'] = uniqueLocation;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['waste_plastic_photo'] = wastePlasticPhoto;
    data['message'] = message;
    data['pickUp_status'] = pickUpStatus;
    return data;
  }
}

class Requestor {
  int? id;
  String? email;
  String? name;
  String? phoneNumber;
  String? role;
  String? userStatus;

  Requestor(
      {this.id,
      this.email,
      this.name,
      this.phoneNumber,
      this.role,
      this.userStatus});

  Requestor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    role = json['role'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['role'] = role;
    data['user_status'] = userStatus;
    return data;
  }
}

class WastePlasticType {
  int? id;
  String? type;

  WastePlasticType({this.id, this.type});

  WastePlasticType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}
