class CallDetailsResponse {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  CallDetails? details;

  CallDetailsResponse(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  CallDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    details =
        json["Details"] == null ? null : CallDetails.fromJson(json["Details"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (details != null) {
      data["Details"] = details?.toJson();
    }
    return data;
  }
}

class CallDetails {
  int? id;
  Person? person;
  String? direction;
  String? disposition;
  String? outcome;
  String? createdOn;
  String? recodingUrl;
  String? remarks;
  Agent? agent;

  CallDetails(
      {this.id,
      this.person,
      this.direction,
      this.disposition,
      this.outcome,
      this.createdOn,
      this.recodingUrl,
      this.remarks,
      this.agent});

  CallDetails.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    person = json["Person"] == null ? null : Person.fromJson(json["Person"]);
    direction = json["Direction"];
    disposition = json["Disposition"];
    outcome = json["Outcome"];
    createdOn = json["CreatedOn"];
    recodingUrl = json["RecodingUrl"];
    remarks = json["Remarks"];
    agent = json["Agent"] == null ? null : Agent.fromJson(json["Agent"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    if (person != null) {
      data["Person"] = person?.toJson();
    }
    data["Direction"] = direction;
    data["Disposition"] = disposition;
    data["Outcome"] = outcome;
    data["CreatedOn"] = createdOn;
    data["RecodingUrl"] = recodingUrl;
    data["Remarks"] = remarks;
    if (agent != null) {
      data["Agent"] = agent?.toJson();
    }
    return data;
  }
}

class Agent {
  int? id;
  String? firstName;
  dynamic? lastName;
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
    id = json["Id"];
    firstName = json["FirstName"];
    lastName = json["LastName"];
    userName = json["UserName"];
    image = json["Image"];
    displayName = json["DisplayName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["FirstName"] = firstName;
    data["LastName"] = lastName;
    data["UserName"] = userName;
    data["Image"] = image;
    data["DisplayName"] = displayName;
    return data;
  }
}

class Person {
  String? type;
  String? mobileNo;
  int? id;
  String? name;
  String? image;

  Person({this.type, this.mobileNo, this.id, this.name, this.image});

  Person.fromJson(Map<String, dynamic> json) {
    type = json["Type"];
    mobileNo = json["MobileNo"];
    id = json["Id"];
    name = json["Name"];
    image = json["Image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Type"] = type;
    data["MobileNo"] = mobileNo;
    data["Id"] = id;
    data["Name"] = name;
    data["Image"] = image;
    return data;
  }
}
