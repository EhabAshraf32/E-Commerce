// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetFavourites {
  bool status;
  Data data;
  GetFavourites({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'data': data.toMap(),
    };
  }

  factory GetFavourites.fromMap(Map<String, dynamic> map) {
    return GetFavourites(
      status: map['status'] as bool,
      data: Data.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetFavourites.fromJson(String source) =>
      GetFavourites.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Data {
  List<Data1> data = [];
  Data({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      data: List<Data1>.from(
        (map['data'] as List<dynamic>).map<Data1>(
          (x) => Data1.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Data1 {
  int id;
  ProductDetails product;
  Data1({
    required this.id,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product.toMap(),
    };
  }

  factory Data1.fromMap(Map<String, dynamic> map) {
    return Data1(
      id: map['id'] as int,
      product: ProductDetails.fromMap(map['product'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data1.fromJson(String source) =>
      Data1.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductDetails {
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  ProductDetails({
    required this.id,
    required this.price,
    required this.old_price,
    required this.discount,
    required this.image,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'old_price': old_price,
      'discount': discount,
      'image': image,
      'name': name,
    };
  }

  factory ProductDetails.fromMap(Map<String, dynamic> map) {
    return ProductDetails(
      id: map['id'] as int,
      price: map['price'] as dynamic,
      old_price: map['old_price'] as dynamic,
      discount: map['discount'] as dynamic,
      image: map['image'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetails.fromJson(String source) =>
      ProductDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
