class CollaboratorListResponse {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Collaborator>? collaborators;

  CollaboratorListResponse(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.collaborators});

  CollaboratorListResponse.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    collaborators = json["Details"] == null
        ? null
        : (json["Details"] as List)
            .map((e) => Collaborator.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (collaborators != null) {
      data["Details"] = collaborators?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Collaborator {
  int? id;
  String? firstName;
  dynamic? lastName;
  String? userName;
  String? image;
  String? displayName;
  bool isChecked = false;

  Collaborator(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.displayName});

  Collaborator.fromJson(Map<String, dynamic> json) {
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
