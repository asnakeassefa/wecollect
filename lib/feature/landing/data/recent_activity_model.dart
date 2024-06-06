class LatestActivityModel {
  bool? success;
  List<ActivityData>? data;

  LatestActivityModel({this.success, this.data});

  LatestActivityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ActivityData>[];
      json['data'].forEach((v) {
        data!.add(new ActivityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityData {
  int? id;
  String? wastePlasticType;
  String? requestDate;
  String? requestTime;
  int? wastePlasticSize;
  String? wastePlasticAddress;
  String? uniqueLocation;
  double? latitude;
  double? longitude;
  Null? message;
  String? pickUpStatus;
  int? requestor;

  ActivityData(
      {this.id,
      this.wastePlasticType,
      this.requestDate,
      this.requestTime,
      this.wastePlasticSize,
      this.wastePlasticAddress,
      this.uniqueLocation,
      this.latitude,
      this.longitude,
      this.message,
      this.pickUpStatus,
      this.requestor});

  ActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wastePlasticType = json['wastePlastic_type'];
    requestDate = json['request_date'];
    requestTime = json['request_time'];
    wastePlasticSize = json['wastePlastic_size'];
    wastePlasticAddress = json['wastePlastic_address'];
    uniqueLocation = json['unique_location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    message = json['message'];
    pickUpStatus = json['pickUp_status'];
    requestor = json['requestor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wastePlastic_type'] = this.wastePlasticType;
    data['request_date'] = this.requestDate;
    data['request_time'] = this.requestTime;
    data['wastePlastic_size'] = this.wastePlasticSize;
    data['wastePlastic_address'] = this.wastePlasticAddress;
    data['unique_location'] = this.uniqueLocation;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['message'] = this.message;
    data['pickUp_status'] = this.pickUpStatus;
    data['requestor'] = this.requestor;
    return data;
  }
}
