class NavMenuBalance {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  Balance? details;

  NavMenuBalance(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.details});

  NavMenuBalance.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    details =
        json["Details"] == null ? null : Balance.fromJson(json["Details"]);
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

class Balance {
  dynamic intCreditBalance;
  dynamic mailCreditBalance;
  dynamic smsCreditBalance;

  Balance(
      {this.intCreditBalance, this.mailCreditBalance, this.smsCreditBalance});

  Balance.fromJson(Map<String, dynamic> json) {
    intCreditBalance = json["IntCreditBalance"];
    mailCreditBalance = json["MailCreditBalance"];
    smsCreditBalance = json["SmsCreditBalance"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["IntCreditBalance"] = intCreditBalance;
    data["MailCreditBalance"] = mailCreditBalance;
    data["SmsCreditBalance"] = smsCreditBalance;
    return data;
  }
}
