class EnquiryListModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  EnquiryListModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  EnquiryListModel.fromJson(Map<String, dynamic> json) {
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
  int? totalRecords;
  List<Data>? data;

  Details({this.totalRecords, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRecords'] = this.totalRecords;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? enquiryId;
  String? personName;
  String? image;
  bool? isOpen;
  Null? latitude;
  Null? longitude;
  String? createdDate;
  String? csvMobileNo;
  String? csvEmailId;
  String? companyName;
  String? initialRemarks;

  Data(
      {this.enquiryId,
      this.personName,
      this.image,
      this.isOpen,
      this.latitude,
      this.longitude,
      this.createdDate,
      this.csvMobileNo,
      this.csvEmailId,
      this.companyName,
      this.initialRemarks});

  Data.fromJson(Map<String, dynamic> json) {
    enquiryId = json['EnquiryId'];
    personName = json['PersonName'];
    image = json['Image'];
    isOpen = json['IsOpen'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    createdDate = json['CreatedDate'];
    csvMobileNo = json['CsvMobileNo'];
    csvEmailId = json['CsvEmailId'];
    companyName = json['CompanyName'];
    initialRemarks = json['InitialRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EnquiryId'] = this.enquiryId;
    data['PersonName'] = this.personName;
    data['Image'] = this.image;
    data['IsOpen'] = this.isOpen;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['CreatedDate'] = this.createdDate;
    data['CsvMobileNo'] = this.csvMobileNo;
    data['CsvEmailId'] = this.csvEmailId;
    data['CompanyName'] = this.companyName;
    data['InitialRemarks'] = this.initialRemarks;
    return data;
  }
}
