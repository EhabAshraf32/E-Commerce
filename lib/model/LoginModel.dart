// ignore_for_file: empty_constructor_bodies

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Loginmodel {
  bool status;
  String message;
  Userdate? data;
  Loginmodel({
    required this.status,
    required this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory Loginmodel.fromMap(Map<String, dynamic> map) {
    return Loginmodel(
        status: map['status'] as bool,
        message: map['message'] as String,
        data: map['data'] != null
            ? Userdate.fromMap(map['data'] as Map<String, dynamic>)
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Loginmodel.fromJson(String source) =>
      Loginmodel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Userdate {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String? token;
  Userdate({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'points': points,
      'credit': credit,
      'token': token,
    };
  }

  factory Userdate.fromMap(Map<String, dynamic> map) {
    return Userdate(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      image: map['image'] as String,
      points: map['points'] as int,
      credit: map['credit'] as int,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Userdate.fromJson(String source) =>
      Userdate.fromMap(json.decode(source) as Map<String, dynamic>);
}
