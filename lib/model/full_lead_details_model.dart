class FullLeadDetailsModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  FullLeadDetailsModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  FullLeadDetailsModel.fromJson(Map<String, dynamic> json) {
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
  PredefinedFields? predefinedFields;
  CustomFields? customFields;
  List<DealStageList>? dealStageList;

  Details({this.predefinedFields, this.customFields, this.dealStageList});

  Details.fromJson(Map<String, dynamic> json) {
    predefinedFields = json['PredefinedFields'] != null
        ? new PredefinedFields.fromJson(json['PredefinedFields'])
        : null;
    customFields = json['CustomFields'] != null
        ? new CustomFields.fromJson(json['CustomFields'])
        : null;
    if (json['dealStageList'] != null) {
      dealStageList = <DealStageList>[];
      json['dealStageList'].forEach((v) {
        dealStageList!.add(new DealStageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.predefinedFields != null) {
      data['PredefinedFields'] = this.predefinedFields!.toJson();
    }
    if (this.customFields != null) {
      data['CustomFields'] = this.customFields!.toJson();
    }
    if (this.dealStageList != null) {
      data['dealStageList'] =
          this.dealStageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PredefinedFields {
  String? leadNo;
  String? personName;
  String? companyName;
  String? countryCode;
  String? countryCode1;
  String? countryCode2;
  String? mobileNo;
  String? mobileNo1;
  String? mobileNo2;
  String? emailID;
  String? emailID1;
  String? emailID2;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? residentialAddress;
  String? assignedTo;
  String? sourceName;
  String? mediumName;
  String? campaignName;
  String? remark;
  String? followupStatus;
  String? createdOn;
  String? modifiedon;
  String? followupdate;
  String? createdBy;
  String? modifiedBy;
  String? officeaddress;
  String? countrycode3;
  String? assignId;
  String? sourceId;
  String? mediumId;
  String? campId;
  String? followStatusId;
  String? products;
  String? amountPaid;
  String? imgExt;
  String? initialRemarks;
  String? whereAddress;
  String? latitude;
  String? longitude;
  String? tagNames;

  PredefinedFields(
      {this.leadNo,
      this.personName,
      this.companyName,
      this.countryCode,
      this.countryCode1,
      this.countryCode2,
      this.mobileNo,
      this.mobileNo1,
      this.mobileNo2,
      this.emailID,
      this.emailID1,
      this.emailID2,
      this.city,
      this.state,
      this.country,
      this.pinCode,
      this.residentialAddress,
      this.assignedTo,
      this.sourceName,
      this.mediumName,
      this.campaignName,
      this.remark,
      this.followupStatus,
      this.createdOn,
      this.modifiedon,
      this.followupdate,
      this.createdBy,
      this.modifiedBy,
      this.officeaddress,
      this.countrycode3,
      this.assignId,
      this.sourceId,
      this.mediumId,
      this.campId,
      this.followStatusId,
      this.products,
      this.amountPaid,
      this.imgExt,
      this.initialRemarks,
      this.whereAddress,
      this.latitude,
      this.longitude,
      this.tagNames});

  PredefinedFields.fromJson(Map<String, dynamic> json) {
    leadNo = json['LeadNo'];
    personName = json['PersonName'];
    companyName = json['CompanyName'];
    countryCode = json['CountryCode'];
    countryCode1 = json['CountryCode1'];
    countryCode2 = json['CountryCode2'];
    mobileNo = json['MobileNo'];
    mobileNo1 = json['MobileNo1'];
    mobileNo2 = json['MobileNo2'];
    emailID = json['EmailID'];
    emailID1 = json['EmailID1'];
    emailID2 = json['EmailID2'];
    city = json['City'];
    state = json['State'];
    country = json['Country'];
    pinCode = json['PinCode'];
    residentialAddress = json['ResidentialAddress'];
    assignedTo = json['AssignedTo'];
    sourceName = json['SourceName'];
    mediumName = json['MediumName'];
    campaignName = json['CampaignName'];
    remark = json['remark'];
    followupStatus = json['FollowupStatus'];
    createdOn = json['CreatedOn'];
    modifiedon = json['modifiedon'];
    followupdate = json['followupdate'];
    createdBy = json['CreatedBy'];
    modifiedBy = json['ModifiedBy'];
    officeaddress = json['officeaddress'];
    countrycode3 = json['countrycode3'];
    assignId = json['assign_id'];
    sourceId = json['source_id'];
    mediumId = json['medium_id'];
    campId = json['camp_id'];
    followStatusId = json['follow_status_id'];
    products = json['Products'];
    amountPaid = json['AmountPaid'];
    imgExt = json['img_ext'];
    initialRemarks = json['InitialRemarks'];
    whereAddress = json['WhereAddress'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    tagNames = json['TagNames'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadNo'] = this.leadNo;
    data['PersonName'] = this.personName;
    data['CompanyName'] = this.companyName;
    data['CountryCode'] = this.countryCode;
    data['CountryCode1'] = this.countryCode1;
    data['CountryCode2'] = this.countryCode2;
    data['MobileNo'] = this.mobileNo;
    data['MobileNo1'] = this.mobileNo1;
    data['MobileNo2'] = this.mobileNo2;
    data['EmailID'] = this.emailID;
    data['EmailID1'] = this.emailID1;
    data['EmailID2'] = this.emailID2;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['PinCode'] = this.pinCode;
    data['ResidentialAddress'] = this.residentialAddress;
    data['AssignedTo'] = this.assignedTo;
    data['SourceName'] = this.sourceName;
    data['MediumName'] = this.mediumName;
    data['CampaignName'] = this.campaignName;
    data['remark'] = this.remark;
    data['FollowupStatus'] = this.followupStatus;
    data['CreatedOn'] = this.createdOn;
    data['modifiedon'] = this.modifiedon;
    data['followupdate'] = this.followupdate;
    data['CreatedBy'] = this.createdBy;
    data['ModifiedBy'] = this.modifiedBy;
    data['officeaddress'] = this.officeaddress;
    data['countrycode3'] = this.countrycode3;
    data['assign_id'] = this.assignId;
    data['source_id'] = this.sourceId;
    data['medium_id'] = this.mediumId;
    data['camp_id'] = this.campId;
    data['follow_status_id'] = this.followStatusId;
    data['Products'] = this.products;
    data['AmountPaid'] = this.amountPaid;
    data['img_ext'] = this.imgExt;
    data['InitialRemarks'] = this.initialRemarks;
    data['WhereAddress'] = this.whereAddress;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['TagNames'] = this.tagNames;
    return data;
  }
}

class CustomFields {
  String? name1;
  String? name2;
  String? name3;
  String? name4;
  String? test12;
  String? test06;
  String? test07;
  String? test08;
  String? test11;
  String? test10;
  String? dateofbirth;
  String? budget;
  String? project;
  String? alpha;
  String? yujhu;
  String? newfield;
  String? test13;
  String? test14;
  String? test15;
  String? test16;
  String? test17;
  String? test18;
  String? test19;
  String? test20;
  String? test21;
  String? test22;
  String? test23;
  String? test24;
  String? test25;
  String? test26;
  String? test36;
  String? test27;
  String? test28;
  String? test29;
  String? test30;
  String? test31;
  String? test32;
  String? test33;
  String? test34;
  String? test35;
  String? uNGALI;
  String? yes;
  String? abcd;
  String? dOBPAN;
  String? nEWMOBILE;
  String? nAMEONE;
  String? anotherName;
  String? anotherAddress;
  String? anotherAge;
  String? anotherDateOfBirth;
  String? anotherGenderField;
  String? anotherAcceptTermCondition;
  String? anotherBranch;
  String? anotherHobby;

  CustomFields(
      {this.name1,
      this.name2,
      this.name3,
      this.name4,
      this.test12,
      this.test06,
      this.test07,
      this.test08,
      this.test11,
      this.test10,
      this.dateofbirth,
      this.budget,
      this.project,
      this.alpha,
      this.yujhu,
      this.newfield,
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
      this.test36,
      this.test27,
      this.test28,
      this.test29,
      this.test30,
      this.test31,
      this.test32,
      this.test33,
      this.test34,
      this.test35,
      this.uNGALI,
      this.yes,
      this.abcd,
      this.dOBPAN,
      this.nEWMOBILE,
      this.nAMEONE,
      this.anotherName,
      this.anotherAddress,
      this.anotherAge,
      this.anotherDateOfBirth,
      this.anotherGenderField,
      this.anotherAcceptTermCondition,
      this.anotherBranch,
      this.anotherHobby});

  CustomFields.fromJson(Map<String, dynamic> json) {
    name1 = json['Name1'];
    name2 = json['Name2'];
    name3 = json['Name3'];
    name4 = json['Name4'];
    test12 = json['test12'];
    test06 = json['test06'];
    test07 = json['test07'];
    test08 = json['test08'];
    test11 = json['test11'];
    test10 = json['test10'];
    dateofbirth = json['dateofbirth'];
    budget = json['Budget'];
    project = json['project'];
    alpha = json['alpha'];
    yujhu = json['yujhu'];
    newfield = json['newfield'];
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
    test36 = json['test36'];
    test27 = json['test27'];
    test28 = json['test28'];
    test29 = json['test29'];
    test30 = json['test30'];
    test31 = json['test31'];
    test32 = json['test32'];
    test33 = json['test33'];
    test34 = json['test34'];
    test35 = json['test35'];
    uNGALI = json['UNGALI'];
    yes = json['Yes'];
    abcd = json['abcd'];
    dOBPAN = json['DOBPAN'];
    nEWMOBILE = json['NEWMOBILE'];
    nAMEONE = json['NAMEONE'];
    anotherName = json['Another-Name'];
    anotherAddress = json['Another-Address'];
    anotherAge = json['Another-Age'];
    anotherDateOfBirth = json['Another-Date-of-birth'];
    anotherGenderField = json['Another-Gender-Field'];
    anotherAcceptTermCondition = json['Another-Accept-Term-Condition'];
    anotherBranch = json['Another-Branch'];
    anotherHobby = json['Another-Hobby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name1'] = this.name1;
    data['Name2'] = this.name2;
    data['Name3'] = this.name3;
    data['Name4'] = this.name4;
    data['test12'] = this.test12;
    data['test06'] = this.test06;
    data['test07'] = this.test07;
    data['test08'] = this.test08;
    data['test11'] = this.test11;
    data['test10'] = this.test10;
    data['dateofbirth'] = this.dateofbirth;
    data['Budget'] = this.budget;
    data['project'] = this.project;
    data['alpha'] = this.alpha;
    data['yujhu'] = this.yujhu;
    data['newfield'] = this.newfield;
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
    data['test36'] = this.test36;
    data['test27'] = this.test27;
    data['test28'] = this.test28;
    data['test29'] = this.test29;
    data['test30'] = this.test30;
    data['test31'] = this.test31;
    data['test32'] = this.test32;
    data['test33'] = this.test33;
    data['test34'] = this.test34;
    data['test35'] = this.test35;
    data['UNGALI'] = this.uNGALI;
    data['Yes'] = this.yes;
    data['abcd'] = this.abcd;
    data['DOBPAN'] = this.dOBPAN;
    data['NEWMOBILE'] = this.nEWMOBILE;
    data['NAMEONE'] = this.nAMEONE;
    data['Another-Name'] = this.anotherName;
    data['Another-Address'] = this.anotherAddress;
    data['Another-Age'] = this.anotherAge;
    data['Another-Date-of-birth'] = this.anotherDateOfBirth;
    data['Another-Gender-Field'] = this.anotherGenderField;
    data['Another-Accept-Term-Condition'] = this.anotherAcceptTermCondition;
    data['Another-Branch'] = this.anotherBranch;
    data['Another-Hobby'] = this.anotherHobby;
    return data;
  }
}

class DealStageList {
  String? leadPipeLineStatusId;
  String? leadId;
  String? pipelineID;
  String? pipeLineName;
  String? pipeLineStageID;
  String? pipeLineStageName;
  double? amount;
  double? probability;
  String? fullName;
  Null? owner;
  String? profileImgFileName;
  String? createdDate;
  String? createdBy;

  DealStageList(
      {this.leadPipeLineStatusId,
      this.leadId,
      this.pipelineID,
      this.pipeLineName,
      this.pipeLineStageID,
      this.pipeLineStageName,
      this.amount,
      this.probability,
      this.fullName,
      this.owner,
      this.profileImgFileName,
      this.createdDate,
      this.createdBy});

  DealStageList.fromJson(Map<String, dynamic> json) {
    leadPipeLineStatusId = json['LeadPipeLineStatusId'];
    leadId = json['LeadId'];
    pipelineID = json['PipelineID'];
    pipeLineName = json['PipeLineName'];
    pipeLineStageID = json['PipeLineStageID'];
    pipeLineStageName = json['PipeLineStageName'];
    amount = json['Amount'];
    probability = json['Probability'];
    fullName = json['FullName'];
    owner = json['Owner'];
    profileImgFileName = json['ProfileImgFileName'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadPipeLineStatusId'] = this.leadPipeLineStatusId;
    data['LeadId'] = this.leadId;
    data['PipelineID'] = this.pipelineID;
    data['PipeLineName'] = this.pipeLineName;
    data['PipeLineStageID'] = this.pipeLineStageID;
    data['PipeLineStageName'] = this.pipeLineStageName;
    data['Amount'] = this.amount;
    data['Probability'] = this.probability;
    data['FullName'] = this.fullName;
    data['Owner'] = this.owner;
    data['ProfileImgFileName'] = this.profileImgFileName;
    data['CreatedDate'] = this.createdDate;
    data['CreatedBy'] = this.createdBy;
    return data;
  }
}
