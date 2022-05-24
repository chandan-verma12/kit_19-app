class FollowUpProductsResponse {
  int? status;
  String? message;
  int? locationTrackingFrequency;
  String? timsStamp;
  List<Product>? products;

  FollowUpProductsResponse(
      {this.status,
      this.message,
      this.locationTrackingFrequency,
      this.timsStamp,
      this.products});

  FollowUpProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    message = json["Message"];
    locationTrackingFrequency = json["LocationTrackingFrequency"];
    timsStamp = json["TimsStamp"];
    products = json["Details"] == null
        ? null
        : (json["Details"] as List).map((e) => Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Status"] = status;
    data["Message"] = message;
    data["LocationTrackingFrequency"] = locationTrackingFrequency;
    data["TimsStamp"] = timsStamp;
    if (products != null) {
      data["Details"] = products?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? image;
  String? description;
  dynamic price;
  bool isChecked = false;

  Product({this.id, this.name, this.image, this.description, this.price});

  Product.fromJson(Map<String, dynamic> json) {
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
