// ignore_for_file: file_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class CategoriesModel {
  bool statues;
  CategoriesDataModel data;
  CategoriesModel({
    required this.statues,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statues': statues,
      'data': data.toMap(),
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      statues: map['statues'] as bool,
      data: CategoriesDataModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CategoriesDataModel {
  int current_page;
  List<DataDetails> data = [];
  CategoriesDataModel({
    required this.current_page,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_page': current_page,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoriesDataModel.fromMap(Map<String, dynamic> map) {
    return CategoriesDataModel(
      current_page: map['current_page'] as int,
      data: List<DataDetails>.from(
        (map['data'] as List<dynamic>).map<DataDetails>(
          (x) => DataDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesDataModel.fromJson(String source) =>
      CategoriesDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DataDetails {
  int id;
  String name;
  String image;
  DataDetails({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory DataDetails.fromMap(Map<String, dynamic> map) {
    return DataDetails(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataDetails.fromJson(String source) =>
      DataDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
