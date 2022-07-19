class AddNotes {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  bool? details;

  AddNotes(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  AddNotes.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    locationTrackingFrequency = json['LocationTrackingFrequency'];
    timsStamp = json['TimsStamp'];
    details = json['Details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = status;
    data['Message'] = message;
    data['LocationTrackingFrequency'] = locationTrackingFrequency;
    data['TimsStamp'] = timsStamp;
    data['Details'] = details;
    return data;
  }
}