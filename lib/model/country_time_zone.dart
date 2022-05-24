class CountryTimeZone {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<TimeZone>? zones;

  CountryTimeZone(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.zones});

  CountryTimeZone.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    zones = json["Details"] == null
        ? null
        : (json["Details"] as List).map((e) => TimeZone.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (zones != null) {
      data["Details"] = zones?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class TimeZone {
  int? id;
  String? code;
  String? text;

  TimeZone({this.id, this.code, this.text});

  TimeZone.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    code = json["Code"];
    text = json["Text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Code"] = code;
    data["Text"] = text;
    return data;
  }
}
