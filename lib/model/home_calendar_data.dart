class HomeCalendarData {
  HomeCalendarData({
    int? status,
    String? message,
    int? locationTrackingFrequency,
    String? timsStamp,
    Details? details,
  }) {
    _status = status;
    _message = message;
    _locationTrackingFrequency = locationTrackingFrequency;
    _timsStamp = timsStamp;
    _details = details;
  }

  HomeCalendarData.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _locationTrackingFrequency = json['LocationTrackingFrequency'];
    _timsStamp = json['TimsStamp'];
    _details =
        json['Details'] != null ? Details.fromJson(json['Details']) : null;
  }
  int? _status;
  String? _message;
  int? _locationTrackingFrequency;
  String? _timsStamp;
  Details? _details;

  int? get status => _status;
  String? get message => _message;
  int? get locationTrackingFrequency => _locationTrackingFrequency;
  String? get timsStamp => _timsStamp;
  Details? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    map['LocationTrackingFrequency'] = _locationTrackingFrequency;
    map['TimsStamp'] = _timsStamp;
    if (_details != null) {
      map['Details'] = _details?.toJson();
    }
    return map;
  }
}

class Details {
  Details(
      {List<Tasks>? tasks,
      List<Tasks>? appointments,
      List<Tasks>? followUps,
      List<Tasks>? callLogs,
      List<DateIndicator>? dateIndicators}) {
    _tasks = tasks;
    _appointments = appointments;
    _followUps = followUps;
    _callLogs = callLogs;
    _dateIndicators = dateIndicators;
  }

  Details.fromJson(dynamic json) {
    if (json['Tasks'] != null) {
      _tasks = [];
      json['Tasks'].forEach((v) {
        _tasks?.add(Tasks.fromJson(v));
      });
    }
    if (json['Appointments'] != null) {
      _appointments = [];
      json['Appointments'].forEach((v) {
        _appointments?.add(Tasks.fromJson(v));
      });
    }
    if (json['FollowUps'] != null) {
      _followUps = [];
      json['FollowUps'].forEach((v) {
        _followUps?.add(Tasks.fromJson(v));
      });
    }
    if (json['CallLogs'] != null) {
      _callLogs = [];
      json['CallLogs'].forEach((v) {
        _callLogs?.add(Tasks.fromJson(v));
      });
    }
    if (json['DateIndicators'] != null) {
      _dateIndicators = [];
      json['DateIndicators'].forEach((v) {
        _dateIndicators?.add(DateIndicator.fromJson(v));
      });
    }
  }
  List<Tasks>? _tasks;
  List<Tasks>? _appointments;
  List<Tasks>? _followUps;
  List<Tasks>? _callLogs;
  List<DateIndicator>? _dateIndicators;

  List<Tasks>? get tasks => _tasks;
  List<Tasks>? get appointments => _appointments;
  List<Tasks>? get followUps => _followUps;
  List<Tasks>? get callLogs => _callLogs;
  List<DateIndicator>? get dateIndicators => _dateIndicators;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_tasks != null) {
      map['Tasks'] = _tasks?.map((v) => v.toJson()).toList();
    }
    if (_appointments != null) {
      map['Appointments'] = _appointments?.map((v) => v.toJson()).toList();
    }
    if (_followUps != null) {
      map['FollowUps'] = _followUps?.map((v) => v.toJson()).toList();
    }
    if (_callLogs != null) {
      map['CallLogs'] = _callLogs?.map((v) => v.toJson()).toList();
    }
    if (_dateIndicators != null) {
      map['DateIndicators'] = _dateIndicators?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Tasks {
  Tasks(
      {String? id,
      String? title,
      String? startDate,
      String? endDate,
      String? leadId,
      String? personName,
      String? personImage,
      String? outCome,
      String? agentId,
      String? agentImage,
      String? agentName,
      String? taskStatus,
      String? intent,
      bool? isRemoval,
      bool? isEditable}) {
    _id = id;
    _title = title;
    _startDate = startDate;
    _endDate = endDate;
    _leadId = leadId;
    _personName = personName;
    _personImage = personImage;
    _outCome = outCome;
    _agentId = agentId;
    _agentImage = agentImage;
    _agentName = agentName;
    _taskStatus = taskStatus;
    _intent = intent;
    _isEditable = isEditable;
    _isRemoval = isRemoval;
  }

  Tasks.fromJson(dynamic json) {
    _id = json['Id'];
    _title = json['Title'];
    _startDate = json['StartDate'];
    _endDate = json['EndDate'];
    _leadId = json['LeadId'];
    _personName = json['PersonName'];
    _personImage = json['PersonImage'];
    _outCome = json['Outcome'];
    _agentId = json['AgentId'];
    _agentImage = json['AgentImage'];
    _agentName = json['AgentName'];
    _taskStatus = json['Status'];
    _intent = json['Intent'];
    _isEditable = json['IsEditable'];
    _isRemoval = json['IsRemoval'];
  }
  String? _id;
  String? _title;
  String? _startDate;
  String? _endDate;
  String? _leadId;
  String? _personName;
  String? _personImage;
  String? _outCome;
  String? _agentId;
  String? _agentImage;
  String? _agentName;
  String? _taskStatus;
  String? _intent;
  bool? _isEditable;
  bool? _isRemoval;

  String? get id => _id;
  String? get title => _title;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get leadId => _leadId;
  String? get personName => _personName;
  String? get personImage => _personImage;
  String? get outCome => _outCome;
  String? get agentId => _agentId;
  String? get agentImage => _agentImage;
  String? get agentName => _agentName;
  String? get taskStatus => _taskStatus;
  String? get intent => _intent;
  bool? get isEditable => _isEditable;
  bool? get isRemoval => _isRemoval;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['Title'] = _title;
    map['StartDate'] = _startDate;
    map['EndDate'] = _endDate;
    map['LeadId'] = _leadId;
    map['PersonName'] = _personName;
    map['PersonImage'] = _personImage;
    map['Outcome'] = _outCome;
    map['AgentId'] = _agentId;
    map['AgentImage'] = _agentImage;
    map['AgentName'] = _agentName;
    map['Status'] = _taskStatus;
    map['Intent'] = _intent;
    map['IsEditable'] = _isEditable;
    map['IsRemoval'] = _isRemoval;
    return map;
  }
}

class DateIndicator {
  DateIndicator({String? date, String? color}) {
    _date = date;
    _color = color;
  }
  String? _date;
  String? _color;

  String? get date => _date;
  String? get color => _color;

  DateIndicator.fromJson(dynamic json) {
    _date = json['Date'];
    _color = json['ColorCode'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Date'] = _date;
    map['ColorCode'] = _color;
    return map;
  }
}
