class FollowUpListResponse {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<FollowUp>? followups;

  FollowUpListResponse(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.followups});

  FollowUpListResponse.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    followups = json["Details"] == null
        ? null
        : (json["Details"] as List).map((e) => FollowUp.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (followups != null) {
      data["Details"] = followups?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class FollowUp {
  String? fupValue;
  int? id;
  String? followupStatus;
  String? intent;
  int? orderNumber;
  bool? isCallback;
  bool? isConvert;
  bool? isDisabled;

  FollowUp(
      {this.fupValue,
      this.id,
      this.followupStatus,
      this.intent,
      this.orderNumber,
      this.isCallback,
      this.isConvert,
      this.isDisabled});

  FollowUp.fromJson(Map<String, dynamic> json) {
    fupValue = json["FUPValue"];
    id = json["ID"];
    followupStatus = json["FollowupStatus"];
    intent = json["Intent"];
    orderNumber = json["OrderNumber"];
    isCallback = json["IsCallback"];
    isConvert = json["IsConvert"];
    isDisabled = json["IsDisabled"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["FUPValue"] = fupValue;
    data["ID"] = id;
    data["FollowupStatus"] = followupStatus;
    data["Intent"] = intent;
    data["OrderNumber"] = orderNumber;
    data["IsCallback"] = isCallback;
    data["IsConvert"] = isConvert;
    data["IsDisabled"] = isDisabled;
    return data;
  }
}
