class NotesList {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Details>? details;

  NotesList(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  NotesList.fromJson(Map<String, dynamic> json) {
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
  int? noteId;
  String? notes;
  String? createdDate;
  Agent? agent;

  Details({this.noteId, this.notes, this.createdDate, this.agent});

  Details.fromJson(Map<String, dynamic> json) {
    noteId = json['NoteId'];
    notes = json['Notes'];
    createdDate = json['CreatedDate'];
    agent = json['Agent'] != null ? new Agent.fromJson(json['Agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NoteId'] = this.noteId;
    data['Notes'] = this.notes;
    data['CreatedDate'] = this.createdDate;
    if (this.agent != null) {
      data['Agent'] = this.agent!.toJson();
    }
    return data;
  }
}

class Agent {
  int? id;
  String? firstName;
  Null? lastName;
  String? userName;
  String? image;
  String? displayName;

  Agent(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.displayName});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userName = json['UserName'];
    image = json['Image'];
    displayName = json['DisplayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['UserName'] = this.userName;
    data['Image'] = this.image;
    data['DisplayName'] = this.displayName;
    return data;
  }
}