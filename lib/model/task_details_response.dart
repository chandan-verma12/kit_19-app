class TaskDetailsResponse {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  TaskDetails? details;

  TaskDetailsResponse(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  TaskDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    details =
        json["Details"] == null ? null : TaskDetails.fromJson(json["Details"]);
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

class TaskDetails {
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
  Owner? owner;
  List<Collaborators>? collaborators;
  List<Attachments>? attachments;
  List<Outcomes>? outcomes;
  List<TaskTypes>? taskTypes;

  TaskDetails(
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

  TaskDetails.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    title = json["Title"];
    description = json["Description"];
    remarks = json["Remarks"];
    startDate = json["StartDate"];
    endDate = json["EndDate"];
    createdOn = json["CreatedOn"];
    status = json["Status"];
    isTask = json["IsTask"];
    isAppointment = json["IsAppointment"];
    where = json["Where"];
    latitude = json["Latitude"];
    longitude = json["Longitude"];
    completeAddress = json["CompleteAddress"];
    isEditable = json["IsEditable"];
    isRemoval = json["IsRemoval"];
    outcome =
        json["Outcome"] == null ? null : Outcome.fromJson(json["Outcome"]);
    type = json["Type"] == null ? null : Type.fromJson(json["Type"]);
    lead = json["Lead"] == null ? null : Lead.fromJson(json["Lead"]);
    creator =
        json["Creator"] == null ? null : Creator.fromJson(json["Creator"]);
    owner = json["Owner"] == null ? null : Owner.fromJson(json["Owner"]);
    collaborators = json["Collaborators"] == null
        ? null
        : (json["Collaborators"] as List)
            .map((e) => Collaborators.fromJson(e))
            .toList();
    attachments = json["Attachments"] == null
        ? null
        : (json["Attachments"] as List)
            .map((e) => Attachments.fromJson(e))
            .toList();
    outcomes = json["Outcomes"] == null
        ? null
        : (json["Outcomes"] as List).map((e) => Outcomes.fromJson(e)).toList();
    taskTypes = json["TaskTypes"] == null
        ? null
        : (json["TaskTypes"] as List)
            .map((e) => TaskTypes.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Title"] = title;
    data["Description"] = description;
    data["Remarks"] = remarks;
    data["StartDate"] = startDate;
    data["EndDate"] = endDate;
    data["CreatedOn"] = createdOn;
    data["Status"] = status;
    data["IsTask"] = isTask;
    data["IsAppointment"] = isAppointment;
    data["Where"] = where;
    data["Latitude"] = latitude;
    data["Longitude"] = longitude;
    data["CompleteAddress"] = completeAddress;
    data["IsEditable"] = isEditable;
    data["IsRemoval"] = isRemoval;
    if (outcome != null) {
      data["Outcome"] = outcome?.toJson();
    }
    if (type != null) {
      data["Type"] = type?.toJson();
    }
    if (lead != null) {
      data["Lead"] = lead?.toJson();
    }
    if (creator != null) {
      data["Creator"] = creator?.toJson();
    }
    if (owner != null) {
      data["Owner"] = owner?.toJson();
    }
    if (collaborators != null) {
      data["Collaborators"] = collaborators?.map((e) => e.toJson()).toList();
    }
    if (attachments != null) {
      data["Attachments"] = attachments;
    }
    if (attachments != null) {
      data["Attachments"] = attachments?.map((e) => e.toJson()).toList();
    }

    if (outcomes != null) {
      data["Outcomes"] = outcomes?.map((e) => e.toJson()).toList();
    }
    if (taskTypes != null) {
      data["TaskTypes"] = taskTypes?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  int? id;
  String? fileName;
  String? remarks;
  AttachmentCreator? creator;
  String? fileUrl;

  Attachments({this.id, this.fileName, this.remarks, this.creator});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    fileName = json["FileName"];
    remarks = json["Remarks"];
    fileUrl = json["FileUrl"];
    creator = json["Creator"] == null
        ? null
        : AttachmentCreator.fromJson(json["Creator"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["FileName"] = fileName;
    data["Remarks"] = remarks;
    if (creator != null) {
      data["Creator"] = creator?.toJson();
    }
    return data;
  }
}

class AttachmentCreator {
  int? id;
  String? firstName;
  dynamic? lastName;
  String? userName;
  String? image;
  String? displayName;

  AttachmentCreator(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.displayName});

  AttachmentCreator.fromJson(Map<String, dynamic> json) {
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

class TaskTypes {
  int? id;
  String? name;
  String? icon;

  TaskTypes({this.id, this.name, this.icon});

  TaskTypes.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    name = json["Name"];
    icon = json["Icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Name"] = name;
    data["Icon"] = icon;
    return data;
  }
}

class Outcomes {
  int? id;
  String? name;
  String? intent;
  String? remark;

  Outcomes({this.id, this.name, this.intent, this.remark});

  Outcomes.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    name = json["Name"];
    intent = json["Intent"];
    remark = json["Remark"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Name"] = name;
    data["Intent"] = intent;
    data["Remark"] = remark;
    return data;
  }
}

class Collaborators {
  int? id;
  String? firstName;
  dynamic? lastName;
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

class Owner {
  int? id;
  String? firstName;
  dynamic? lastName;
  String? userName;
  String? image;
  String? displayName;

  Owner(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.displayName});

  Owner.fromJson(Map<String, dynamic> json) {
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

class Creator {
  int? id;
  String? firstName;
  dynamic? lastName;
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

class Lead {
  int? id;
  String? name;
  String? image;

  Lead({this.id, this.name, this.image});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    name = json["Name"];
    image = json["Image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Name"] = name;
    data["Image"] = image;
    return data;
  }
}

class Type {
  int? id;
  String? name;
  String? icon;

  Type({this.id, this.name, this.icon});

  Type.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    name = json["Name"];
    icon = json["Icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Name"] = name;
    data["Icon"] = icon;
    return data;
  }
}

class Outcome {
  int? id;
  String? name;
  String? intent;

  Outcome({this.id, this.name, this.intent});

  Outcome.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    name = json["Name"];
    intent = json["Intent"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Name"] = name;
    data["Intent"] = intent;
    return data;
  }
}
