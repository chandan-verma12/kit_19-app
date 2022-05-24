class LoginData {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  LoginData(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  LoginData.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    details =
        json["Details"] == null ? null : Details.fromJson(json["Details"]);
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

class Details {
  int? token;
  String? url;
  String? userName;
  int? userId;
  String? eMail;
  String? fName;
  String? lName;
  String? mobile;
  String? profilePicturePath;
  AuthenticationResponse? authenticationResponse;
  int? parentId;
  String? teamCode;
  String? roleCode;
  String? sipUrl;
  String? sipUser;
  String? sipPwd;
  String? fcmToken;



  Details(
      {this.token,
      this.url,
      this.userName,
      this.userId,
      this.eMail,
      this.fName,
      this.lName,
      this.mobile,
      this.profilePicturePath,
      this.authenticationResponse,
      this.parentId,
      this.teamCode,
      this.roleCode,
      this.sipUrl,
      this.sipUser,
      this.sipPwd,
      this.fcmToken});

  

  Details.fromJson(Map<String, dynamic> json) {
    token = json["Token"];
    url = json["URL"];
    userName = json["User_Name"];
    userId = json["User_ID"];
    eMail = json["EMail"];
    fName = json["FName"];
    lName = json["LName"];
    mobile = json["Mobile"];
    profilePicturePath = json["ProfilePicturePath"];
    authenticationResponse = json["AuthenticationResponse"] == null
        ? null
        : AuthenticationResponse.fromJson(json["AuthenticationResponse"]);
    parentId = json["ParentID"];
    teamCode = json["TeamCode"];
    roleCode = json["RoleCode"];
    sipUrl = json["SipUrl"];
    sipUser = json["SipUser"];
    sipPwd = json["SipPwd"];
    fcmToken = json["fcmToken"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Token"] = token;
    data["URL"] = url;
    data["User_Name"] = userName;
    data["User_ID"] = userId;
    data["EMail"] = eMail;
    data["FName"] = fName;
    data["LName"] = lName;
    data["Mobile"] = mobile;
    data["ProfilePicturePath"] = profilePicturePath;
    if (authenticationResponse != null) {
      data["AuthenticationResponse"] = authenticationResponse?.toJson();
    }
    data["ParentID"] = parentId;
    data["TeamCode"] = teamCode;
    data["RoleCode"] = roleCode;
    data["SipUrl"] = sipUrl;
    data["SipUser"] = sipUser;
    data["SipPwd"] = sipPwd;
    data["fcmToken"] = fcmToken;
    return data;
  }
}

class AuthenticationResponse {
  int? id;
  dynamic? code;
  String? text;

  AuthenticationResponse({this.id, this.code, this.text});

  AuthenticationResponse.fromJson(Map<String, dynamic> json) {
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
