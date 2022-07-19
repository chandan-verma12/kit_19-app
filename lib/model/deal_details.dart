class DealDetailsModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Details>? details;

  DealDetailsModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  DealDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    locationTrackingFrequency = json['LocationTrackingFrequency'];
    timsStamp = json['TimsStamp'];
    if (json['Details'] != null) {
      details = <Details>[];
      json['Details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['LocationTrackingFrequency'] = this.locationTrackingFrequency;
    data['TimsStamp'] = this.timsStamp;
    if (this.details != null) {
      data['Details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? id;
  String? pipelineName;
  String? stageName;
  String? dealOwner;
  double? amount;
  double? probability;
  String? createdDate;
  String? createdBy;

  Details(
      {this.id,
      this.pipelineName,
      this.stageName,
      this.dealOwner,
      this.amount,
      this.probability,
      this.createdDate,
      this.createdBy});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    pipelineName = json['PipelineName'];
    stageName = json['StageName'];
    dealOwner = json['DealOwner'];
    amount = json['Amount'];
    probability = json['Probability'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['PipelineName'] = this.pipelineName;
    data['StageName'] = this.stageName;
    data['DealOwner'] = this.dealOwner;
    data['Amount'] = this.amount;
    data['Probability'] = this.probability;
    data['CreatedDate'] = this.createdDate;
    data['CreatedBy'] = this.createdBy;
    return data;
  }
}
