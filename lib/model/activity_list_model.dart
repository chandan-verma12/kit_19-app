class ActivityListModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Details>? details;

  ActivityListModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  ActivityListModel.fromJson(Map<String, dynamic> json) {
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
  int? historyId;
  String? eventIcon;
  String? eventDate;
  String? eventName;
  String? eventType;
  String? eventDescription;
  Person? person;
  Agent? agent;

  Details(
      {this.historyId,
      this.eventIcon,
      this.eventDate,
      this.eventName,
      this.eventType,
      this.eventDescription,
      this.person,
      this.agent});

  Details.fromJson(Map<String, dynamic> json) {
    historyId = json['HistoryId'];
    eventIcon = json['EventIcon'];
    eventDate = json['EventDate'];
    eventName = json['EventName'];
    eventType = json['EventType'];
    eventDescription = json['EventDescription'];
    person =
        json['Person'] != null ? new Person.fromJson(json['Person']) : null;
    agent = json['Agent'] != null ? new Agent.fromJson(json['Agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HistoryId'] = this.historyId;
    data['EventIcon'] = this.eventIcon;
    data['EventDate'] = this.eventDate;
    data['EventName'] = this.eventName;
    data['EventType'] = this.eventType;
    data['EventDescription'] = this.eventDescription;
    if (this.person != null) {
      data['Person'] = this.person!.toJson();
    }
    if (this.agent != null) {
      data['Agent'] = this.agent!.toJson();
    }
    return data;
  }
}

class Person {
  int? id;
  String? name;
  String? image;

  Person({this.id, this.name, this.image});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Image'] = this.image;
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
