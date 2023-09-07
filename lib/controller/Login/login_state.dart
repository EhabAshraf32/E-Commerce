// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types

part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class changeIconState extends LoginState {}

class Loadingstate extends LoginState {}

class ChangePasswordSucessfullState extends LoginState {
  final ChangePasswordclass model;

  ChangePasswordSucessfullState({required this.model});
}

class ChangePasswordErrorState extends LoginState {
  String error;
  ChangePasswordErrorState({
    required this.error,
  });
}

class ChangePasswordLoadingState extends LoginState {}

class SuccsesfullLoginState extends LoginState {
  final Loginmodel logindata;
  SuccsesfullLoginState({
    required this.logindata,
  });
}

class ErrorLoginState extends LoginState {
  String error;
  ErrorLoginState({
    required this.error,
  });
}
