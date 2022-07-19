class SearchLeadById {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  SearchLeadById(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  SearchLeadById.fromJson(Map<String, dynamic> json) {
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
  int? token;
  String? uRL;
  int? userID;
  String? eMail;
  String? fName;
  String? lName;
  String? mobile;
  String? profilePicturePath;
  AuthenticationResponse? authenticationResponse;
  int? parentID;
  String? teamCode;
  String? roleCode;
  String? sipUrl;
  String? sipUser;
  String? sipPwd;
  String? timezone;
  String? timeZoneOffset;

  Details(
      {this.token,
      this.uRL,
      this.userID,
      this.eMail,
      this.fName,
      this.lName,
      this.mobile,
      this.profilePicturePath,
      this.authenticationResponse,
      this.parentID,
      this.teamCode,
      this.roleCode,
      this.sipUrl,
      this.sipUser,
      this.sipPwd,
      this.timezone,
      this.timeZoneOffset});

  Details.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    uRL = json['URL'];
    userID = json['User_ID'];
    eMail = json['EMail'];
    fName = json['FName'];
    lName = json['LName'];
    mobile = json['Mobile'];
    profilePicturePath = json['ProfilePicturePath'];
    authenticationResponse = json['AuthenticationResponse'] != null
        ? new AuthenticationResponse.fromJson(json['AuthenticationResponse'])
        : null;
    parentID = json['ParentID'];
    teamCode = json['TeamCode'];
    roleCode = json['RoleCode'];
    sipUrl = json['SipUrl'];
    sipUser = json['SipUser'];
    sipPwd = json['SipPwd'];
    timezone = json['Timezone'];
    timeZoneOffset = json['TimeZoneOffset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['URL'] = this.uRL;
    data['User_ID'] = this.userID;
    data['EMail'] = this.eMail;
    data['FName'] = this.fName;
    data['LName'] = this.lName;
    data['Mobile'] = this.mobile;
    data['ProfilePicturePath'] = this.profilePicturePath;
    if (this.authenticationResponse != null) {
      data['AuthenticationResponse'] = this.authenticationResponse!.toJson();
    }
    data['ParentID'] = this.parentID;
    data['TeamCode'] = this.teamCode;
    data['RoleCode'] = this.roleCode;
    data['SipUrl'] = this.sipUrl;
    data['SipUser'] = this.sipUser;
    data['SipPwd'] = this.sipPwd;
    data['Timezone'] = this.timezone;
    data['TimeZoneOffset'] = this.timeZoneOffset;
    return data;
  }
}

class AuthenticationResponse {
  int? id;
  Null? code;
  String? text;

  AuthenticationResponse({this.id, this.code, this.text});

  AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    text = json['Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['Text'] = this.text;
    return data;
  }
}
