// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:shopapp/model/LoginModel.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class changeIconState extends RegisterState {}

class LoadingRegisterstate extends RegisterState {}

class SuccsesfullRegisterState extends RegisterState {
  final Loginmodel Registerdata;
  SuccsesfullRegisterState({
    required this.Registerdata,
  });
}

class ErrorRegisterState extends RegisterState {
  String error;
  ErrorRegisterState({
    required this.error,
  });
}
