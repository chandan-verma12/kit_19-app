class Country {
  String? e164Cc;
  String? iso2Cc;
  int? e164Sc;
  bool? geographic;
  int? level;
  String? name;
  String? example;
  String? displayName;
  String? fullExampleWithPlusSign;
  String? displayNameNoE164Cc;
  String? e164Key;

  Country(
      {this.e164Cc,
      this.iso2Cc,
      this.e164Sc,
      this.geographic,
      this.level,
      this.name,
      this.example,
      this.displayName,
      this.fullExampleWithPlusSign,
      this.displayNameNoE164Cc,
      this.e164Key});

  Country.fromJson(Map<String, dynamic> json) {
    e164Cc = json["e164_cc"];
    iso2Cc = json["iso2_cc"];
    e164Sc = json["e164_sc"];
    geographic = json["geographic"];
    level = json["level"];
    name = json["name"];
    example = json["example"];
    displayName = json["display_name"];
    fullExampleWithPlusSign = json["full_example_with_plus_sign"];
    displayNameNoE164Cc = json["display_name_no_e164_cc"];
    e164Key = json["e164_key"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["e164_cc"] = e164Cc;
    data["iso2_cc"] = iso2Cc;
    data["e164_sc"] = e164Sc;
    data["geographic"] = geographic;
    data["level"] = level;
    data["name"] = name;
    data["example"] = example;
    data["display_name"] = displayName;
    data["full_example_with_plus_sign"] = fullExampleWithPlusSign;
    data["display_name_no_e164_cc"] = displayNameNoE164Cc;
    data["e164_key"] = e164Key;
    return data;
  }
}
