class WhatsappConversationList {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Details>? details;

  WhatsappConversationList(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  WhatsappConversationList.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? sId;
  Sender? sender;
  int? rId;
  Sender? recipient;
  String? entityId;
  String? text;
  String? channelName;
  String? createdOn;
  String? direction;
  String? source;
  Null? referal;
  bool? isClickable;
  String? messageType;
  String? parentId;
  String? agentName;
  String? agentImage;
  String? status;
  Null? statusList;
  String? sendMessageBody;
  String? sendMessageType;
  String? sendMessageDatetime;
  String? requestJSON;
  String? labelJSON;
  Null? personEntityName;
  Null? personEntityId;
  bool? isDeleted;
  String? deletedBy;
  String? deletedOn;

  Details(
      {this.id,
      this.sId,
      this.sender,
      this.rId,
      this.recipient,
      this.entityId,
      this.text,
      this.channelName,
      this.createdOn,
      this.direction,
      this.source,
      this.referal,
      this.isClickable,
      this.messageType,
      this.parentId,
      this.agentName,
      this.agentImage,
      this.status,
      this.statusList,
      this.sendMessageBody,
      this.sendMessageType,
      this.sendMessageDatetime,
      this.requestJSON,
      this.labelJSON,
      this.personEntityName,
      this.personEntityId,
      this.isDeleted,
      this.deletedBy,
      this.deletedOn});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    sId = json['sId'];
    sender =
        json['Sender'] != null ? new Sender.fromJson(json['Sender']) : null;
    rId = json['rId'];
    recipient = json['Recipient'] != null
        ? new Sender.fromJson(json['Recipient'])
        : null;
    entityId = json['EntityId'];
    text = json['Text'];
    channelName = json['ChannelName'];
    createdOn = json['CreatedOn'];
    direction = json['Direction'];
    source = json['Source'];
    referal = json['Referal'];
    isClickable = json['IsClickable'];
    messageType = json['MessageType'];
    parentId = json['ParentId'];
    agentName = json['AgentName'];
    agentImage = json['AgentImage'];
    status = json['Status'];
    statusList = json['StatusList'];
    sendMessageBody = json['SendMessageBody'];
    sendMessageType = json['SendMessageType'];
    sendMessageDatetime = json['SendMessageDatetime'];
    requestJSON = json['RequestJSON'];
    labelJSON = json['LabelJSON'];
    personEntityName = json['PersonEntityName'];
    personEntityId = json['PersonEntityId'];
    isDeleted = json['IsDeleted'];
    deletedBy = json['DeletedBy'];
    deletedOn = json['DeletedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['sId'] = this.sId;
    if (this.sender != null) {
      data['Sender'] = this.sender!.toJson();
    }
    data['rId'] = this.rId;
    if (this.recipient != null) {
      data['Recipient'] = this.recipient!.toJson();
    }
    data['EntityId'] = this.entityId;
    data['Text'] = this.text;
    data['ChannelName'] = this.channelName;
    data['CreatedOn'] = this.createdOn;
    data['Direction'] = this.direction;
    data['Source'] = this.source;
    data['Referal'] = this.referal;
    data['IsClickable'] = this.isClickable;
    data['MessageType'] = this.messageType;
    data['ParentId'] = this.parentId;
    data['AgentName'] = this.agentName;
    data['AgentImage'] = this.agentImage;
    data['Status'] = this.status;
    data['StatusList'] = this.statusList;
    data['SendMessageBody'] = this.sendMessageBody;
    data['SendMessageType'] = this.sendMessageType;
    data['SendMessageDatetime'] = this.sendMessageDatetime;
    data['RequestJSON'] = this.requestJSON;
    data['LabelJSON'] = this.labelJSON;
    data['PersonEntityName'] = this.personEntityName;
    data['PersonEntityId'] = this.personEntityId;
    data['IsDeleted'] = this.isDeleted;
    data['DeletedBy'] = this.deletedBy;
    data['DeletedOn'] = this.deletedOn;
    return data;
  }
}

class Sender {
  int? id;
  String? personName;
  String? profileImgFileName;
  String? source;
  String? mobileNo;

  Sender(
      {this.id,
      this.personName,
      this.profileImgFileName,
      this.source,
      this.mobileNo});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    personName = json['PersonName'];
    profileImgFileName = json['ProfileImgFileName'];
    source = json['Source'];
    mobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['PersonName'] = this.personName;
    data['ProfileImgFileName'] = this.profileImgFileName;
    data['Source'] = this.source;
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}
