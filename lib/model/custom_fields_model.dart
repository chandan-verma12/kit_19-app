class CustomFeildsModel {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Details>? details;

  CustomFeildsModel(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  CustomFeildsModel.fromJson(Map<String, dynamic> json) {
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
  double? sNo;
  String? fieldName;
  String? dataType;
  String? displayName;
  String? defultValue;
  String? controlType;
  bool? isVisible;
  bool? isRequired;
  int? maxLength;
  String? maximum;
  String? minimum;
  String? options;
  String? fieldType;
  int? fieldId;

  Details(
      {this.sNo,
      this.fieldName,
      this.dataType,
      this.displayName,
      this.defultValue,
      this.controlType,
      this.isVisible,
      this.isRequired,
      this.maxLength,
      this.maximum,
      this.minimum,
      this.options,
      this.fieldType,
      this.fieldId});

  Details.fromJson(Map<String, dynamic> json) {
    sNo = json['SNo'];
    fieldName = json['FieldName'];
    dataType = json['DataType'];
    displayName = json['DisplayName'];
    defultValue = json['DefultValue'];
    controlType = json['ControlType'];
    isVisible = json['IsVisible'];
    isRequired = json['IsRequired'];
    maxLength = json['MaxLength'];
    maximum = json['Maximum'];
    minimum = json['Minimum'];
    options = json['Options'];
    fieldType = json['FieldType'];
    fieldId = json['FieldId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SNo'] = this.sNo;
    data['FieldName'] = this.fieldName;
    data['DataType'] = this.dataType;
    data['DisplayName'] = this.displayName;
    data['DefultValue'] = this.defultValue;
    data['ControlType'] = this.controlType;
    data['IsVisible'] = this.isVisible;
    data['IsRequired'] = this.isRequired;
    data['MaxLength'] = this.maxLength;
    data['Maximum'] = this.maximum;
    data['Minimum'] = this.minimum;
    data['Options'] = this.options;
    data['FieldType'] = this.fieldType;
    data['FieldId'] = this.fieldId;
    return data;
  }
}
