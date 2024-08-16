class AssignedModel {
  bool? success;
  List<AssignedData>? data;

  AssignedModel({this.success, this.data});

  AssignedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AssignedData>[];
      json['data'].forEach((v) {
        data!.add(AssignedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignedData {
  int? id;
  RequestId? requestId;
  String? assignedDate;
  String? assignedTime;
  String? asignStatus;
  String? taskStatus;
  int? userId;

  AssignedData(
      {this.id,
      this.requestId,
      this.assignedDate,
      this.assignedTime,
      this.asignStatus,
      this.taskStatus,
      this.userId});

  AssignedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'] != null
        ? RequestId.fromJson(json['requestId'])
        : null;
    assignedDate = json['assigned_date'];
    assignedTime = json['assigned_time'];
    asignStatus = json['asign_status'];
    taskStatus = json['task_status'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (requestId != null) {
      data['requestId'] = requestId!.toJson();
    }
    data['assigned_date'] = assignedDate;
    data['assigned_time'] = assignedTime;
    data['asign_status'] = asignStatus;
    data['task_status'] = taskStatus;
    data['userId'] = userId;
    return data;
  }
}

class RequestId {
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

  RequestId(
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

  RequestId.fromJson(Map<String, dynamic> json) {
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
