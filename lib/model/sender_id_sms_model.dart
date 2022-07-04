class SMSSenderId {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<SenderID>? senderid;

  SMSSenderId(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.senderid});

  SMSSenderId.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    locationTrackingFrequency = json['LocationTrackingFrequency'];
    timsStamp = json['TimsStamp'];
    if (json['Details'] != null) {
      senderid = <SenderID>[];
      json['Details'].forEach((v) {
        senderid!.add(new SenderID.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['LocationTrackingFrequency'] = this.locationTrackingFrequency;
    data['TimsStamp'] = this.timsStamp;
    if (this.senderid != null) {
      data['Details'] = this.senderid!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SenderID {
  int? senderId;
  String? senderName;

  SenderID({this.senderId, this.senderName});

  SenderID.fromJson(Map<String, dynamic> json) {
    senderId = json['SenderId'];
    senderName = json['SenderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SenderId'] = this.senderId;
    data['SenderName'] = this.senderName;
    return data;
  }
}
