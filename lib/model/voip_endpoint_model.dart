class VoidCallEndPointModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  VoidCallEndPointModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  VoidCallEndPointModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    locationTrackingFrequency = json['LocationTrackingFrequency'];
    timsStamp = json['TimsStamp'];
    details =
        json['Details'] != null ? new Details.fromJson(json['Details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['LocationTrackingFrequency'] = this.locationTrackingFrequency;
    data['TimsStamp'] = this.timsStamp;
    if (this.details != null) {
      data['Details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  bool? status;
  String? msg;
  String? toMobileNo;
  String? uniqueIdentity;

  Details({this.status, this.msg, this.toMobileNo, this.uniqueIdentity});

  Details.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    msg = json['Msg'];
    toMobileNo = json['ToMobileNo'];
    uniqueIdentity = json['UniqueIdentity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['ToMobileNo'] = this.toMobileNo;
    data['UniqueIdentity'] = this.uniqueIdentity;
    return data;
  }
}