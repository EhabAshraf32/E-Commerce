import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChangePasswordclass {
  bool status;
  String message;
  ChangePasswordclass({
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
    };
  }

  factory ChangePasswordclass.fromMap(Map<String, dynamic> map) {
    return ChangePasswordclass(
      status: map['status'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordclass.fromJson(String source) =>
      ChangePasswordclass.fromMap(json.decode(source) as Map<String, dynamic>);
}
