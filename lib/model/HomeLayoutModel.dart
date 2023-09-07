// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class HomeModel {
  bool status;
  dataDetails data;
  HomeModel({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'data': data.toMap(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      status: map['status'] as bool,
      data: dataDetails.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class dataDetails {
  List<BannersDetails> banners = [];
  List<ProductsDetails> products = [];
  dataDetails({
    required this.banners,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'banners': banners.map((x) => x.toMap()).toList(),
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory dataDetails.fromMap(Map<String, dynamic> map) {
    return dataDetails(
      banners: List<BannersDetails>.from(
        (map['banners'] as List<dynamic>).map<BannersDetails>(
          (x) => BannersDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      products: List<ProductsDetails>.from(
        (map['products'] as List<dynamic>).map<ProductsDetails>(
          (x) => ProductsDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory dataDetails.fromJson(String source) =>
      dataDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BannersDetails {
  int id;
  String image;
  BannersDetails({
    required this.id,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
    };
  }

  factory BannersDetails.fromMap(Map<String, dynamic> map) {
    return BannersDetails(
      id: map['id'] as int,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannersDetails.fromJson(String source) =>
      BannersDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductsDetails {
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  String description;
  bool in_favorites;
  bool in_cart;
  ProductsDetails({
    required this.id,
    required this.price,
    required this.old_price,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.in_favorites,
    required this.in_cart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'old_price': old_price,
      'discount': discount,
      'image': image,
      'name': name,
      'in_favorites': in_favorites,
      'in_cart': in_cart,
    };
  }

  factory ProductsDetails.fromMap(Map<String, dynamic> map) {
    return ProductsDetails(
      id: map['id'] as int,
      price: map['price'] as dynamic,
      old_price: map['old_price'] as dynamic,
      discount: map['discount'] as dynamic,
      image: map['image'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      in_favorites: map['in_favorites'] as bool,
      in_cart: map['in_cart'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsDetails.fromJson(String source) =>
      ProductsDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
