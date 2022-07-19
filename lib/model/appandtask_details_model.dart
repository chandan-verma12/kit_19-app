class AppandtaskDetailsModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  AppandtaskDetailsModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  AppandtaskDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? description;
  String? remarks;
  String? startDate;
  String? endDate;
  String? createdOn;
  String? status;
  bool? isTask;
  bool? isAppointment;
  String? where;
  String? latitude;
  String? longitude;
  String? completeAddress;
  bool? isEditable;
  bool? isRemoval;
  Outcome? outcome;
  Type? type;
  Lead? lead;
  Creator? creator;
  Creator? owner;
  List<Collaborators>? collaborators;
  List<Attachments>? attachments;
  List<Outcomes>? outcomes;
  List<TaskTypes>? taskTypes;

  Details(
      {this.id,
      this.title,
      this.description,
      this.remarks,
      this.startDate,
      this.endDate,
      this.createdOn,
      this.status,
      this.isTask,
      this.isAppointment,
      this.where,
      this.latitude,
      this.longitude,
      this.completeAddress,
      this.isEditable,
      this.isRemoval,
      this.outcome,
      this.type,
      this.lead,
      this.creator,
      this.owner,
      this.collaborators,
      this.attachments,
      this.outcomes,
      this.taskTypes});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    description = json['Description'];
    remarks = json['Remarks'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    createdOn = json['CreatedOn'];
    status = json['Status'];
    isTask = json['IsTask'];
    isAppointment = json['IsAppointment'];
    where = json['Where'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    completeAddress = json['CompleteAddress'];
    isEditable = json['IsEditable'];
    isRemoval = json['IsRemoval'];
    outcome =
        json['Outcome'] != null ? new Outcome.fromJson(json['Outcome']) : null;
    type = json['Type'] != null ? new Type.fromJson(json['Type']) : null;
    lead = json['Lead'] != null ? new Lead.fromJson(json['Lead']) : null;
    creator =
        json['Creator'] != null ? new Creator.fromJson(json['Creator']) : null;
    owner = json['Owner'] != null ? new Creator.fromJson(json['Owner']) : null;
    if (json['Collaborators'] != null) {
      collaborators = <Collaborators>[];
      json['Collaborators'].forEach((v) {
        collaborators!.add(new Collaborators.fromJson(v));
      });
    }
    if (json['Attachments'] != null) {
      attachments = <Attachments>[];
      json['Attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    if (json['Outcomes'] != null) {
      outcomes = <Outcomes>[];
      json['Outcomes'].forEach((v) {
        outcomes!.add(new Outcomes.fromJson(v));
      });
    }
    if (json['TaskTypes'] != null) {
      taskTypes = <TaskTypes>[];
      json['TaskTypes'].forEach((v) {
        taskTypes!.add(new TaskTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Remarks'] = this.remarks;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['CreatedOn'] = this.createdOn;
    data['Status'] = this.status;
    data['IsTask'] = this.isTask;
    data['IsAppointment'] = this.isAppointment;
    data['Where'] = this.where;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['CompleteAddress'] = this.completeAddress;
    data['IsEditable'] = this.isEditable;
    data['IsRemoval'] = this.isRemoval;
    if (this.outcome != null) {
      data['Outcome'] = this.outcome!.toJson();
    }
    if (this.type != null) {
      data['Type'] = this.type!.toJson();
    }
    if (this.lead != null) {
      data['Lead'] = this.lead!.toJson();
    }
    if (this.creator != null) {
      data['Creator'] = this.creator!.toJson();
    }
    if (this.owner != null) {
      data['Owner'] = this.owner!.toJson();
    }
    if (this.collaborators != null) {
      data['Collaborators'] =
          this.collaborators!.map((v) => v.toJson()).toList();
    }
    if (this.attachments != null) {
      data['Attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.outcomes != null) {
      data['Outcomes'] = this.outcomes!.map((v) => v.toJson()).toList();
    }
    if (this.taskTypes != null) {
      data['TaskTypes'] = this.taskTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Outcomes {
  int? id;
  String? name;
  String? intent;

  Outcomes({this.id, this.name, this.intent});

  Outcomes.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    intent = json['Intent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Intent'] = this.intent;
    return data;
  }
}

class Outcome {
  int? id;
  String? name;
  String? intent;

  Outcome({this.id, this.name, this.intent});

  Outcome.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    intent = json['Intent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Intent'] = this.intent;
    return data;
  }
}

class Type {
  int? id;
  String? name;
  String? icon;

  Type({this.id, this.name, this.icon});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    return data;
  }
}

class TaskTypes {
  int? id;
  String? name;
  String? icon;

  TaskTypes({this.id, this.name, this.icon});

  TaskTypes.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    return data;
  }
}

class Lead {
  int? id;
  String? name;
  String? image;

  Lead({this.id, this.name, this.image});

  Lead.fromJson(Map<String, dynamic> json) {
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

class Creator {
  int? id;
  String? firstName;
  Null? lastName;
  String? userName;
  String? image;
  String? displayName;

  Creator(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.displayName});

  Creator.fromJson(Map<String, dynamic> json) {
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

class Attachments {
  int? id;
  String? fileName;
  String? fileUrl;
  String? remarks;
  Creator? creator;

  Attachments(
      {this.id, this.fileName, this.fileUrl, this.remarks, this.creator});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fileName = json['FileName'];
    fileUrl = json['FileUrl'];
    remarks = json['Remarks'];
    creator =
        json['Creator'] != null ? new Creator.fromJson(json['Creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FileName'] = this.fileName;
    data['FileUrl'] = this.fileUrl;
    data['Remarks'] = this.remarks;
    if (this.creator != null) {
      data['Creator'] = this.creator!.toJson();
    }
    return data;
  }
}

class Collaborators {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? image;
  String? displayName;

  Collaborators(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.displayName});

  Collaborators.fromJson(Map<String, dynamic> json) {
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
