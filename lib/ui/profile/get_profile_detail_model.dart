class GetProfileDetails {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  GetProfileDetails(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  GetProfileDetails.fromJson(Map<String, dynamic> json) {
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
  String? userLogin;
  String? firstName;
  String? lastName;
  String? emailId;
  String? countryCode;
  String? mobileNo;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? image;
  String? companyName;
  String? accountType;
  String? timezone;

  Details(
      {this.userLogin,
      this.firstName,
      this.lastName,
      this.emailId,
      this.countryCode,
      this.mobileNo,
      this.address,
      this.city,
      this.state,
      this.country,
      this.pinCode,
      this.image,
      this.companyName,
      this.accountType,
      this.timezone});

  Details.fromJson(Map<String, dynamic> json) {
    userLogin = json['UserLogin'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    emailId = json['EmailId'];
    countryCode = json['CountryCode'];
    mobileNo = json['MobileNo'];
    address = json['Address'];
    city = json['City'];
    state = json['State'];
    country = json['Country'];
    pinCode = json['PinCode'];
    image = json['Image'];
    companyName = json['CompanyName'];
    accountType = json['AccountType'];
    timezone = json['Timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserLogin'] = this.userLogin;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['EmailId'] = this.emailId;
    data['CountryCode'] = this.countryCode;
    data['MobileNo'] = this.mobileNo;
    data['Address'] = this.address;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['PinCode'] = this.pinCode;
    data['Image'] = this.image;
    data['CompanyName'] = this.companyName;
    data['AccountType'] = this.accountType;
    data['Timezone'] = this.timezone;
    return data;
  }
}