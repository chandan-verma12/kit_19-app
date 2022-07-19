class DeleteDocument {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  bool? details;

  DeleteDocument(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  DeleteDocument.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    locationTrackingFrequency = json['LocationTrackingFrequency'];
    timsStamp = json['TimsStamp'];
    details = json['Details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['LocationTrackingFrequency'] = this.locationTrackingFrequency;
    data['TimsStamp'] = this.timsStamp;
    data['Details'] = this.details;
    return data;
  }
}
