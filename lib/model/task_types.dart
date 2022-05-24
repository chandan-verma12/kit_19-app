class TaskTypeResponse {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<TaskType>? types;

  TaskTypeResponse(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.types});

  TaskTypeResponse.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    types = json["Details"] == null
        ? null
        : (json["Details"] as List).map((e) => TaskType.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (types != null) {
      data["Details"] = types?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class TaskType {
  int? id;
  String? name;
  String? icon;

  TaskType({this.id, this.name, this.icon});

  TaskType.fromJson(Map<String, dynamic> json) {
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
