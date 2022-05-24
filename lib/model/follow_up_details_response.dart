class FollowUpDetailsResponse {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  FollowUpDtls? details;

  FollowUpDetailsResponse(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  FollowUpDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    details =
        json["Details"] == null ? null : FollowUpDtls.fromJson(json["Details"]);
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

class FollowUpDtls {
  int? id;
  String? status;
  String? remarks;
  String? followupDate;
  String? createdOn;
  dynamic amount;
  bool? isReassign;
  Lead? lead;
  List<Products>? products;
  AssignTo? assignTo;
  Creator? creator;
  bool? isEditable;
  bool? isRemoval;

  FollowUpDtls(
      {this.id,
      this.status,
      this.remarks,
      this.followupDate,
      this.createdOn,
      this.amount,
      this.isReassign,
      this.lead,
      this.products,
      this.assignTo,
      this.creator,
      this.isEditable,
      this.isRemoval});

  FollowUpDtls.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    status = json["Status"];
    remarks = json["Remarks"];
    followupDate = json["FollowupDate"];
    createdOn = json["CreatedOn"];
    amount = json["Amount"];
    isReassign = json["IsReassign"];
    lead = json["Lead"] == null ? null : Lead.fromJson(json["Lead"]);
    products = json["Products"] == null
        ? null
        : (json["Products"] as List).map((e) => Products.fromJson(e)).toList();
    assignTo =
        json["AssignTo"] == null ? null : AssignTo.fromJson(json["AssignTo"]);
    creator =
        json["Creator"] == null ? null : Creator.fromJson(json["Creator"]);
    isEditable = json["IsEditable"];
    isRemoval = json["IsRemoval"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Status"] = status;
    data["Remarks"] = remarks;
    data["FollowupDate"] = followupDate;
    data["CreatedOn"] = createdOn;
    data["Amount"] = amount;
    data["IsReassign"] = isReassign;
    if (lead != null) {
      data["Lead"] = lead?.toJson();
    }
    if (products != null) {
      data["Products"] = products?.map((e) => e.toJson()).toList();
    }
    if (assignTo != null) {
      data["AssignTo"] = assignTo?.toJson();
    }
    if (creator != null) {
      data["Creator"] = creator?.toJson();
    }
    data["IsEditable"] = isEditable;
    data["IsRemoval"] = isRemoval;
    return data;
  }
}

class Creator {
  int? id;
  String? firstName;
  dynamic? lastName;
  String? userName;
  String? image;
  String? displayName;

  Creator(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.displayName});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    firstName = json["FirstName"];
    lastName = json["LastName"];
    userName = json["UserName"];
    image = json["Image"];
    displayName = json["DisplayName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["FirstName"] = firstName;
    data["LastName"] = lastName;
    data["UserName"] = userName;
    data["Image"] = image;
    data["DisplayName"] = displayName;
    return data;
  }
}

class AssignTo {
  int? id;
  String? firstName;
  dynamic? lastName;
  String? userName;
  String? image;
  String? displayName;

  AssignTo(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.displayName});

  AssignTo.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    firstName = json["FirstName"];
    lastName = json["LastName"];
    userName = json["UserName"];
    image = json["Image"];
    displayName = json["DisplayName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["FirstName"] = firstName;
    data["LastName"] = lastName;
    data["UserName"] = userName;
    data["Image"] = image;
    data["DisplayName"] = displayName;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? image;
  String? description;
  dynamic price;

  Products({this.id, this.name, this.image, this.description, this.price});

  Products.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    name = json["Name"];
    image = json["Image"];
    description = json["Description"];
    price = json["Price"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Name"] = name;
    data["Image"] = image;
    data["Description"] = description;
    data["Price"] = price;
    return data;
  }
}

class Lead {
  int? id;
  String? name;
  String? image;

  Lead({this.id, this.name, this.image});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    name = json["Name"];
    image = json["Image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = id;
    data["Name"] = name;
    data["Image"] = image;
    return data;
  }
}
