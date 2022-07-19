class TaskListModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Details>? details;

  TaskListModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  TaskListModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? startDate;
  String? endDate;
  String? leadId;
  String? personName;
  String? personImage;
  String? outcome;
  String? agentId;
  String? agentImage;
  String? agentName;
  String? status;
  String? intent;
  bool? isEditable;
  bool? isRemoval;

  Details(
      {this.id,
      this.title,
      this.startDate,
      this.endDate,
      this.leadId,
      this.personName,
      this.personImage,
      this.outcome,
      this.agentId,
      this.agentImage,
      this.agentName,
      this.status,
      this.intent,
      this.isEditable,
      this.isRemoval});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    leadId = json['LeadId'];
    personName = json['PersonName'];
    personImage = json['PersonImage'];
    outcome = json['Outcome'];
    agentId = json['AgentId'];
    agentImage = json['AgentImage'];
    agentName = json['AgentName'];
    status = json['Status'];
    intent = json['Intent'];
    isEditable = json['IsEditable'];
    isRemoval = json['IsRemoval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['LeadId'] = this.leadId;
    data['PersonName'] = this.personName;
    data['PersonImage'] = this.personImage;
    data['Outcome'] = this.outcome;
    data['AgentId'] = this.agentId;
    data['AgentImage'] = this.agentImage;
    data['AgentName'] = this.agentName;
    data['Status'] = this.status;
    data['Intent'] = this.intent;
    data['IsEditable'] = this.isEditable;
    data['IsRemoval'] = this.isRemoval;
    return data;
  }
}
