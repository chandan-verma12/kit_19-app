class GetEnqOrLeadMobModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  GetEnqOrLeadMobModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  GetEnqOrLeadMobModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? personName;
  String? companyName;
  String? profileImgFileName;
  String? lastContacted;
  String? callDirection;
  String? leadScore;
  String? type;
  String? viewUrl;

  Details(
      {this.id,
      this.personName,
      this.companyName,
      this.profileImgFileName,
      this.lastContacted,
      this.callDirection,
      this.leadScore,
      this.type,
      this.viewUrl});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    personName = json['PersonName'];
    companyName = json['CompanyName'];
    profileImgFileName = json['ProfileImgFileName'];
    lastContacted = json['LastContacted'];
    callDirection = json['CallDirection'];
    leadScore = json['LeadScore'];
    type = json['Type'];
    viewUrl = json['ViewUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['PersonName'] = this.personName;
    data['CompanyName'] = this.companyName;
    data['ProfileImgFileName'] = this.profileImgFileName;
    data['LastContacted'] = this.lastContacted;
    data['CallDirection'] = this.callDirection;
    data['LeadScore'] = this.leadScore;
    data['Type'] = this.type;
    data['ViewUrl'] = this.viewUrl;
    return data;
  }
}
