class OutComeList {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<OutCome>? outComes;

  OutComeList(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.outComes});

  OutComeList.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    outComes = json["Details"] == null
        ? null
        : (json["Details"] as List).map((e) => OutCome.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (outComes != null) {
      data["Details"] = outComes?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class OutCome {
  int? id;
  String? code;
  String? text;
  String? remark;

  OutCome({this.id, this.code, this.text, this.remark});

  OutCome.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    code = json["Code"];
    text = json["Text"];
    remark = json["Remark"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Code"] = code;
    data["Text"] = text;
    data["Remark"] = remark;
    return data;
  }
}
