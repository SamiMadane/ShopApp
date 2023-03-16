// هاد الكلام كلو مش انا يلي كتبتو بايدي
//اخدت ال json الخاص بال getFvavorites وحطيتها بموقع اسمه json to dart
// انا هنا عدلت عليه بكم شغلة وخلص

class SearchModel {
  late bool? status;
  late String? message;
  late Data? data;


  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late int? currentPage;
  late List<Product> data;
  late String? firstPageUrl;
  late int? from;
  late int? lastPage;
  late String? lastPageUrl;
  late Null nextPageUrl;
  late String? path;
  late int? perPage;
  late Null prevPageUrl;
  late int? to;
  late int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data.add(Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}



class Product {
  late int? id;
  dynamic price;
  dynamic oldPrice;
  late int? discount;
  late String? image;
  late String? name;
  late String? description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
