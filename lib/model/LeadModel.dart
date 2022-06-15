class LeadListModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  LeadListModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  LeadListModel.fromJson(Map<String, dynamic> json) {
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
  int? totalRecords;
  List<Data>? data;

  Details({this.totalRecords, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRecords'] = this.totalRecords;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? personName;
  String? image;
  int? leadNo;
  Null? latitude;
  Null? longitude;
  String? createdDate;
  String? csvMobileNo;
  String? csvEmailId;
  String? followupDate;
  String? htmlStatus;
  String? profitLoss;
  int? currentScore;
  String? thresholdColor;
  String? remarks;
  String? agentlogin;

  Data(
      {this.id,
      this.personName,
      this.image,
      this.leadNo,
      this.latitude,
      this.longitude,
      this.createdDate,
      this.csvMobileNo,
      this.csvEmailId,
      this.followupDate,
      this.htmlStatus,
      this.profitLoss,
      this.currentScore,
      this.thresholdColor,
      this.remarks,
      this.agentlogin});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    personName = json['PersonName'];
    image = json['Image'];
    leadNo = json['LeadNo'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    createdDate = json['CreatedDate'];
    csvMobileNo = json['CsvMobileNo'];
    csvEmailId = json['CsvEmailId'];
    followupDate = json['FollowupDate'];
    htmlStatus = json['HtmlStatus'];
    profitLoss = json['ProfitLoss'];
    currentScore = json['CurrentScore'];
    thresholdColor = json['ThresholdColor'];
    agentlogin = json['AgentLogin'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['PersonName'] = this.personName;
    data['Image'] = this.image;
    data['LeadNo'] = this.leadNo;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['CreatedDate'] = this.createdDate;
    data['CsvMobileNo'] = this.csvMobileNo;
    data['CsvEmailId'] = this.csvEmailId;
    data['FollowupDate'] = this.followupDate;
    data['HtmlStatus'] = this.htmlStatus;
    data['ProfitLoss'] = this.profitLoss;
    data['CurrentScore'] = this.currentScore;
    data['ThresholdColor'] = this.thresholdColor;
    data['AgentLogin'] = this.agentlogin;
    data['Remarks'] = this.remarks;
    return data;
  }
}
