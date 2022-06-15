class EnquiryFullDetailsModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Details>? details;

  EnquiryFullDetailsModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  EnquiryFullDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    locationTrackingFrequency = json['LocationTrackingFrequency'];
    timsStamp = json['TimsStamp'];
    if (json['Details'] != null) {
      details = <Details>[];
      json['Details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['LocationTrackingFrequency'] = this.locationTrackingFrequency;
    data['TimsStamp'] = this.timsStamp;
    if (this.details != null) {
      data['Details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? enquiryID;
  String? personName;
  String? companyName;
  String? mobileNo1;
  String? mobileNo2;
  String? mobileNo3;
  String? emailID1;
  String? emailID2;
  String? emailID3;
  String? residentialAddress;
  String? officeAddress;
  String? userLogin;
  String? city;
  String? state;
  String? country;
  String? countryCode1;
  String? countryCode2;
  String? countryCode3;
  String? pincode;
  String? address;
  String? initialRemarks;
  String? sourceName;
  String? mediumName;
  String? campaignName;
  int? parentId;
  String? createdDate;
  int? createdBy;
  int? leadNo;
  String? isOpen;
  String? imgExt;
  String? profileImgFileName;
  String? abcd;
  Null? alpha;
  Null? anotherAcceptTermCondition;
  Null? anotherAddress;
  Null? anotherAge;
  Null? anotherBranch;
  Null? anotherDateOfBirth;
  Null? anotherGenderField;
  Null? anotherHobby;
  Null? anotherName;
  Null? budget;
  Null? dateofbirth;
  Null? dOBPAN;
  Null? name1;
  String? name2;
  String? name3;
  Null? name4;
  String? nAMEONE;
  Null? newfield;
  String? nEWMOBILE;
  Null? project;
  Null? test06;
  Null? test07;
  Null? test08;
  Null? test10;
  Null? test11;
  Null? test12;
  Null? test13;
  Null? test14;
  Null? test15;
  Null? test16;
  Null? test17;
  Null? test18;
  Null? test19;
  Null? test20;
  Null? test21;
  Null? test22;
  Null? test23;
  Null? test24;
  Null? test25;
  Null? test26;
  Null? test27;
  Null? test28;
  Null? test29;
  Null? test30;
  Null? test31;
  Null? test32;
  Null? test33;
  Null? test34;
  Null? test35;
  Null? test36;
  Null? uNGALI;
  Null? yes;
  Null? yujhu;

  Details(
      {this.enquiryID,
      this.personName,
      this.companyName,
      this.mobileNo1,
      this.mobileNo2,
      this.mobileNo3,
      this.emailID1,
      this.emailID2,
      this.emailID3,
      this.residentialAddress,
      this.officeAddress,
      this.userLogin,
      this.city,
      this.state,
      this.country,
      this.countryCode1,
      this.countryCode2,
      this.countryCode3,
      this.pincode,
      this.address,
      this.initialRemarks,
      this.sourceName,
      this.mediumName,
      this.campaignName,
      this.parentId,
      this.createdDate,
      this.createdBy,
      this.leadNo,
      this.isOpen,
      this.imgExt,
      this.profileImgFileName,
      this.abcd,
      this.alpha,
      this.anotherAcceptTermCondition,
      this.anotherAddress,
      this.anotherAge,
      this.anotherBranch,
      this.anotherDateOfBirth,
      this.anotherGenderField,
      this.anotherHobby,
      this.anotherName,
      this.budget,
      this.dateofbirth,
      this.dOBPAN,
      this.name1,
      this.name2,
      this.name3,
      this.name4,
      this.nAMEONE,
      this.newfield,
      this.nEWMOBILE,
      this.project,
      this.test06,
      this.test07,
      this.test08,
      this.test10,
      this.test11,
      this.test12,
      this.test13,
      this.test14,
      this.test15,
      this.test16,
      this.test17,
      this.test18,
      this.test19,
      this.test20,
      this.test21,
      this.test22,
      this.test23,
      this.test24,
      this.test25,
      this.test26,
      this.test27,
      this.test28,
      this.test29,
      this.test30,
      this.test31,
      this.test32,
      this.test33,
      this.test34,
      this.test35,
      this.test36,
      this.uNGALI,
      this.yes,
      this.yujhu});

  Details.fromJson(Map<String, dynamic> json) {
    enquiryID = json['EnquiryID'];
    personName = json['PersonName'];
    companyName = json['CompanyName'];
    mobileNo1 = json['MobileNo1'];
    mobileNo2 = json['MobileNo2'];
    mobileNo3 = json['MobileNo3'];
    emailID1 = json['EmailID1'];
    emailID2 = json['EmailID2'];
    emailID3 = json['EmailID3'];
    residentialAddress = json['ResidentialAddress'];
    officeAddress = json['OfficeAddress'];
    userLogin = json['User_Login'];
    city = json['City'];
    state = json['State'];
    country = json['Country'];
    countryCode1 = json['CountryCode1'];
    countryCode2 = json['CountryCode2'];
    countryCode3 = json['CountryCode3'];
    pincode = json['Pincode'];
    address = json['Address'];
    initialRemarks = json['InitialRemarks'];
    sourceName = json['SourceName'];
    mediumName = json['MediumName'];
    campaignName = json['CampaignName'];
    parentId = json['ParentId'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    leadNo = json['LeadNo'];
    isOpen = json['IsOpen'];
    imgExt = json['Img_Ext'];
    profileImgFileName = json['ProfileImgFileName'];
    abcd = json['abcd'];
    alpha = json['alpha'];
    anotherAcceptTermCondition = json['Another-Accept-Term-Condition'];
    anotherAddress = json['Another-Address'];
    anotherAge = json['Another-Age'];
    anotherBranch = json['Another-Branch'];
    anotherDateOfBirth = json['Another-Date-of-birth'];
    anotherGenderField = json['Another-Gender-Field'];
    anotherHobby = json['Another-Hobby'];
    anotherName = json['Another-Name'];
    budget = json['Budget'];
    dateofbirth = json['dateofbirth'];
    dOBPAN = json['DOBPAN'];
    name1 = json['Name1'];
    name2 = json['Name2'];
    name3 = json['Name3'];
    name4 = json['Name4'];
    nAMEONE = json['NAMEONE'];
    newfield = json['newfield'];
    nEWMOBILE = json['NEWMOBILE'];
    project = json['project'];
    test06 = json['test06'];
    test07 = json['test07'];
    test08 = json['test08'];
    test10 = json['test10'];
    test11 = json['test11'];
    test12 = json['test12'];
    test13 = json['test13'];
    test14 = json['test14'];
    test15 = json['test15'];
    test16 = json['test16'];
    test17 = json['test17'];
    test18 = json['test18'];
    test19 = json['test19'];
    test20 = json['test20'];
    test21 = json['test21'];
    test22 = json['test22'];
    test23 = json['test23'];
    test24 = json['test24'];
    test25 = json['test25'];
    test26 = json['test26'];
    test27 = json['test27'];
    test28 = json['test28'];
    test29 = json['test29'];
    test30 = json['test30'];
    test31 = json['test31'];
    test32 = json['test32'];
    test33 = json['test33'];
    test34 = json['test34'];
    test35 = json['test35'];
    test36 = json['test36'];
    uNGALI = json['UNGALI'];
    yes = json['Yes'];
    yujhu = json['yujhu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EnquiryID'] = this.enquiryID;
    data['PersonName'] = this.personName;
    data['CompanyName'] = this.companyName;
    data['MobileNo1'] = this.mobileNo1;
    data['MobileNo2'] = this.mobileNo2;
    data['MobileNo3'] = this.mobileNo3;
    data['EmailID1'] = this.emailID1;
    data['EmailID2'] = this.emailID2;
    data['EmailID3'] = this.emailID3;
    data['ResidentialAddress'] = this.residentialAddress;
    data['OfficeAddress'] = this.officeAddress;
    data['User_Login'] = this.userLogin;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['CountryCode1'] = this.countryCode1;
    data['CountryCode2'] = this.countryCode2;
    data['CountryCode3'] = this.countryCode3;
    data['Pincode'] = this.pincode;
    data['Address'] = this.address;
    data['InitialRemarks'] = this.initialRemarks;
    data['SourceName'] = this.sourceName;
    data['MediumName'] = this.mediumName;
    data['CampaignName'] = this.campaignName;
    data['ParentId'] = this.parentId;
    data['CreatedDate'] = this.createdDate;
    data['CreatedBy'] = this.createdBy;
    data['LeadNo'] = this.leadNo;
    data['IsOpen'] = this.isOpen;
    data['Img_Ext'] = this.imgExt;
    data['ProfileImgFileName'] = this.profileImgFileName;
    data['abcd'] = this.abcd;
    data['alpha'] = this.alpha;
    data['Another-Accept-Term-Condition'] = this.anotherAcceptTermCondition;
    data['Another-Address'] = this.anotherAddress;
    data['Another-Age'] = this.anotherAge;
    data['Another-Branch'] = this.anotherBranch;
    data['Another-Date-of-birth'] = this.anotherDateOfBirth;
    data['Another-Gender-Field'] = this.anotherGenderField;
    data['Another-Hobby'] = this.anotherHobby;
    data['Another-Name'] = this.anotherName;
    data['Budget'] = this.budget;
    data['dateofbirth'] = this.dateofbirth;
    data['DOBPAN'] = this.dOBPAN;
    data['Name1'] = this.name1;
    data['Name2'] = this.name2;
    data['Name3'] = this.name3;
    data['Name4'] = this.name4;
    data['NAMEONE'] = this.nAMEONE;
    data['newfield'] = this.newfield;
    data['NEWMOBILE'] = this.nEWMOBILE;
    data['project'] = this.project;
    data['test06'] = this.test06;
    data['test07'] = this.test07;
    data['test08'] = this.test08;
    data['test10'] = this.test10;
    data['test11'] = this.test11;
    data['test12'] = this.test12;
    data['test13'] = this.test13;
    data['test14'] = this.test14;
    data['test15'] = this.test15;
    data['test16'] = this.test16;
    data['test17'] = this.test17;
    data['test18'] = this.test18;
    data['test19'] = this.test19;
    data['test20'] = this.test20;
    data['test21'] = this.test21;
    data['test22'] = this.test22;
    data['test23'] = this.test23;
    data['test24'] = this.test24;
    data['test25'] = this.test25;
    data['test26'] = this.test26;
    data['test27'] = this.test27;
    data['test28'] = this.test28;
    data['test29'] = this.test29;
    data['test30'] = this.test30;
    data['test31'] = this.test31;
    data['test32'] = this.test32;
    data['test33'] = this.test33;
    data['test34'] = this.test34;
    data['test35'] = this.test35;
    data['test36'] = this.test36;
    data['UNGALI'] = this.uNGALI;
    data['Yes'] = this.yes;
    data['yujhu'] = this.yujhu;
    return data;
  }
}
