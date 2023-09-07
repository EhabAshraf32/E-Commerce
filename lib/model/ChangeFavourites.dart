import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChangeFavourites {
  bool status;
  String message;
  ChangeFavourites({
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
    };
  }

  factory ChangeFavourites.fromMap(Map<String, dynamic> map) {
    return ChangeFavourites(
      status: map['status'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeFavourites.fromJson(String source) =>
      ChangeFavourites.fromMap(json.decode(source) as Map<String, dynamic>);
}
