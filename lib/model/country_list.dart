class CountryList {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<CountryItem>? countries;

  CountryList(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.countries});

  CountryList.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    countries = json["Details"] == null
        ? null
        : (json["Details"] as List)
            .map((e) => CountryItem.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (countries != null) {
      data["Details"] = countries?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class CountryItem {
  int? id;
  String? code;
  String? text;

  CountryItem({this.id, this.code, this.text});

  CountryItem.fromJson(Map<String, dynamic> json) {
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
