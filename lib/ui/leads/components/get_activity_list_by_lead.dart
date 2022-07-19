class GetActivityListByLead {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  GetActivityListByLead(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  GetActivityListByLead.fromJson(Map<String, dynamic> json) {
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
  List<Table>? table;

  Details({this.table});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  int? leadPipeLineMappingId;
  int? leadId;
  int? pipelineID;
  String? pipeLineName;
  String? pipeLineStageName;
  double? probability;
  double? amount;
  String? fullName;
  String? userLogin;
  String? estimatedClosureDate;
  double? amount1;
  Null? profileImgFileName;
  String? createdDate;

  Table(
      {this.leadPipeLineMappingId,
      this.leadId,
      this.pipelineID,
      this.pipeLineName,
      this.pipeLineStageName,
      this.probability,
      this.amount,
      this.fullName,
      this.userLogin,
      this.estimatedClosureDate,
      this.amount1,
      this.profileImgFileName,
      this.createdDate});

  Table.fromJson(Map<String, dynamic> json) {
    leadPipeLineMappingId = json['LeadPipeLineMappingId'];
    leadId = json['LeadId'];
    pipelineID = json['PipelineID'];
    pipeLineName = json['PipeLineName'];
    pipeLineStageName = json['PipeLineStageName'];
    probability = json['Probability'];
    amount = json['Amount'];
    fullName = json['FullName'];
    userLogin = json['User_Login'];
    estimatedClosureDate = json['EstimatedClosureDate'];
    amount1 = json['Amount1'];
    profileImgFileName = json['ProfileImgFileName'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadPipeLineMappingId'] = this.leadPipeLineMappingId;
    data['LeadId'] = this.leadId;
    data['PipelineID'] = this.pipelineID;
    data['PipeLineName'] = this.pipeLineName;
    data['PipeLineStageName'] = this.pipeLineStageName;
    data['Probability'] = this.probability;
    data['Amount'] = this.amount;
    data['FullName'] = this.fullName;
    data['User_Login'] = this.userLogin;
    data['EstimatedClosureDate'] = this.estimatedClosureDate;
    data['Amount1'] = this.amount1;
    data['ProfileImgFileName'] = this.profileImgFileName;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}
