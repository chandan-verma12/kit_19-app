class SearchContacts {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<UserContact>? userContacts;

  SearchContacts(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.userContacts});

  SearchContacts.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    userContacts = json["Details"] == null
        ? null
        : (json["Details"] as List)
            .map((e) => UserContact.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (userContacts != null) {
      data["Details"] = userContacts?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class UserContact {
  String? mobileNo1;
  String? mobileNo2;
  String? mobileNo3;
  String? emailId1;
  String? emailId2;
  String? emailId3;
  String? type;
  int? id;
  String? name;
  String? image;

  UserContact(
      {this.mobileNo1,
      this.mobileNo2,
      this.mobileNo3,
      this.emailId1,
      this.emailId2,
      this.emailId3,
      this.type,
      this.id,
      this.name,
      this.image});

  UserContact.fromJson(Map<String, dynamic> json) {
    mobileNo1 = json["MobileNo1"];
    mobileNo2 = json["MobileNo2"];
    mobileNo3 = json["MobileNo3"];
    emailId1 = json["EmailId1"];
    emailId2 = json["EmailId2"];
    emailId3 = json["EmailId3"];
    type = json["Type"];
    id = json["Id"];
    name = json["Name"];
    image = json["Image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["MobileNo1"] = mobileNo1;
    data["MobileNo2"] = mobileNo2;
    data["MobileNo3"] = mobileNo3;
    data["EmailId1"] = emailId1;
    data["EmailId2"] = emailId2;
    data["EmailId3"] = emailId3;
    data["Type"] = type;
    data["Id"] = id;
    data["Name"] = name;
    data["Image"] = image;
    return data;
  }
}
