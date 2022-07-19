class NotificationItem {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Details? details;

  NotificationItem(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  NotificationItem.fromJson(Map<String, dynamic> json) {
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
  int? rowNumber;
  int? batchNotificationId;
  String? title;
  String? messageText;
  String? imageUrl;
  String? clickActionUrl;
  Null? batchSentTime;
  int? totalRecords;
  int? isProcessed;
  int? retries;
  String? lastStatus;
  String? createdOn;
  int? createdBy;
  String? isAuto;

  Data(
      {this.rowNumber,
      this.batchNotificationId,
      this.title,
      this.messageText,
      this.imageUrl,
      this.clickActionUrl,
      this.batchSentTime,
      this.totalRecords,
      this.isProcessed,
      this.retries,
      this.lastStatus,
      this.createdOn,
      this.createdBy,
      this.isAuto});

  Data.fromJson(Map<String, dynamic> json) {
    rowNumber = json['RowNumber'];
    batchNotificationId = json['BatchNotification_Id'];
    title = json['Title'];
    messageText = json['MessageText'];
    imageUrl = json['ImageUrl'];
    clickActionUrl = json['ClickActionUrl'];
    batchSentTime = json['BatchSentTime'];
    totalRecords = json['TotalRecords'];
    isProcessed = json['IsProcessed'];
    retries = json['Retries'];
    lastStatus = json['LastStatus'];
    createdOn = json['CreatedOn'];
    createdBy = json['CreatedBy'];
    isAuto = json['IsAuto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNumber'] = this.rowNumber;
    data['BatchNotification_Id'] = this.batchNotificationId;
    data['Title'] = this.title;
    data['MessageText'] = this.messageText;
    data['ImageUrl'] = this.imageUrl;
    data['ClickActionUrl'] = this.clickActionUrl;
    data['BatchSentTime'] = this.batchSentTime;
    data['TotalRecords'] = this.totalRecords;
    data['IsProcessed'] = this.isProcessed;
    data['Retries'] = this.retries;
    data['LastStatus'] = this.lastStatus;
    data['CreatedOn'] = this.createdOn;
    data['CreatedBy'] = this.createdBy;
    data['IsAuto'] = this.isAuto;
    return data;
  }
}